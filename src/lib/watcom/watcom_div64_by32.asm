; Watcom C runtime: Div64By32, Shl64, _Full_at_exit_rtn_, atexit_, strrchr_ and 9 more.
bits 32
%include "hockey.inc"
section s_125B3C progbits alloc exec nowrite align=1
extern AtexitCount, AtexitTable, ColorKeyEnabled, ConvertDestBuffer, ConvertPalette, ExitHook, IndexTo16Entries, IndexTo16Table
extern SpeechBankCount
global Div64By32, Shl64, _Full_at_exit_rtn_, atexit_, strrchr_, Convert565To555, Convert555To565, ConvertIndexedTo32
global Convert32To565Keyed, Convert32To555Keyed, ConvertIndexedTo16, SwapRedBlue555, Convert32To565, ConvertNibbleTo16
;-----------------------------------------------------------------------------
; Div64By32                                      125B3C  97 PC, low confidence
; Divides a 64-bit value by a 32-bit one; followed by the signed and
; remainder variants
;-----------------------------------------------------------------------------
Div64By32:
        push edx
        mov eax, dword [byte esp+08h]
        mov edx, dword [byte esp+0Ch]
        div dword [byte esp+010h]
        pop edx
        ret 0Ch
        push edx
        mov eax, dword [byte esp+08h]
        mov edx, dword [byte esp+0Ch]
        idiv dword [byte esp+010h]
        pop edx
        ret 0Ch
        push edx
        mov eax, dword [byte esp+08h]
        mov edx, dword [byte esp+0Ch]
        div dword [byte esp+010h]
        LD mov, eax, edx
        pop edx
        ret 0Ch
        push edx
        mov eax, dword [byte esp+08h]
        mov edx, dword [byte esp+0Ch]
        idiv dword [byte esp+010h]
        LD mov, eax, edx
        pop edx
        ret 0Ch
        mov eax, dword [byte esp+04h]
        add eax, dword [byte esp+0Ch]
        mov dword [esi], eax
        mov eax, dword [byte esp+08h]
        adc eax, dword [byte esp+010h]
        mov dword [byte esi+04h], eax
        ret 10h
        push ecx
        push edx
        mov eax, dword [byte esp+0Ch]
        mov edx, dword [byte esp+010h]
        mov ecx, dword [byte esp+014h]
        cmp ecx, byte 20h
        jge short .1
        shld edx, eax, cl
        shl eax, cl
        mov dword [esi], eax
        mov dword [byte esi+04h], edx
        pop edx
        pop ecx
        ret 0Ch
.1:
        sub ecx, byte 20h
        LD mov, edx, eax
        LD xor, eax, eax
        shl edx, cl
        mov dword [esi], eax
        mov dword [byte esi+04h], edx
        pop edx
        pop ecx
        ret 0Ch
        push ecx
        push edx
        mov eax, dword [byte esp+0Ch]
        mov edx, dword [byte esp+010h]
        mov ecx, dword [byte esp+014h]
        cmp ecx, byte 20h
        jge short .2
        shrd eax, edx, cl
        shr edx, cl
        mov dword [esi], eax
        mov dword [byte esi+04h], edx
        pop edx
        pop ecx
        ret 0Ch
.2:
        sub ecx, byte 20h
        LD mov, eax, edx
        LD xor, edx, edx
        shr eax, cl
        mov dword [esi], eax
        mov dword [byte esi+04h], edx
        pop edx
        pop ecx
        ret 0Ch
        push ecx
        push edx
        mov eax, dword [byte esp+0Ch]
        mov edx, dword [byte esp+010h]
        mov ecx, dword [byte esp+014h]
        cmp ecx, byte 20h
        jge short .3
        shrd eax, edx, cl
        sar edx, cl
        mov dword [esi], eax
        mov dword [byte esi+04h], edx
        pop edx
        pop ecx
        ret 0Ch
.3:
        sub ecx, byte 20h
        LD mov, eax, edx
        cdq
        sar eax, cl
        mov dword [esi], eax
        mov dword [byte esi+04h], edx
        pop edx
        pop ecx
        ret 0Ch
        push edx
        mov eax, dword [byte esp+08h]
        mov edx, dword [byte esp+0Ch]
        not eax
        not edx
        add eax, byte 1
        adc edx, byte 0
        mov dword [esi], eax
        mov dword [byte esi+04h], edx
        pop edx
        ret 8
;-----------------------------------------------------------------------------
; Shl64                                          125C56  97 PC, low confidence
; Shifts a 64-bit value left
;-----------------------------------------------------------------------------
Shl64:
        push ecx
        LD mov, ecx, edx
        cmp ecx, byte 20h
        jge short .1
        cdq
        shld edx, eax, cl
        shl eax, cl
        mov dword [esi], eax
        mov dword [byte esi+04h], edx
        pop ecx
        ret
.1:
        sub ecx, byte 20h
        LD mov, edx, eax
        LD xor, eax, eax
        shl edx, cl
        mov dword [esi], eax
        mov dword [byte esi+04h], edx
        pop ecx
        ret
;-----------------------------------------------------------------------------
; _Full_at_exit_rtn_                                           125C7B  library
; Run-time library: runs the atexit routines
;-----------------------------------------------------------------------------
_Full_at_exit_rtn_:
        push ebx
        push edx
        sub esp, byte 4
        mov ebx, dword [SpeechBankCount]
        cmp ebx, byte 21h
        je short .2
        mov dword [SpeechBankCount], 21h
        mov edx, ebx
        shl edx, 2
.1:
        test edx, edx
        je short .2
        mov eax, dword [dword edx+AtexitCount]
        sub edx, byte 4
        mov dword [esp], eax
        dec ebx
        call dword [esp]
        jmp short .1
.2:
        add esp, byte 4
        pop edx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; atexit_                                                      125CB6  library
; Run-time library atexit: registers an exit routine
;-----------------------------------------------------------------------------
atexit_:
        push ebx
        push ecx
        push edx
        mov ebx, eax
        mov edx, _Full_at_exit_rtn_
        mov ecx, dword [SpeechBankCount]
        mov dword [ExitHook], edx
        cmp ecx, byte 20h
        jge short .1
        mov eax, ecx
        xor eax, ecx
        lea edx, [byte ecx+01h]
        mov dword [nosplit ecx*4+AtexitTable], ebx
        mov dword [SpeechBankCount], edx
        pop edx
        pop ecx
        pop ebx
        ret
.1:
        mov eax, 0FFFFFFFFh
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; strrchr_                                                     125CF2  library
; Run-time library strrchr: the last place of a character in a string
;-----------------------------------------------------------------------------
strrchr_:
        push ebx
        push ecx
        mov cl, dl
        xor ebx, ebx
.1:
        cmp cl, byte [eax]
        jne short .2
        mov ebx, eax
.2:
        mov edx, eax
        mov ch, byte [edx]
        inc eax
        test ch, ch
        jne short .1
        mov eax, ebx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; Convert565To555                                125D0C  97 PC, low confidence
; Converts a run of 16-bit 5:6:5 pixels to 5:5:5
;-----------------------------------------------------------------------------
Convert565To555:
        push ecx
        push esi
        sub ebx, byte 2
        test edx, 2
        jne short .2
        cmp ebx, byte 0
        js short .2
.1:
        mov ecx, dword [eax]
        lea eax, [byte eax+04h]
        LD mov, esi, ecx
        and ecx, 0FFC0FFC0h
        shr ecx, 1
        and esi, 1F001Fh
        LD or, ecx, esi
        sub ebx, byte 2
        mov dword [edx], ecx
        lea edx, [byte edx+04h]
        jns short .1
.2:
        add ebx, byte 1
        js short .4
.3:
        mov cx, word [eax]
        lea eax, [byte eax+02h]
        shl ecx, 2
        lea edx, [byte edx+02h]
        LD add, cl, cl
        shr ecx, 3
        sub ebx, byte 1
        mov word [byte edx-02h], cx
        jns short .3
.4:
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; Convert555To565                                125D61  97 PC, low confidence
; Converts a run of 16-bit 5:5:5 pixels to 5:6:5
;-----------------------------------------------------------------------------
Convert555To565:
        push ecx
        push esi
        sub ebx, byte 2
        test edx, 2
        jne short .2
        cmp ebx, byte 0
        js short .2
.1:
        mov ecx, dword [eax]
        lea eax, [byte eax+04h]
        LD mov, esi, ecx
        and ecx, 7FE07FE0h
        LD add, ecx, ecx
        and esi, 1F001Fh
        LD or, ecx, esi
        sub ebx, byte 2
        mov dword [edx], ecx
        lea edx, [byte edx+04h]
        jns short .1
.2:
        add ebx, byte 1
        js short .4
.3:
        mov cx, word [eax]
        lea eax, [byte eax+02h]
        LD mov, esi, ecx
        and ecx, 7FE0h
        LD add, ecx, ecx
        and esi, byte 1Fh
        LD or, ecx, esi
        sub ebx, byte 1
        mov word [edx], cx
        lea edx, [byte edx+02h]
        jns short .3
.4:
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; ConvertIndexedTo32                             125DBC  97 PC, low confidence
; Converts a run of 8-bit pixels to 32-bit through the current palette
;-----------------------------------------------------------------------------
ConvertIndexedTo32:
        push ecx
        push esi
        push edi
        mov edi, dword [ConvertDestBuffer]
        LD xor, ecx, ecx
.1:
        mov cl, byte [eax]
        sub ebx, byte 1
        lea eax, [byte eax+01h]
        lea edx, [byte edx+04h]
        mov esi, dword [edi+ecx*4]
        mov dword [byte edx-04h], esi
        jg short .1
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; Convert32To565Keyed                            125DDE  97 PC, low confidence
; Converts a run of 32-bit pixels to 5:6:5, keeping transparent pixels
; transparent
;-----------------------------------------------------------------------------
Convert32To565Keyed:
        push ecx
        LD xor, ecx, ecx
.1:
        mov ecx, dword [eax]
        lea eax, [byte eax+04h]
        cmp ecx, 40000000h
        jb short .5
.2:
        shr ecx, 2
        shl cl, 2
        shr ecx, 1
        shl cx, 3
        shr ecx, 5
        cmp cx, byte 0
        je short .7
.3:
        sub ebx, byte 1
        lea edx, [byte edx+02h]
        mov word [byte edx-02h], cx
        jg short .1
        pop ecx
        ret
.4:
        mov ecx, dword [eax]
        lea eax, [byte eax+04h]
        cmp ecx, 40000000h
        jae short .2
.5:
        mov ecx, dword [ConvertPalette]
        sub ebx, byte 1
        lea edx, [byte edx+02h]
        mov word [byte edx-02h], cx
        jg short .4
        pop ecx
        ret
.6:
        mov ecx, dword [eax]
        lea eax, [byte eax+04h]
        cmp ecx, 40000000h
        jb short .5
        shr ecx, 2
        shl cl, 2
        shr ecx, 1
        shl cx, 3
        shr ecx, 5
        cmp cx, byte 0
        jne short .3
.7:
        mov ecx, dword [ColorKeyEnabled]
        sub ebx, byte 1
        lea edx, [byte edx+02h]
        mov word [byte edx-02h], cx
        jg short .6
        pop ecx
        ret
;-----------------------------------------------------------------------------
; Convert32To555Keyed                            125E68  97 PC, low confidence
; Converts a run of 32-bit pixels to 5:5:5, keeping transparent pixels
; transparent
;-----------------------------------------------------------------------------
Convert32To555Keyed:
        push ecx
        LD xor, ecx, ecx
.1:
        mov ecx, dword [eax]
        lea eax, [byte eax+04h]
        cmp ecx, 40000000h
        jb short .5
.2:
        shr ecx, 3
        shl cl, 3
        shl cx, 3
        shr ecx, 6
        and ecx, 7FFFh
        je short .7
.3:
        sub ebx, byte 1
        lea edx, [byte edx+02h]
        mov word [byte edx-02h], cx
        jg short .1
        pop ecx
        ret
.4:
        mov ecx, dword [eax]
        lea eax, [byte eax+04h]
        cmp ecx, 40000000h
        jae short .2
.5:
        LD xor, ecx, ecx
        sub ebx, byte 1
        lea edx, [byte edx+02h]
        mov word [byte edx-02h], cx
        jg short .4
        pop ecx
        ret
.6:
        mov ecx, dword [eax]
        lea eax, [byte eax+04h]
        cmp ecx, 40000000h
        jb short .5
        shr ecx, 3
        shl cl, 3
        shl cx, 3
        shr ecx, 6
        and ecx, 7FFFh
        jne short .3
.7:
        mov ecx, 1
        sub ebx, byte 1
        lea edx, [byte edx+02h]
        mov word [byte edx-02h], cx
        jg short .6
        pop ecx
        ret
;-----------------------------------------------------------------------------
; ConvertIndexedTo16                             125EED  97 PC, low confidence
; Converts a run of 8-bit pixels to 16-bit through the palette lookup table
;-----------------------------------------------------------------------------
ConvertIndexedTo16:
        push ecx
        push esi
        push edi
        push ebp
        LD mov, esi, eax
        LD mov, edi, edx
        LD mov, ebp, ebx
        LD xor, eax, eax
        LD xor, ebx, ebx
        LD xor, ecx, ecx
        LD xor, edx, edx
        sub ebp, byte 4
        test edi, 2
        jne short .2
        cmp ebp, byte 0
        js short .2
        mov al, byte [byte esi+01h]
        mov bl, byte [esi]
        mov cl, byte [byte esi+03h]
        mov dl, byte [byte esi+02h]
.1:
        mov eax, dword [nosplit eax*2+IndexTo16Table]
        lea esi, [byte esi+04h]
        mov ecx, dword [nosplit ecx*2+IndexTo16Table]
        lea edi, [byte edi+08h]
        mov ax, word [nosplit ebx*2+IndexTo16Entries]
        mov bl, byte [esi]
        mov cx, word [nosplit edx*2+IndexTo16Entries]
        mov dl, byte [byte esi+02h]
        mov dword [byte edi-08h], eax
        mov dword [byte edi-04h], ecx
        LD mov, eax, ebx
        LD mov, ecx, edx
        mov al, byte [byte esi+01h]
        sub ebp, byte 4
        mov cl, byte [byte esi+03h]
        jns short .1
.2:
        add ebp, byte 3
        js short .4
.3:
        mov dl, byte [esi]
        lea esi, [byte esi+01h]
        mov ax, word [nosplit edx*2+IndexTo16Entries]
        mov word [edi], ax
        lea edi, [byte edi+02h]
        sub ebp, byte 1
        jns short .3
.4:
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        push ecx
        push esi
        lea esi, [byte eax-01h]
        sub ebx, byte 4
        js short .6
.5:
        mov eax, dword [esi]
        mov ecx, dword [byte esi+03h]
        bswap eax
        bswap ecx
        or eax, 0FF000000h
        or ecx, 0FF000000h
        mov dword [edx], eax
        mov dword [byte edx+04h], ecx
        mov eax, dword [byte esi+06h]
        mov ecx, dword [byte esi+09h]
        bswap eax
        bswap ecx
        or eax, 0FF000000h
        or ecx, 0FF000000h
        mov dword [byte edx+08h], eax
        mov dword [byte edx+0Ch], ecx
        sub ebx, byte 4
        lea esi, [byte esi+0Ch]
        lea edx, [byte edx+010h]
        jns short .5
.6:
        add ebx, byte 3
        js short .8
.7:
        mov eax, dword [esi]
        bswap eax
        or eax, 0FF000000h
        mov dword [edx], eax
        sub ebx, byte 1
        lea esi, [byte esi+03h]
        lea edx, [byte edx+04h]
        jns short .7
.8:
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; SwapRedBlue555                                 125FE1  97 PC, low confidence
; Swaps the red and blue fields of a run of 5:5:5 pixels
;-----------------------------------------------------------------------------
SwapRedBlue555:
        push ecx
        push esi
        push edi
        sub ebx, byte 2
        js short .2
.1:
        mov ecx, dword [eax]
        LD mov, edi, ecx
        and edi, 7C007C00h
        shr edi, 0Ah
        LD mov, esi, ecx
        and esi, 83E083E0h
        LD or, edi, esi
        and ecx, 1F001Fh
        shl ecx, 0Ah
        LD or, edi, ecx
        mov dword [edx], edi
        sub ebx, byte 2
        lea eax, [byte eax+04h]
        lea edx, [byte edx+04h]
        jns short .1
.2:
        add ebx, byte 1
        js short .4
.3:
        mov cx, word [eax]
        LD mov, edi, ecx
        and edi, 7C007C00h
        shr edi, 0Ah
        LD mov, esi, ecx
        and esi, 83E083E0h
        LD or, edi, esi
        and ecx, 1F001Fh
        shl ecx, 0Ah
        LD or, edi, ecx
        mov word [edx], di
        sub ebx, byte 1
        lea eax, [byte eax+02h]
        lea edx, [byte edx+02h]
        jns short .3
.4:
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; Convert32To565                                 126052  97 PC, low confidence
; Converts a run of 32-bit pixels to 5:6:5, two at a time
;-----------------------------------------------------------------------------
Convert32To565:
        push ecx
        push esi
        LD xor, ecx, ecx
        LD xor, esi, esi
        sub ebx, byte 2
        js short .2
.1:
        mov ecx, dword [eax]
        shr ecx, 2
        shl cl, 2
        shr ecx, 1
        shl cx, 3
        shr ecx, 5
        LD mov, esi, ecx
        mov ecx, dword [byte eax+04h]
        shr ecx, 2
        shl cl, 2
        shr ecx, 1
        shl cx, 3
        shr ecx, 5
        and esi, 0FFFFh
        shl ecx, 10h
        LD or, ecx, esi
        mov dword [edx], ecx
        sub ebx, byte 2
        lea eax, [byte eax+08h]
        lea edx, [byte edx+04h]
        jns short .1
.2:
        add ebx, byte 1
        js short .4
.3:
        mov ecx, dword [eax]
        lea eax, [byte eax+04h]
        shr ecx, 2
        shl cl, 2
        shr ecx, 1
        shl cx, 3
        shr ecx, 5
        sub ebx, byte 1
        lea edx, [byte edx+02h]
        mov word [byte edx-02h], cx
        jns short .3
.4:
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; ConvertNibbleTo16                              1260C2  97 PC, low confidence
; Converts a run of 4-bit pixels to 16-bit through the palette lookup table
;-----------------------------------------------------------------------------
ConvertNibbleTo16:
        push ecx
        push esi
        push edi
        push ebp
        LD mov, esi, eax
        LD mov, edi, edx
        LD mov, ebp, ebx
        LD xor, eax, eax
        LD xor, ebx, ebx
        LD xor, ecx, ecx
        sub ebp, byte 4
        test edi, 2
        jne short .2
        cmp ebp, byte 0
        js short .2
        mov al, byte [esi]
        mov bl, byte [byte esi+01h]
.1:
        LD mov, ecx, eax
        shr ecx, 4
        mov edx, dword [nosplit ecx*2+IndexTo16Table]
        lea esi, [byte esi+02h]
        LD mov, ecx, ebx
        shr ecx, 4
        mov ecx, dword [nosplit ecx*2+IndexTo16Table]
        lea edi, [byte edi+08h]
        and eax, byte 0Fh
        mov dx, word [nosplit eax*2+IndexTo16Entries]
        mov al, byte [esi]
        and ebx, byte 0Fh
        mov cx, word [nosplit ebx*2+IndexTo16Entries]
        mov bl, byte [byte esi+01h]
        mov dword [byte edi-08h], edx
        mov dword [byte edi-04h], ecx
        sub ebp, byte 4
        jns short .1
.2:
        add ebp, byte 2
        js short .4
.3:
        LD mov, ecx, eax
        shr ecx, 4
        mov edx, dword [nosplit ecx*2+IndexTo16Table]
        lea esi, [byte esi+01h]
        lea edi, [byte edi+04h]
        and eax, byte 0Fh
        mov dx, word [nosplit eax*2+IndexTo16Entries]
        mov al, byte [esi]
        mov dword [byte edi-04h], edx
        sub ebp, byte 2
        jns short .3
.4:
        add ebp, byte 1
        js short .5
        and eax, byte 0Fh
        mov dx, word [nosplit eax*2+IndexTo16Entries]
        mov word [edi], dx
.5:
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 00h
        mov eax, dword [byte esp+04h]
        test eax, eax
        je short .9
.6:
        mov edx, dword [eax]
        and edx, 0FFh
        cmp edx, byte 7Ch
        jne short .7
        lea edx, [byte eax+08h]
        mov eax, edx
        ret
.7:
        mov edx, dword [eax]
        sar edx, 8
        test edx, edx
        je short .8
        add edx, eax
.8:
        mov eax, edx
        test edx, edx
        jne short .6
.9:
        xor edx, edx
        mov eax, edx
        ret
