; TGV movie decoder: BuildHuffTable, DecodeHuffRuns, DecodeTgvFrame, DecodeTgvKeyFrame, DecodeTgvChunk.
bits 32
%include "hockey.inc"
section s_11851F progbits alloc exec nowrite align=1
extern AllocMemBlock, bcopy, BytesPerPixelForDepth, FreeMemBlock, memset_, MessageBoxActive, str_TGV, TgvCopyBlock
extern TgvFillBlock, UnpackShared
global BuildHuffTable, DecodeHuffRuns, DecodeTgvFrame, DecodeTgvKeyFrame, DecodeTgvChunk
        db 00h
;-----------------------------------------------------------------------------
; BuildHuffTable                                 118520  97 PC, low confidence
; TGV video: builds a Huffman decoding table
;-----------------------------------------------------------------------------
BuildHuffTable:
        push esi
        push edi
        push ebp
        sub esp, byte 14h
        mov esi, eax
        mov dword [esp], edx
        mov edi, ebx
        mov dword [byte esp+010h], ecx
        lea eax, [byte ebx-01h]
        imul eax, ecx
        lea edx, [nosplit ebx*4+00h]
        mov ebx, 1
        dec ecx
        shl ebx, cl
        mov cl, byte [byte esp+010h]
        mov dword [byte esp+08h], ebx
        mov ebx, 0FFFFFFFFh
        shl ebx, cl
        add edx, esi
        mov dword [byte esp+04h], ebx
        xor ebx, ebx
        test edi, edi
        jle short .3
        mov esi, 1
        shl esi, cl
        lea ecx, [byte esi-01h]
        mov dword [byte esp+0Ch], ecx
.1:
        mov esi, eax
        mov ecx, dword [esp]
        sar esi, 3
        add esi, ecx
        mov ecx, eax
        mov esi, dword [esi]
        and ecx, byte 7
        shr esi, cl
        mov ecx, esi
        mov esi, dword [byte esp+0Ch]
        mov ebp, dword [byte esp+010h]
        and ecx, esi
        mov esi, dword [byte esp+08h]
        sub eax, ebp
        test ecx, esi
        je short .2
        or ecx, dword [byte esp+04h]
.2:
        inc ebx
        mov dword [byte edx-04h], ecx
        sub edx, byte 4
        cmp ebx, edi
        jl short .1
.3:
        add esp, byte 14h
        pop ebp
        pop edi
        pop esi
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; DecodeHuffRuns                                 1185B0  97 PC, low confidence
; TGV video: decodes Huffman coded runs
;-----------------------------------------------------------------------------
DecodeHuffRuns:
        push ebx
        push esi
        push edi
        push ebp
        mov eax, dword [byte esp+014h]
        mov edx, dword [byte esp+018h]
        mov ebp, dword [byte esp+01Ch]
        xor esi, esi
        test ebp, ebp
        jle near .2
.1:
        mov ebx, dword [byte eax+04h]
        mov edi, ebx
        shr edi, 1Eh
        and edi, byte 3
        mov cl, byte [edi+eax]
        mov edi, ebx
        shr edi, 1Ch
        and edi, byte 3
        mov byte [edx], cl
        mov cl, byte [edi+eax]
        mov edi, ebx
        shr edi, 1Ah
        and edi, byte 3
        mov byte [byte edx+01h], cl
        mov cl, byte [edi+eax]
        mov edi, ebx
        shr edi, 18h
        and edi, byte 3
        mov byte [byte edx+02h], cl
        mov cl, byte [edi+eax]
        mov edi, ebx
        shr edi, 16h
        and edi, byte 3
        mov byte [byte edx+03h], cl
        mov cl, byte [edi+eax]
        mov edi, ebx
        shr edi, 14h
        and edi, byte 3
        mov byte [byte edx+04h], cl
        mov cl, byte [edi+eax]
        mov edi, ebx
        shr edi, 12h
        and edi, byte 3
        mov byte [byte edx+05h], cl
        mov cl, byte [edi+eax]
        mov edi, ebx
        shr edi, 10h
        and edi, byte 3
        mov byte [byte edx+06h], cl
        mov cl, byte [edi+eax]
        mov edi, ebx
        shr edi, 0Eh
        and edi, byte 3
        mov byte [byte edx+07h], cl
        mov cl, byte [edi+eax]
        mov edi, ebx
        shr edi, 0Ch
        and edi, byte 3
        mov byte [byte edx+08h], cl
        mov cl, byte [edi+eax]
        mov edi, ebx
        shr edi, 0Ah
        and edi, byte 3
        mov byte [byte edx+09h], cl
        mov cl, byte [edi+eax]
        mov edi, ebx
        shr edi, 8
        and edi, byte 3
        mov byte [byte edx+0Ah], cl
        mov cl, byte [edi+eax]
        mov edi, ebx
        shr edi, 6
        and edi, byte 3
        mov byte [byte edx+0Bh], cl
        mov cl, byte [edi+eax]
        mov edi, ebx
        shr edi, 4
        and edi, byte 3
        mov byte [byte edx+0Ch], cl
        mov cl, byte [edi+eax]
        mov edi, ebx
        shr edi, 2
        add eax, byte 8
        and edi, byte 3
        mov byte [byte edx+0Dh], cl
        mov cl, byte [byte edi+eax-08h]
        and ebx, byte 3
        mov byte [byte edx+0Eh], cl
        add edx, byte 10h
        mov bl, byte [byte ebx+eax-08h]
        inc esi
        mov byte [byte edx-01h], bl
        cmp esi, ebp
        jl near .1
.2:
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; DecodeTgvFrame                                 1186C0  97 PC, low confidence
; TGV video: decodes a delta frame ("TGV")
;-----------------------------------------------------------------------------
DecodeTgvFrame:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 24h
        mov esi, dword [byte esp+038h]
        mov ebx, dword [byte esp+03Ch]
        mov edx, 1
        mov eax, dword [esi]
        mov ecx, 2
        mov dword [esp], eax
        mov eax, dword [byte esi+04h]
        mov dword [byte esp+018h], edx
        mov dword [byte esp+0Ch], eax
        mov eax, dword [byte esi+02Ch]
        mov edx, dword [byte esi+028h]
        mov dword [byte esi+028h], eax
        lea eax, [byte ebx+08h]
        mov dword [byte esi+02Ch], edx
        mov eax, dword [byte ecx+eax-04h]
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        mov ecx, 2
        mov edi, eax
        mov dword [byte esi+010h], eax
        lea eax, [byte ebx+0Ah]
        mov eax, dword [byte ecx+eax-04h]
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        mov ecx, 2
        mov ebp, eax
        mov dword [byte esp+010h], eax
        mov dword [byte esi+014h], eax
        lea eax, [byte ebx+0Ch]
        mov eax, dword [byte ecx+eax-04h]
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        mov ecx, 2
        mov edx, eax
        mov dword [byte esp+014h], eax
        mov dword [byte esi+018h], eax
        lea eax, [byte ebx+0Eh]
        mov eax, dword [byte ecx+eax-04h]
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        add edx, ebp
        mov dword [byte esp+08h], eax
        shl edx, 4
        mov ebp, dword [byte esi+020h]
        mov dword [byte esi+01Ch], eax
        mov eax, edi
        mov ecx, dword [byte esi+024h]
        shl eax, 3
        add ebp, ecx
        lea ecx, [eax+edx]
        cmp ecx, ebp
        jbe short .1
        mov dword [byte esi+024h], edx
        add eax, byte 8
        mov ebp, dword [byte esi+03Ch]
        mov dword [byte esi+020h], eax
        test ebp, ebp
        je short .1
        push ebp
        call FreeMemBlock
        mov dword [byte esi+03Ch], 0
        mov dword [byte esi+040h], 0
        add esp, byte 4
        mov dword [byte esi+038h], 0
.1:
        cmp dword [byte esi+03Ch], byte 0
        jne short .3
        mov ecx, dword [MessageBoxActive]
        mov eax, dword [byte esi+020h]
        mov ebp, dword [byte esi+024h]
        push ecx
        add eax, ebp
        push eax
        push str_TGV
        call AllocMemBlock
        add esp, byte 0Ch
        mov dword [byte esi+03Ch], eax
        test eax, eax
        je short .2
        mov dword [byte esi+040h], eax
        jmp short .3
.2:
        mov dword [byte esp+018h], eax
.3:
        cmp dword [byte esp+018h], byte 0
        je near .10
        lea eax, [nosplit edi*8+00h]
        mov edx, dword [byte esi+03Ch]
        add ebx, byte 14h
        add edx, eax
        mov dword [byte esp+01Ch], ebx
        mov dword [byte esi+038h], edx
        test edi, edi
        je near .6
        lea eax, [nosplit edi*4+00h]
        add eax, edi
        shl eax, 2
        add eax, byte 1Fh
        mov ecx, 0Ah
        and al, 0E0h
        mov edx, dword [byte esp+01Ch]
        sar eax, 3
        lea ebx, [nosplit edi*2+00h]
        mov dword [byte esp+04h], eax
        mov eax, dword [byte esi+03Ch]
        call BuildHuffTable
        mov edx, dword [byte esp+0Ch]
        mov eax, dword [byte esi+034h]
        shl edx, 2
        add eax, edx
        mov dword [byte esp+020h], eax
        test edi, edi
        jle short .5
        shl edi, 2
        xor eax, eax
        xor ebx, ebx
.4:
        mov ecx, dword [byte esi+03Ch]
        mov edx, dword [byte ecx+ebx+04h]
        mov ebp, dword [byte esp+020h]
        shl edx, 2
        add edx, ebp
        mov edx, dword [edx]
        mov ebp, dword [ecx+ebx]
        lea ecx, [edx+ebp]
        add eax, byte 4
        mov edx, dword [byte esi+040h]
        add ebx, byte 8
        mov dword [byte edx+eax-04h], ecx
        cmp eax, edi
        jl short .4
.5:
        mov eax, dword [byte esp+04h]
        add dword [byte esp+01Ch], eax
.6:
        mov ebx, dword [byte esp+010h]
        test ebx, ebx
        je short .7
        shl ebx, 4
        push ebx
        mov ecx, dword [byte esi+038h]
        push ecx
        mov edi, dword [byte esp+024h]
        push edi
        call bcopy
        add esp, byte 0Ch
        lea ebp, [edi+ebx]
        mov dword [byte esp+01Ch], ebp
.7:
        mov eax, dword [byte esp+014h]
        test eax, eax
        je short .8
        lea ebx, [nosplit eax*8+00h]
        push eax
        mov eax, dword [byte esp+014h]
        mov edx, dword [byte esi+038h]
        shl eax, 4
        add eax, edx
        push eax
        mov ecx, dword [byte esp+024h]
        push ecx
        call DecodeHuffRuns
        add esp, byte 0Ch
        add dword [byte esp+01Ch], ebx
.8:
        mov eax, dword [esp]
        imul eax, dword [byte esp+0Ch]
        mov edx, dword [byte esp+08h]
        sar eax, 4
        imul edx, eax
        add edx, byte 1Fh
        and dl, 0E0h
        sar edx, 3
        test edx, edx
        je short .9
        mov edx, dword [byte esp+08h]
        push edx
        push eax
        mov ebx, dword [byte esp+024h]
        push ebx
        mov ecx, dword [byte esi+030h]
        push ecx
        call TgvCopyBlock
        add esp, byte 10h
.9:
        mov eax, dword [byte esi+04h]
        sar eax, 2
        push eax
        mov eax, dword [esi]
        sar eax, 2
        push eax
        mov edi, dword [esi]
        push edi
        mov ebp, dword [byte esi+038h]
        push ebp
        mov eax, dword [byte esi+040h]
        push eax
        mov edx, dword [byte esi+010h]
        mov eax, dword [byte esi+028h]
        push edx
        add eax, byte 10h
        push eax
        mov eax, dword [byte esi+02Ch]
        add eax, byte 10h
        push eax
        mov ebx, dword [byte esi+030h]
        push ebx
        call TgvFillBlock
        add esp, byte 24h
.10:
        mov eax, dword [byte esp+018h]
        add esp, byte 24h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; DecodeTgvKeyFrame                              118954  97 PC, low confidence
; TGV video: decodes a key frame ("TGV")
;-----------------------------------------------------------------------------
DecodeTgvKeyFrame:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 18h
        mov esi, dword [byte esp+02Ch]
        mov eax, dword [esi]
        mov dword [byte esp+08h], eax
        mov eax, dword [byte esi+04h]
        mov dword [byte esp+04h], eax
        mov eax, dword [byte esp+030h]
        mov ecx, 2
        add eax, byte 8
        mov eax, dword [byte ecx+eax-04h]
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        mov edi, eax
        mov dword [esi], eax
        mov eax, dword [byte esp+030h]
        mov ecx, 2
        add eax, byte 0Ah
        mov eax, dword [byte ecx+eax-04h]
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        mov dword [byte esp+014h], eax
        mov dword [byte esi+04h], eax
        mov eax, dword [byte esp+030h]
        mov ecx, 2
        add eax, byte 0Ch
        xor edx, edx
        mov eax, dword [byte ecx+eax-04h]
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        mov dword [byte esi+08h], eax
        mov eax, dword [byte esp+030h]
        mov ecx, 2
        add eax, byte 0Eh
        mov dword [byte esp+0Ch], edx
        mov eax, dword [byte ecx+eax-04h]
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        mov edx, eax
        mov ebp, eax
        mov dword [byte esi+0Ch], eax
        mov eax, dword [byte esp+030h]
        mov ecx, 4
        add eax, byte 10h
        xor ebx, ebx
        mov eax, dword [byte ecx+eax-04h]
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        mov dword [esp], eax
        test edx, edx
        jle short .2
        mov eax, dword [byte esp+030h]
        mov edx, esi
.1:
        mov cl, byte [byte eax+014h]
        mov byte [byte edx+044h], cl
        mov cl, byte [byte eax+015h]
        add eax, byte 3
        mov byte [byte edx+045h], cl
        add edx, byte 3
        mov cl, byte [byte eax+013h]
        inc ebx
        mov byte [byte edx+043h], cl
        cmp ebx, ebp
        jl short .1
.2:
        mov eax, dword [byte esp+014h]
        imul eax, edi
        add eax, byte 3
        and al, 0FCh
        mov ebx, dword [byte esp+08h]
        mov dword [byte esp+010h], eax
        cmp edi, ebx
        jne short .3
        mov eax, dword [byte esp+014h]
        cmp eax, dword [byte esp+04h]
        je near .8
.3:
        mov eax, dword [byte esi+028h]
        test eax, eax
        je short .4
        push eax
        call FreeMemBlock
        add esp, byte 4
        mov dword [byte esi+028h], 0
.4:
        mov ebx, dword [byte esi+02Ch]
        test ebx, ebx
        je short .5
        push ebx
        call FreeMemBlock
        add esp, byte 4
        mov dword [byte esi+02Ch], 0
.5:
        mov eax, dword [byte esi+034h]
        test eax, eax
        je short .6
        push eax
        call FreeMemBlock
        add esp, byte 4
        mov dword [byte esi+034h], 0
.6:
        mov ebx, dword [byte esi+030h]
        test ebx, ebx
        je short .7
        push ebx
        call FreeMemBlock
        add esp, byte 4
        mov dword [byte esi+030h], 0
.7:
        mov eax, dword [MessageBoxActive]
        mov ebx, dword [byte esp+010h]
        push eax
        add ebx, byte 10h
        push ebx
        push str_TGV
        call AllocMemBlock
        add esp, byte 0Ch
        mov edx, dword [MessageBoxActive]
        push edx
        push ebx
        push str_TGV
        mov dword [byte esi+028h], eax
        call AllocMemBlock
        mov ebx, dword [MessageBoxActive]
        add esp, byte 0Ch
        mov dword [byte esi+02Ch], eax
        mov eax, dword [byte esp+014h]
        push ebx
        shl eax, 3
        push eax
        push str_TGV
        call AllocMemBlock
        add esp, byte 0Ch
        mov dword [byte esi+034h], eax
        mov eax, dword [byte esp+010h]
        mov edx, eax
        sar edx, 1Fh
        shl edx, 4
        LD sbb, eax, edx
        sar eax, 4
        mov ecx, dword [MessageBoxActive]
        push ecx
        shl eax, 2
        push eax
        push str_TGV
        call AllocMemBlock
        add esp, byte 0Ch
        mov dword [byte esi+030h], eax
.8:
        mov eax, dword [byte esi+028h]
        test eax, eax
        je near .13
        cmp dword [byte esi+02Ch], byte 0
        je near .13
        cmp dword [byte esi+034h], byte 0
        je near .13
        cmp dword [byte esi+030h], byte 0
        je near .13
        mov ebx, 10h
        xor edx, edx
        call memset_
        push byte 8
        call BytesPerPixelForDepth
        mov edx, eax
        mov eax, dword [byte esi+028h]
        mov byte [eax], 0
        mov eax, dword [byte esi+028h]
        and edx, 0FFh
        or dword [eax], edx
        mov eax, dword [byte esi+028h]
        mov word [byte eax+04h], di
        add esp, byte 4
        mov eax, dword [byte esi+028h]
        mov edx, dword [byte esp+014h]
        mov word [byte eax+06h], dx
        mov ebx, 10h
        mov eax, dword [byte esi+02Ch]
        xor edx, edx
        call memset_
        push byte 8
        call BytesPerPixelForDepth
        mov edx, eax
        mov eax, dword [byte esi+02Ch]
        mov byte [eax], 0
        mov eax, dword [byte esi+02Ch]
        and edx, 0FFh
        or dword [eax], edx
        mov eax, dword [byte esi+02Ch]
        mov word [byte eax+04h], di
        add esp, byte 4
        mov eax, dword [byte esi+02Ch]
        mov edx, dword [byte esp+014h]
        mov word [byte eax+06h], dx
        mov edx, dword [byte esp+014h]
        neg edx
        imul edx, edi
        mov ecx, dword [byte esp+014h]
        shl ecx, 3
        xor eax, eax
        test ecx, ecx
        jle short .10
.9:
        add eax, byte 4
        mov ebx, dword [byte esi+034h]
        mov dword [byte ebx+eax-04h], edx
        add edx, edi
        cmp eax, ecx
        jl short .9
.10:
        mov edx, dword [byte esp+030h]
        lea eax, [nosplit ebp*4+00h]
        add edx, byte 14h
        sub eax, ebp
        add eax, edx
        test byte [esp], 1
        je short .11
        mov edi, dword [byte esp+010h]
        mov edx, dword [byte esi+028h]
        push edi
        add edx, byte 10h
        push edx
        push eax
        call bcopy
        add esp, byte 0Ch
        jmp short .12
.11:
        mov edx, dword [byte esi+028h]
        add edx, byte 10h
        push edx
        push eax
        call UnpackShared
        add esp, byte 8
.12:
        mov dword [byte esp+0Ch], 1
.13:
        mov eax, dword [byte esp+0Ch]
        add esp, byte 18h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        push ebx
        mov edx, dword [MessageBoxActive]
        push edx
        push dword 344h
        push str_TGV
        call AllocMemBlock
        add esp, byte 0Ch
        mov ecx, eax
        test eax, eax
        je short .14
        mov ebx, 344h
        xor edx, edx
        call memset_
.14:
        mov eax, ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; DecodeTgvChunk                                 118C88  97 PC, low confidence
; TGV video: decodes a chunk by its tag (key frame or delta frame)
;-----------------------------------------------------------------------------
DecodeTgvChunk:
        push ebx
        mov ebx, dword [byte esp+08h]
        mov edx, dword [byte esp+0Ch]
        mov ecx, 4
        mov eax, edx
        mov eax, dword [byte ecx+eax-04h]
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        cmp eax, 5447566Bh
        jb short .1
        jbe short .2
        cmp eax, 66564754h
        jb short .5
        jbe short .3
        cmp eax, 6B564754h
        je short .2
        mov eax, dword [byte ebx+028h]
        pop ebx
        ret
.1:
        cmp eax, 54475666h
        je short .3
        mov eax, dword [byte ebx+028h]
        pop ebx
        ret
.2:
        push edx
        push ebx
        call DecodeTgvKeyFrame
        jmp short .4
.3:
        push edx
        push ebx
        call DecodeTgvFrame
.4:
        add esp, byte 8
.5:
        mov eax, dword [byte ebx+028h]
        pop ebx
        ret
        db 08Dh,040h,00h
        push ebx
        push esi
        push ebp
        mov ebx, dword [byte esp+010h]
        test ebx, ebx
        je short .11
        mov edx, dword [byte ebx+03Ch]
        test edx, edx
        je short .6
        push edx
        call FreeMemBlock
        add esp, byte 4
.6:
        mov esi, dword [byte ebx+028h]
        test esi, esi
        je short .7
        push esi
        call FreeMemBlock
        add esp, byte 4
.7:
        mov ebp, dword [byte ebx+02Ch]
        test ebp, ebp
        je short .8
        push ebp
        call FreeMemBlock
        add esp, byte 4
.8:
        mov edx, dword [byte ebx+034h]
        test edx, edx
        je short .9
        push edx
        call FreeMemBlock
        add esp, byte 4
.9:
        mov esi, dword [byte ebx+030h]
        test esi, esi
        je short .10
        push esi
        call FreeMemBlock
        add esp, byte 4
.10:
        push ebx
        call FreeMemBlock
        add esp, byte 4
.11:
        pop ebp
        pop esi
        pop ebx
        ret
