; EA library: BuildDecodeTable, InitVideoDecoder, BuildVideoGammaTable, DecodeVideoChunk and 9 more.
bits 32
%include "hockey.inc"
section s_116A68 progbits alloc exec nowrite align=1
extern AllocMemBlockMovable, AssertFailEntry, AssertFileName, AssertMessage, BitReaderBits, BytesPerPixelForDepth, DebugMode, DebugSetLine
extern F32_0p382683, F32_0p541196, F32_1p30656, F32_6p7554e15, FillRowTable, FrameRateCount, FrameRateLast, FrameRateMax
extern FrameRateMin, FrameRateSamples, FrameRateStart, FrameRateState, FrameRateTicks, FrameRateValue, MenuScreenBitmap, PresentScreen
extern PrintBoxedText, RowTable, ScreenModeHeight, ScreenModeWidth, sprintf_, str_CmnFrateC, str_D_UpdateFrameRate, str_DxDxD
extern str_FramerateTIMERHZNOTSET, str_Rate2dDAvg2dDD, TimerTicks, VideoBitBuffer, VideoBitCount, VideoBlockSum, VideoBlockTemp, VideoBlockX
extern VideoBlockY, VideoCodeJumpTable, VideoCodeLengths, VideoCodeLengthsFrom1, VideoCodeLengthsFrom2, VideoCodePtr, VideoCodeTableA, VideoCodeTableB
extern VideoCodeTableC, VideoCoefs, VideoDecoderA, VideoDecoderB, VideoDecoderReady, VideoGammaSource, VideoGammaTable, VideoIdctOut
extern VideoIdctScale, VideoIdctTemp, VideoOutPtr, ZeroMem
global BuildDecodeTable, InitVideoDecoder, BuildVideoGammaTable, DecodeVideoChunk, CreateBitmapEx, CreateBitmapDefault, UpdateFrameRate, ResetFrameRate
global ReadVideoCodes, ReadVideoCodes_5B, ReadVideoCodes_6B, ReadVideoCodes_7D, ReadVideoCodes_8A, ReadVideoCodes_D4, ReadVideoCodes_E6, ReadVideoCodes_115
global VideoBlockFill, VideoBlockDelta, VideoBlockPattern, DecodeVideoFrame
        db 00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; BuildDecodeTable                               116A70  97 PC, low confidence
; Video player: builds the decoding table of the video stream
;-----------------------------------------------------------------------------
BuildDecodeTable:
        push esi
        push edi
        push ebp
        sub esp, byte 10h
        mov dword [byte esp+04h], eax
        mov esi, edx
        lea edi, [byte edx-04h]
        lea ebp, [byte edx+04h]
        mov eax, edx
        sar edx, 1Fh
        shl edx, 3
        LD sbb, eax, edx
        sar eax, 3
        mov dword [esp], eax
        mov edx, edi
        mov eax, edi
        sar edx, 1Fh
        shl edx, 3
        LD sbb, eax, edx
        sar eax, 3
        mov edi, eax
        mov edx, ebp
        mov eax, ebp
        sar edx, 1Fh
        shl edx, 3
        LD sbb, eax, edx
        sar eax, 3
        mov edx, dword [byte esp+04h]
        cmp edx, byte 0Fh
        jne near .12
        mov edx, dword [esp]
        mov dword [byte esp+0Ch], edx
        test esi, esi
        jge short .1
        mov esi, edi
        cmp edi, byte 0FFFFFFE1h
        jge short .2
        mov esi, 0FFFFFFE1h
        jmp short .2
.1:
        mov esi, eax
        cmp eax, byte 1Fh
        jle short .2
        mov esi, 1Fh
.2:
        mov edx, ebx
        mov eax, ebx
        sar edx, 1Fh
        shl edx, 3
        LD sbb, eax, edx
        sar eax, 3
        mov edi, eax
        test ebx, ebx
        jge short .3
        lea edx, [byte ebx-04h]
        mov eax, edx
        sar edx, 1Fh
        shl edx, 3
        LD sbb, eax, edx
        sar eax, 3
        mov ebx, eax
        cmp eax, byte 0FFFFFFE1h
        jge short .4
        mov ebx, 0FFFFFFE1h
        jmp short .4
.3:
        lea edx, [byte ebx+04h]
        mov eax, edx
        sar edx, 1Fh
        shl edx, 3
        LD sbb, eax, edx
        sar eax, 3
        mov ebx, eax
        cmp eax, byte 1Fh
        jle short .4
        mov ebx, 1Fh
.4:
        mov edx, ecx
        mov eax, ecx
        sar edx, 1Fh
        shl edx, 3
        LD sbb, eax, edx
        sar eax, 3
        mov ebp, eax
        test ecx, ecx
        jge short .5
        lea edx, [byte ecx-04h]
        mov eax, edx
        sar edx, 1Fh
        shl edx, 3
        LD sbb, eax, edx
        sar eax, 3
        cmp eax, byte 0FFFFFFE1h
        jge short .6
        mov eax, 0FFFFFFE1h
        jmp short .6
.5:
        lea edx, [byte ecx+04h]
        mov eax, edx
        sar edx, 1Fh
        shl edx, 3
        LD sbb, eax, edx
        sar eax, 3
        cmp eax, byte 1Fh
        jle short .6
        mov eax, 1Fh
.6:
        test eax, eax
        jge short .7
        dec ebx
.7:
        test ebx, ebx
        jge short .8
        dec esi
.8:
        test esi, esi
        jge short .9
        dec ebp
.9:
        test ebp, ebp
        jge short .10
        dec edi
.10:
        test edi, edi
        jge short .11
        dec dword [byte esp+0Ch]
.11:
        mov edx, dword [byte esp+0Ch]
        and edi, byte 1Fh
        and edx, byte 1Fh
        shl edi, 15h
        shl edx, 1Ah
        mov ecx, esi
        or edi, edx
        mov edx, ebp
        and ebx, byte 1Fh
        and edx, byte 1Fh
        and ecx, byte 1Fh
        shl edx, 10h
        shl ecx, 0Ah
        or edx, edi
        shl ebx, 5
        or edx, ecx
        and eax, byte 1Fh
        or edx, ebx
        or eax, edx
        add esp, byte 10h
        pop ebp
        pop edi
        pop esi
        ret 4
.12:
        cmp edx, byte 10h
        jne near .24
        mov edx, dword [esp]
        mov dword [byte esp+08h], edx
        test esi, esi
        jge short .13
        mov esi, edi
        cmp edi, byte 0FFFFFFE1h
        jge short .14
        mov esi, 0FFFFFFE1h
        jmp short .14
.13:
        mov esi, eax
        cmp eax, byte 1Fh
        jle short .14
        mov esi, 1Fh
.14:
        mov edx, ebx
        mov eax, ebx
        sar edx, 1Fh
        shl edx, 2
        LD sbb, eax, edx
        sar eax, 2
        mov ebp, eax
        test ebx, ebx
        jge short .15
        lea edx, [byte ebx-02h]
        mov eax, edx
        sar edx, 1Fh
        shl edx, 2
        LD sbb, eax, edx
        sar eax, 2
        mov ebx, eax
        cmp eax, byte 0FFFFFFC1h
        jge short .16
        mov ebx, 0FFFFFFC1h
        jmp short .16
.15:
        lea edx, [byte ebx+02h]
        mov eax, edx
        sar edx, 1Fh
        shl edx, 2
        LD sbb, eax, edx
        sar eax, 2
        mov ebx, eax
        cmp eax, byte 3Fh
        jle short .16
        mov ebx, 3Fh
.16:
        mov edx, ecx
        mov eax, ecx
        sar edx, 1Fh
        shl edx, 3
        LD sbb, eax, edx
        sar eax, 3
        mov edi, eax
        test ecx, ecx
        jge short .17
        lea edx, [byte ecx-04h]
        mov eax, edx
        sar edx, 1Fh
        shl edx, 3
        LD sbb, eax, edx
        sar eax, 3
        cmp eax, byte 0FFFFFFE1h
        jge short .18
        mov eax, 0FFFFFFE1h
        jmp short .18
.17:
        lea edx, [byte ecx+04h]
        mov eax, edx
        sar edx, 1Fh
        shl edx, 3
        LD sbb, eax, edx
        sar eax, 3
        cmp eax, byte 1Fh
        jle short .18
        mov eax, 1Fh
.18:
        test eax, eax
        jge short .19
        dec ebx
.19:
        test ebx, ebx
        jge short .20
        dec esi
.20:
        test esi, esi
        jge short .21
        dec edi
.21:
        test edi, edi
        jge short .22
        dec ebp
.22:
        test ebp, ebp
        jge short .23
        dec dword [byte esp+08h]
.23:
        mov edx, dword [byte esp+08h]
        and ebp, byte 3Fh
        and edi, byte 1Fh
        and esi, byte 1Fh
        and ebx, byte 3Fh
        and edx, byte 1Fh
        shl ebp, 15h
        shl edx, 1Bh
        shl edi, 10h
        or edx, ebp
        shl esi, 0Bh
        or edx, edi
        shl ebx, 5
        or edx, esi
        and eax, byte 1Fh
        or edx, ebx
        or eax, edx
        add esp, byte 10h
        pop ebp
        pop edi
        pop esi
        ret 4
.24:
        test ecx, ecx
        jge short .25
        dec ebx
.25:
        test ebx, ebx
        jge short .26
        dec esi
.26:
        test esi, esi
        jge short .27
        dec dword [byte esp+020h]
.27:
        mov eax, dword [byte esp+020h]
        and esi, 0FFh
        and ebx, 0FFh
        and eax, 0FFh
        shl esi, 10h
        shl eax, 18h
        shl ebx, 8
        or esi, eax
        mov eax, ecx
        or esi, ebx
        and eax, 0FFh
        or eax, esi
        add esp, byte 10h
        pop ebp
        pop edi
        pop esi
        ret 4
;-----------------------------------------------------------------------------
; InitVideoDecoder                               116D38  97 PC, low confidence
; Video player: sets up the decoder tables for a video stream
;-----------------------------------------------------------------------------
InitVideoDecoder:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 10h
        mov esi, dword [byte esp+024h]
        xor edx, edx
        mov dword [esp], edx
        mov al, byte [esp]
        add al, al
        inc al
        xor edi, edi
        mov byte [byte esp+08h], al
        mov ebp, 80h
.1:
        mov edx, dword [byte esp+05h]
        mov ebx, dword [byte esp+028h]
        sar edx, 18h
        mov eax, esi
        add edx, 80h
        push ebx
        mov ecx, edx
        mov ebx, edx
        add edi, byte 4
        call BuildDecodeTable
        mov ecx, dword [esp]
        mov dword [dword edi+VideoDecoderB], eax
        mov ah, byte [byte esp+08h]
        inc ecx
        add ah, 2
        mov dword [esp], ecx
        mov byte [byte esp+08h], ah
        cmp ebp, ecx
        jg short .1
        xor edx, edx
        mov dword [esp], edx
        mov al, byte [esp]
        add al, al
        inc al
        xor ebp, ebp
        mov byte [byte esp+0Ch], al
.2:
        mov ebx, dword [byte esp+09h]
        sar ebx, 18h
        mov eax, 0FFFFA7EAh
        mov edx, ebx
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov edi, eax
        mov edx, ebx
        mov eax, 1C5A1h
        mov ebx, dword [byte esp+028h]
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        push ebx
        mov ecx, eax
        xor edx, edx
        mov ebx, edi
        mov eax, esi
        add ebp, byte 4
        call BuildDecodeTable
        mov dl, byte [byte esp+0Ch]
        mov ecx, dword [esp]
        mov dword [dword ebp+BitReaderBits], eax
        add dl, 2
        inc ecx
        mov byte [byte esp+0Ch], dl
        mov dword [esp], ecx
        cmp ecx, 80h
        jl short .2
        xor ebp, ebp
        mov dword [esp], ebp
        mov al, byte [esp]
        add al, al
        inc al
        mov byte [byte esp+04h], al
.3:
        mov ebx, dword [byte esp+01h]
        sar ebx, 18h
        mov eax, 166E9h
        mov edx, ebx
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov edi, eax
        mov edx, ebx
        mov eax, 0FFFF4931h
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov ebx, eax
        mov eax, dword [byte esp+028h]
        xor ecx, ecx
        push eax
        mov edx, edi
        mov eax, esi
        call BuildDecodeTable
        add byte [byte esp+04h], 2
        mov edx, dword [esp]
        add ebp, byte 4
        inc edx
        mov dword [dword ebp+VideoDecoderA], eax
        mov dword [esp], edx
        cmp edx, 80h
        jl short .3
        mov dword [VideoDecoderReady], 1
        add esp, byte 10h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
;-----------------------------------------------------------------------------
; BuildVideoGammaTable                           116E84  97 PC, low confidence
; Video player: builds the brightness table of the video palette
;-----------------------------------------------------------------------------
BuildVideoGammaTable:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 1Ch
        mov ebx, 64h
        sub ebx, dword [byte esp+030h]
        lea eax, [nosplit ebx*4+00h]
        sub eax, ebx
        shl eax, 2
        sub eax, ebx
        lea edx, [eax+eax]
        mov ecx, 64h
        mov eax, edx
        sar edx, 1Fh
        idiv ecx
        lea ebp, [byte eax+08h]
        lea eax, [nosplit ebx*4+00h]
        sub eax, ebx
        shl eax, 3
        lea edx, [ebx+eax]
        add edx, edx
        mov eax, edx
        sar edx, 1Fh
        idiv ecx
        add eax, byte 0Ah
        sub eax, ebp
        xor esi, esi
        mov dword [byte esp+04h], eax
        mov dword [byte esp+014h], eax
        imul eax, esi
        mov ebx, ecx
        mov dword [byte esp+08h], esi
        xor ebx, ecx
        mov ecx, 20h
        mov dword [byte esp+010h], ebx
        mov dword [byte esp+0Ch], ecx
        mov dword [esp], eax
.1:
        mov eax, dword [byte esp+010h]
        imul eax, dword [byte esp+04h]
        mov ebx, dword [esp]
        mov ecx, dword [byte esp+08h]
        mov edi, dword [byte esp+0Ch]
        add ebx, eax
.2:
        mov dword [byte esp+018h], 0Eh
        mov edx, ebx
        mov eax, ebx
        sar edx, 1Fh
        idiv dword [byte esp+018h]
        mov esi, dword [dword ecx+VideoGammaSource]
        add eax, ebp
        mov edx, esi
        shl eax, 10h
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        mov dword [dword ecx+VideoGammaTable], eax
        mov eax, dword [byte esp+014h]
        add ecx, byte 4
        add ebx, eax
        cmp ecx, edi
        jne short .2
        mov edx, dword [byte esp+0Ch]
        mov ebx, dword [byte esp+08h]
        mov ecx, dword [byte esp+010h]
        add edx, byte 20h
        add ebx, byte 20h
        inc ecx
        mov dword [byte esp+0Ch], edx
        mov dword [byte esp+08h], ebx
        mov dword [byte esp+010h], ecx
        cmp ecx, byte 8
        jl short .1
        add esp, byte 1Ch
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; DecodeVideoChunk                               116F78  97 PC, low confidence
; Video player: decodes a chunk of the video stream
;-----------------------------------------------------------------------------
DecodeVideoChunk:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 10h
        mov ebx, dword [byte esp+024h]
        mov edi, dword [byte esp+02Ch]
        mov edx, dword [VideoGammaTable]
        movsx eax, byte [ebx]
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        sar eax, 1
        and eax, byte 7Fh
        mov edx, dword [VideoGammaTable]
        mov esi, dword [nosplit eax*4+VideoCodeTableC]
        movsx eax, byte [byte ebx+02h]
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        sar eax, 1
        and eax, byte 7Fh
        mov eax, dword [nosplit eax*4+VideoCodeTableC]
        mov dword [byte esp+08h], eax
        mov eax, dword [byte ebx+01h]
        mov edx, dword [VideoGammaTable]
        sar eax, 18h
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        sar eax, 1
        and eax, byte 7Fh
        mov eax, dword [nosplit eax*4+VideoCodeTableC]
        mov dword [esp], eax
        mov eax, dword [byte ebx+03h]
        mov edx, dword [VideoGammaTable]
        sar eax, 18h
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        sar eax, 1
        and eax, byte 7Fh
        mov eax, dword [nosplit eax*4+VideoCodeTableC]
        mov dword [byte esp+04h], eax
        mov eax, dword [byte ebx+05h]
        mov edx, dword [VideoGammaTable]
        sar eax, 18h
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        sar eax, 1
        and eax, byte 7Fh
        lea ecx, [nosplit eax*4+00h]
        mov eax, dword [byte ebx+07h]
        mov edx, dword [VideoGammaTable]
        sar eax, 18h
        imul edx
        shl edx, 10h
        shr eax, 10h
        adc eax, edx
        sar eax, 1
        and eax, byte 7Fh
        mov edx, dword [dword ecx+VideoCodeTableA]
        mov ebx, dword [nosplit eax*4+VideoCodeTableB]
        add edx, ebx
        mov dword [byte esp+0Ch], edx
        lea ebx, [edx+esi]
        mov esi, edi
        shr esi, 2
        xor ecx, ecx
        shl esi, 2
        mov eax, dword [byte esp+028h]
        sub esi, byte 20h
.1:
        xor edx, edx
.2:
        add eax, byte 4
        inc edx
        mov dword [byte eax-04h], ebx
        cmp edx, byte 8
        jl short .2
        inc ecx
        add eax, esi
        cmp ecx, byte 8
        jl short .1
        mov ebx, dword [byte esp+08h]
        mov ecx, dword [byte esp+0Ch]
        mov eax, dword [byte esp+028h]
        mov edx, edi
        add eax, byte 20h
        shr edx, 2
        add ebx, ecx
        shl edx, 2
        xor ecx, ecx
        lea esi, [byte edx-020h]
.3:
        xor edx, edx
.4:
        add eax, byte 4
        inc edx
        mov dword [byte eax-04h], ebx
        cmp edx, byte 8
        jl short .4
        inc ecx
        add eax, esi
        cmp ecx, byte 8
        jl short .3
        mov ebx, dword [esp]
        mov esi, dword [byte esp+0Ch]
        lea eax, [nosplit edi*8+00h]
        mov ebp, dword [byte esp+028h]
        mov edx, edi
        xor ecx, ecx
        shr edx, 2
        add ebx, esi
        shl edx, 2
        add eax, ebp
        lea esi, [byte edx-020h]
.5:
        xor edx, edx
.6:
        add eax, byte 4
        inc edx
        mov dword [byte eax-04h], ebx
        cmp edx, byte 8
        jl short .6
        inc ecx
        add eax, esi
        cmp ecx, byte 8
        jl short .5
        mov ebx, dword [byte esp+04h]
        add ebx, dword [byte esp+0Ch]
        lea eax, [nosplit edi*8+00h]
        mov edx, dword [byte esp+028h]
        mov esi, edi
        xor ecx, ecx
        shr esi, 2
        add eax, edx
        shl esi, 2
        add eax, byte 20h
        sub esi, byte 20h
.7:
        xor edx, edx
.8:
        add eax, byte 4
        inc edx
        mov dword [byte eax-04h], ebx
        cmp edx, byte 8
        jl short .8
        inc ecx
        add eax, esi
        cmp ecx, byte 8
        jl short .7
        add esp, byte 10h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 00h
;-----------------------------------------------------------------------------
; CreateBitmapEx                                 117140  97 PC, low confidence
; Graphics library: creates a bitmap of a width, height and depth
; ("%dx%dx%d")
;-----------------------------------------------------------------------------
CreateBitmapEx:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 18h
        mov edi, dword [byte esp+02Ch]
        cmp dword [byte esp+034h], byte 0
        jne short .1
        mov eax, dword [MenuScreenBitmap]
        mov dword [byte esp+034h], eax
.1:
        cmp dword [byte esp+034h], byte 0
        jne short .2
        mov dword [byte esp+034h], 8
.2:
        mov eax, dword [byte esp+034h]
        inc eax
        and al, 0FEh
        mov esi, dword [RowTable]
        mov dword [byte esp+014h], eax
        test esi, esi
        jne short .3
        xor eax, eax
        jmp near .9
.3:
        test edi, edi
        jl short .4
        cmp edi, 4000h
        jg short .4
        mov ebp, dword [byte esp+030h]
        test ebp, ebp
        jl short .4
        cmp ebp, 2000h
        jle short .5
.4:
        xor eax, eax
        add esp, byte 18h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.5:
        imul eax, edi
        add eax, byte 7
        and al, 0F8h
        mov edx, eax
        mov ebx, dword [byte esp+014h]
        sar edx, 1Fh
        idiv ebx
        mov ebp, eax
        imul ebp, ebx
        mov edx, dword [byte esp+030h]
        sar ebp, 3
        imul edx, ebp
        mov esi, dword [byte esp+034h]
        push esi
        mov eax, dword [byte esp+034h]
        push eax
        push edi
        push str_DxDxD
        lea eax, [byte esp+010h]
        push eax
        call sprintf_
        add esp, byte 14h
        mov ebx, dword [byte esp+038h]
        push ebx
        add edx, byte 48h
        push edx
        lea eax, [byte esp+08h]
        push eax
        call AllocMemBlockMovable
        mov dword [byte esp+01Ch], eax
        add esp, byte 0Ch
        test eax, eax
        je near .9
        mov esi, dword [eax]
        test esi, esi
        jne short .6
        xor eax, eax
        add esp, byte 18h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.6:
        push byte 48h
        push esi
        call ZeroMem
        add esp, byte 8
        mov eax, dword [byte esp+034h]
        push eax
        lea ebx, [byte esi+038h]
        call BytesPerPixelForDepth
        add esp, byte 4
        mov byte [ebx], 0
        and eax, 0FFh
        mov edx, dword [ebx]
        mov word [byte ebx+04h], di
        or edx, eax
        mov eax, dword [byte esp+030h]
        mov dword [ebx], edx
        mov word [byte ebx+06h], ax
        mov dword [byte esi+020h], ebp
        mov dword [esi], edi
        mov eax, dword [byte esp+030h]
        mov dword [byte esi+010h], edi
        mov dword [byte esi+04h], eax
        mov dword [byte esi+014h], eax
        mov al, byte [byte esp+034h]
        mov byte [byte esi+018h], al
        mov eax, dword [ebx]
        mov edx, ebp
        and eax, 0FFh
        mov dword [byte esi+02Ch], ebx
        mov ebx, dword [byte esp+030h]
        mov byte [byte esi+019h], al
        mov eax, 10h
        call FillRowTable
        mov edx, dword [byte esp+014h]
        mov ebx, edi
        mov dword [byte esi+028h], eax
        sar edx, 3
        xor eax, eax
        call FillRowTable
        mov ebx, dword [byte esi+028h]
        mov dword [byte esi+030h], eax
        test ebx, ebx
        je short .7
        test eax, eax
        jne short .8
.7:
        xor eax, eax
        add esp, byte 18h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.8:
        mov eax, dword [byte esp+010h]
.9:
        add esp, byte 18h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 090h
        push ebx
        push esi
        push byte 1
        mov edx, dword [byte esp+01Ch]
        push edx
        mov ebx, dword [byte esp+01Ch]
        push ebx
        mov ecx, dword [byte esp+01Ch]
        push ecx
        mov esi, dword [byte esp+01Ch]
        push esi
        call CreateBitmapEx
        add esp, byte 14h
        pop esi
        pop ebx
        ret
        db 090h
        push ebx
        push esi
        push byte 0
        mov edx, dword [byte esp+01Ch]
        push edx
        mov ebx, dword [byte esp+01Ch]
        push ebx
        mov ecx, dword [byte esp+01Ch]
        push ecx
        mov esi, dword [byte esp+01Ch]
        push esi
        call CreateBitmapEx
        add esp, byte 14h
        pop esi
        pop ebx
        ret
        db 090h
        push ebx
        push esi
        push edi
        mov edx, dword [byte esp+020h]
        push edx
        mov ebx, dword [byte esp+020h]
        push ebx
        mov ecx, dword [byte esp+020h]
        push ecx
        mov esi, dword [byte esp+020h]
        push esi
        mov edi, dword [byte esp+020h]
        push edi
        call CreateBitmapEx
        add esp, byte 14h
        test eax, eax
        je short .10
        mov eax, dword [eax]
.10:
        pop edi
        pop esi
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; CreateBitmapDefault                            117338  97 PC, low confidence
; Graphics library: creates a bitmap in the screen's depth
;-----------------------------------------------------------------------------
CreateBitmapDefault:
        push ebx
        push esi
        push byte 1
        mov edx, dword [byte esp+01Ch]
        push edx
        mov ebx, dword [byte esp+01Ch]
        push ebx
        mov ecx, dword [byte esp+01Ch]
        push ecx
        mov esi, dword [byte esp+01Ch]
        push esi
        call CreateBitmapEx
        add esp, byte 14h
        mov eax, dword [eax]
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
        push ebx
        push esi
        push byte 0
        mov edx, dword [byte esp+01Ch]
        push edx
        mov ebx, dword [byte esp+01Ch]
        push ebx
        mov ecx, dword [byte esp+01Ch]
        push ecx
        mov esi, dword [byte esp+01Ch]
        push esi
        call CreateBitmapEx
        add esp, byte 14h
        test eax, eax
        je short .1
        mov eax, dword [eax]
.1:
        pop esi
        pop ebx
        ret
        db 00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; UpdateFrameRate                                117390  97 PC, low confidence
; Counts frames and works out the frame rate ("framerate - TIMERHZ NOT SET")
;-----------------------------------------------------------------------------
UpdateFrameRate:
        push ebx
        push esi
        push edi
        push ebp
        mov ebx, dword [FrameRateMin]
        mov esi, dword [FrameRateValue]
        inc dword [FrameRateCount]
        mov edi, dword [TimerTicks]
        mov ecx, dword [FrameRateTicks]
        mov ebp, edi
        mov eax, dword [str_D_UpdateFrameRate]
        sub ebp, ecx
        test eax, eax
        jne short .1
        mov edx, str_CmnFrateC
        mov ecx, 62h
        push str_FramerateTIMERHZNOTSET
        mov dword [AssertFileName], edx
        mov dword [AssertMessage], ecx
        call AssertFailEntry
        add esp, byte 4
.1:
        mov esi, dword [FrameRateValue]
        mov eax, dword [str_D_UpdateFrameRate]
        mov ebx, dword [FrameRateMin]
        cmp ebp, eax
        jge short .2
        test ebp, ebp
        jge near .7
.2:
        mov esi, dword [FrameRateCount]
        shl esi, 10h
        test ebx, ebx
        jne short .4
        xor eax, eax
.3:
        add eax, byte 4
        mov dword [dword eax+FrameRateState], esi
        cmp eax, byte 20h
        jne short .3
.4:
        xor eax, eax
.5:
        add eax, byte 4
        mov edx, dword [dword eax+FrameRateSamples]
        mov dword [dword eax+FrameRateState], edx
        cmp eax, byte 1Ch
        jne short .5
        mov eax, esi
        mov dword [FrameRateLast], esi
        xor ebx, ebx
        xor eax, esi
.6:
        mov edx, dword [dword eax+FrameRateSamples]
        add eax, byte 4
        add ebx, edx
        cmp eax, byte 20h
        jne short .6
        mov edx, ebx
        mov eax, ebx
        sar edx, 1Fh
        shl edx, 3
        LD sbb, eax, edx
        sar eax, 3
        mov dword [FrameRateTicks], edi
        xor edx, edx
        mov ebx, eax
        mov dword [FrameRateCount], edx
.7:
        mov ecx, dword [byte esp+020h]
        test ecx, ecx
        je short .8
        mov ebp, dword [str_D_UpdateFrameRate]
        mov eax, ecx
        imul eax, ebp
        mov edx, dword [FrameRateMax]
        sub edx, edi
        cmp edx, eax
        jl short .9
.8:
        mov edx, ebx
        and edx, 0FFFFh
        lea eax, [nosplit edx*4+00h]
        add eax, edx
        add eax, eax
        push edi
        sar eax, 10h
        push eax
        mov eax, ebx
        mov edx, esi
        sar eax, 10h
        and edx, 0FFFFh
        push eax
        lea eax, [nosplit edx*4+00h]
        add eax, edx
        add eax, eax
        sar eax, 10h
        push eax
        mov eax, esi
        sar eax, 10h
        push eax
        push str_Rate2dDAvg2dDD
        mov eax, dword [byte esp+030h]
        push eax
        mov edx, dword [byte esp+030h]
        mov dword [FrameRateMax], edi
        push edx
        mov dword [FrameRateMin], ebx
        mov dword [FrameRateValue], esi
        call dword [byte esp+03Ch]
        mov esi, dword [FrameRateValue]
        mov ebx, dword [FrameRateMin]
        add esp, byte 20h
.9:
        mov eax, esi
        mov dword [FrameRateValue], esi
        mov dword [FrameRateMin], ebx
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Bh,0C0h
        cmp dword [DebugMode], byte 3
        jge short .10
        push byte 0
        push PresentScreen
        jmp short .11
.10:
        push byte 0
        push DebugSetLine
.11:
        push byte 0
        push byte 0
        call UpdateFrameRate
        add esp, byte 10h
        ret
        db 08Bh,0C0h
        push byte 0
        push PresentScreen
        push byte 0
        push byte 0
        call UpdateFrameRate
        add esp, byte 10h
        ret
        push ebx
        push byte 0
        db 068h                                 ; insn: push PrintBoxedText
        dd PrintBoxedText
        mov edx, dword [ScreenModeHeight]
        push edx
        mov ebx, dword [ScreenModeWidth]
        push ebx
        call UpdateFrameRate
        add esp, byte 10h
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ResetFrameRate                                 11756C  97 PC, low confidence
; Clears the frame rate counters
;-----------------------------------------------------------------------------
ResetFrameRate:
        xor edx, edx
        mov dword [FrameRateCount], edx
        mov dword [FrameRateStart], edx
        mov dword [FrameRateValue], edx
        mov dword [FrameRateMin], edx
        mov dword [FrameRateMax], edx
        mov eax, dword [TimerTicks]
        mov dword [FrameRateTicks], eax
        ret
        db 00h
;-----------------------------------------------------------------------------
; ReadVideoCodes                                 117598  97 PC, low confidence
; Video player: reads the block codes of a frame
;-----------------------------------------------------------------------------
ReadVideoCodes:
        mov eax, dword [VideoBitCount]
        mov esi, dword [VideoCodePtr]
        shl eax, 18h
        mov ebp, dword [VideoBitCount]
        sar eax, 8
        mov ecx, dword [VideoBitBuffer]
        imul dword [VideoGammaTable]
        shl edx, 10h
        LD xor, ebx, ebx
        shr eax, 10h
        mov edi, 3Fh
        LD adc, eax, edx
        mov dword [VideoCoefs], eax
        LD xor, eax, eax
        shr ebp, 8
        mov al, byte [esi]
        inc esi
        sub ecx, byte 8
        shl eax, cl
        add ecx, byte 8
        LD or, ebp, eax
.1:
        LD mov, eax, ebp
        mov bl, byte [dword edi+VideoCodeLengths]
        and eax, byte 7
        jmp dword [nosplit eax*4+VideoCodeJumpTable]
ReadVideoCodes_5B:
        mov eax, dword [nosplit ebx*4+VideoGammaTable]
        mov dword [nosplit ebx*4+VideoCoefs], eax
        jmp short ReadVideoCodes_8A.2
ReadVideoCodes_6B:
        mov eax, dword [nosplit ebx*4+VideoGammaTable]
        neg eax
        mov dword [nosplit ebx*4+VideoCoefs], eax
        jmp short ReadVideoCodes_8A.2
ReadVideoCodes_7D:
        mov dword [nosplit ebx*4+VideoCoefs], 0
        jmp short ReadVideoCodes_8A.2
ReadVideoCodes_8A:
        mov dword [nosplit ebx*4+VideoCoefs], 0
        mov bl, byte [dword edi+VideoCodeLengthsFrom1]
        dec edi
        mov dword [nosplit ebx*4+VideoCoefs], 0
.2:
        shr ebp, 3
        sub ecx, byte 3
        cmp ecx, byte 8
        jge short .3
        LD xor, eax, eax
        mov al, byte [esi]
        inc esi
        shl eax, cl
        add ecx, byte 8
        LD or, ebp, eax
.3:
        dec edi
        jg short ReadVideoCodes.1
        mov dword [VideoCodePtr], esi
        mov dword [VideoBitCount], ebp
        mov dword [VideoBitBuffer], ecx
        ret
ReadVideoCodes_D4:
        mov dword [nosplit ebx*4+VideoCoefs], 0
        mov bl, byte [dword edi+VideoCodeLengthsFrom1]
        dec edi
ReadVideoCodes_E6:
        LD mov, eax, ebp
        LD xor, edx, edx
        and eax, 0FFh
        shr eax, 3
.4:
        mov dword [nosplit ebx*4+VideoCoefs], edx
        mov bl, byte [dword edi+VideoCodeLengthsFrom1]
        mov dword [nosplit ebx*4+VideoCoefs], edx
        mov bl, byte [dword edi+VideoCodeLengthsFrom2]
        sub edi, byte 2
        dec eax
        jne short .4
        inc edi
        jmp short ReadVideoCodes_115.6
ReadVideoCodes_115:
        LD mov, eax, ebp
        and eax, 0FCh
        cmp eax, 0FCh
        je short .5
        shl eax, 18h
        sar eax, 0Ah
        imul dword [nosplit ebx*4+VideoGammaTable]
        shl edx, 10h
        shr eax, 10h
        LD adc, eax, edx
        mov dword [nosplit ebx*4+VideoCoefs], eax
        jmp short .6
.5:
        shr ebp, 8
        mov al, byte [esi]
        inc esi
        sub ecx, byte 8
        shl eax, cl
        add ecx, byte 8
        LD or, ebp, eax
        LD mov, eax, ebp
        shl eax, 18h
        sar eax, 8
        imul dword [nosplit ebx*4+VideoGammaTable]
        shl edx, 10h
        shr eax, 10h
        LD adc, eax, edx
        mov dword [nosplit ebx*4+VideoCoefs], eax
.6:
        shr ebp, 8
        LD xor, eax, eax
        mov al, byte [esi]
        inc esi
        sub ecx, byte 8
        shl eax, cl
        add ecx, byte 8
        LD or, ebp, eax
        dec edi
        jg near ReadVideoCodes.1
        mov dword [VideoCodePtr], esi
        mov dword [VideoBitCount], ebp
        mov dword [VideoBitBuffer], ecx
        ret
;-----------------------------------------------------------------------------
; VideoBlockFill                                 117733  97 PC, low confidence
; Video player: fills a block with one colour
;-----------------------------------------------------------------------------
VideoBlockFill:
        mov ebx, dword [byte esi+014h]
        mov eax, dword [byte esi+0Ch]
        mov ecx, dword [byte esi+04h]
        mov edx, dword [byte esi+01Ch]
        LD or, ecx, ebx
        LD or, edx, eax
        mov edi, dword [byte esi+08h]
        mov ebp, dword [byte esi+018h]
        LD or, edx, ecx
        LD or, edi, ebp
        mov ecx, dword [byte esi+010h]
        LD or, edx, edi
        LD or, edx, ecx
        je near .1
        mov ecx, dword [byte esi+04h]
        mov edx, dword [byte esi+01Ch]
        lea edi, [eax+ebx]
        LD sub, ebx, eax
        lea eax, [edx+ecx]
        LD sub, ecx, edx
        mov dword [VideoBlockX], ebx
        mov dword [VideoBlockY], ecx
        lea ebp, [edi+eax]
        LD sub, eax, edi
        fild dword [VideoBlockX]
        fild dword [VideoBlockY]
        fld st0
        fmul dword [F32_1p30656]
        fxch st2
        fadd to st1
        fmul dword [F32_0p541196]
        fxch
        fmul dword [F32_0p382683]
        imul dword [VideoIdctScale]
        fadd to st1
        fsubp st2
        fadd dword [F32_6p7554e15]
        fxch
        fadd dword [F32_6p7554e15]
        mov eax, dword [byte esi+08h]
        mov ebx, dword [byte esi+018h]
        shl edx, 1
        fstp qword [VideoBlockTemp]
        fstp qword [VideoBlockX]
        mov ecx, dword [VideoBlockX]
        mov edi, dword [VideoBlockTemp]
        LD add, ecx, edx
        LD add, edx, edi
        LD add, edi, ebp
        mov dword [VideoBlockY], ecx
        mov dword [VideoBlockTemp], edx
        mov dword [VideoBlockSum], edi
        mov ecx, dword [esi]
        mov edx, dword [byte esi+010h]
        lea esi, [ebx+eax]
        LD sub, eax, ebx
        lea ebx, [edx+ecx]
        LD sub, ecx, edx
        imul dword [VideoIdctScale]
        shl edx, 1
        mov edi, dword [VideoOutPtr]
        LD add, esi, edx
        mov ebp, dword [VideoBlockY]
        lea eax, [edx+ecx]
        LD sub, ecx, edx
        lea edx, [esi+ebx]
        LD sub, ebx, esi
        lea esi, [ecx+ebp]
        LD sub, ecx, ebp
        mov ebp, dword [VideoBlockX]
        mov dword [byte edi+048h], esi
        mov esi, dword [VideoBlockTemp]
        mov dword [dword edi+0B4h], ecx
        lea ecx, [ebx+ebp]
        LD sub, ebx, ebp
        mov ebp, dword [VideoBlockSum]
        mov dword [byte edi+06Ch], ecx
        mov dword [dword edi+090h], ebx
        lea ebx, [esi+eax]
        LD sub, eax, esi
        lea ecx, [edx+ebp]
        LD sub, edx, ebp
        mov dword [edi], ecx
        mov dword [byte edi+024h], ebx
        mov dword [dword edi+0D8h], eax
        mov dword [dword edi+0FCh], edx
        ret
.1:
        mov eax, dword [esi]
        mov edi, dword [VideoOutPtr]
        mov dword [edi], eax
        mov dword [byte edi+024h], eax
        mov dword [byte edi+048h], eax
        mov dword [byte edi+06Ch], eax
        mov dword [dword edi+090h], eax
        mov dword [dword edi+0B4h], eax
        mov dword [dword edi+0D8h], eax
        mov dword [dword edi+0FCh], eax
        ret
;-----------------------------------------------------------------------------
; VideoBlockDelta                                117896  97 PC, low confidence
; Video player: draws a block as a change from the last frame
;-----------------------------------------------------------------------------
VideoBlockDelta:
        mov ebx, dword [byte esi+014h]
        mov eax, dword [byte esi+0Ch]
        mov ecx, dword [byte esi+04h]
        mov edx, dword [byte esi+01Ch]
        lea edi, [eax+ebx]
        LD sub, ebx, eax
        lea eax, [edx+ecx]
        LD sub, ecx, edx
        mov dword [VideoBlockX], ebx
        mov dword [VideoBlockY], ecx
        lea ebp, [edi+eax]
        LD sub, eax, edi
        fild dword [VideoBlockX]
        fild dword [VideoBlockY]
        fld st0
        fmul dword [F32_1p30656]
        fxch st2
        fadd to st1
        fmul dword [F32_0p541196]
        fxch
        fmul dword [F32_0p382683]
        imul dword [VideoIdctScale]
        fadd to st1
        fsubp st2
        fadd dword [F32_6p7554e15]
        fxch
        fadd dword [F32_6p7554e15]
        mov eax, dword [byte esi+08h]
        mov ebx, dword [byte esi+018h]
        shl edx, 1
        fstp qword [VideoBlockTemp]
        fstp qword [VideoBlockX]
        mov ecx, dword [VideoBlockX]
        mov edi, dword [VideoBlockTemp]
        LD add, ecx, edx
        LD add, edx, edi
        LD add, edi, ebp
        mov dword [VideoBlockY], ecx
        mov dword [VideoBlockTemp], edx
        mov dword [VideoBlockSum], edi
        mov ecx, dword [esi]
        mov edx, dword [byte esi+010h]
        lea esi, [ebx+eax]
        LD sub, eax, ebx
        lea ebx, [edx+ecx]
        LD sub, ecx, edx
        imul dword [VideoIdctScale]
        shl edx, 1
        mov edi, dword [VideoOutPtr]
        LD add, esi, edx
        mov ebp, dword [VideoBlockY]
        lea eax, [edx+ecx]
        LD sub, ecx, edx
        lea edx, [esi+ebx]
        LD sub, ebx, esi
        lea esi, [ecx+ebp]
        LD sub, ecx, ebp
        mov ebp, dword [VideoBlockX]
        mov dword [byte edi+08h], esi
        mov esi, dword [VideoBlockTemp]
        mov dword [byte edi+014h], ecx
        lea ecx, [ebx+ebp]
        LD sub, ebx, ebp
        mov ebp, dword [VideoBlockSum]
        mov dword [byte edi+0Ch], ecx
        mov dword [byte edi+010h], ebx
        lea ebx, [esi+eax]
        LD sub, eax, esi
        lea ecx, [edx+ebp]
        LD sub, edx, ebp
        mov dword [edi], ecx
        mov dword [byte edi+04h], ebx
        mov dword [byte edi+018h], eax
        mov dword [byte edi+01Ch], edx
        ret
;-----------------------------------------------------------------------------
; VideoBlockPattern                              1179A0  97 PC, low confidence
; Video player: draws a block from a two-colour pattern
;-----------------------------------------------------------------------------
VideoBlockPattern:
        mov eax, dword [esi]
        mov edx, dword [byte esi+04h]
        shr eax, 11h
        mov ecx, dword [ebx]
        shr edx, 11h
        mov ebp, dword [dword ebx+0100h]
        shr ecx, 11h
        and eax, byte 7Fh
        shr ebp, 11h
        and edx, byte 7Fh
        and ecx, byte 7Fh
        and ebp, byte 7Fh
        mov eax, dword [nosplit eax*4+VideoCodeTableC]
        mov edx, dword [nosplit edx*4+VideoCodeTableC]
        mov ecx, dword [nosplit ecx*4+VideoCodeTableA]
        mov ebp, dword [nosplit ebp*4+VideoCodeTableB]
        LD add, eax, ecx
        LD add, edx, ecx
        LD add, eax, ebp
        LD add, edx, ebp
        mov dword [edi], eax
        mov dword [byte edi+04h], edx
        mov eax, dword [byte esi+08h]
        mov edx, dword [byte esi+0Ch]
        shr eax, 11h
        mov ecx, dword [byte ebx+04h]
        shr edx, 11h
        mov ebp, dword [dword ebx+0104h]
        shr ecx, 11h
        and eax, byte 7Fh
        shr ebp, 11h
        and edx, byte 7Fh
        and ecx, byte 7Fh
        and ebp, byte 7Fh
        mov eax, dword [nosplit eax*4+VideoCodeTableC]
        mov edx, dword [nosplit edx*4+VideoCodeTableC]
        mov ecx, dword [nosplit ecx*4+VideoCodeTableA]
        mov ebp, dword [nosplit ebp*4+VideoCodeTableB]
        LD add, eax, ecx
        LD add, edx, ecx
        LD add, eax, ebp
        LD add, edx, ebp
        mov dword [byte edi+08h], eax
        mov dword [byte edi+0Ch], edx
        mov eax, dword [byte esi+010h]
        mov edx, dword [byte esi+014h]
        shr eax, 11h
        mov ecx, dword [byte ebx+08h]
        shr edx, 11h
        mov ebp, dword [dword ebx+0108h]
        shr ecx, 11h
        and eax, byte 7Fh
        shr ebp, 11h
        and edx, byte 7Fh
        and ecx, byte 7Fh
        and ebp, byte 7Fh
        mov eax, dword [nosplit eax*4+VideoCodeTableC]
        mov edx, dword [nosplit edx*4+VideoCodeTableC]
        mov ecx, dword [nosplit ecx*4+VideoCodeTableA]
        mov ebp, dword [nosplit ebp*4+VideoCodeTableB]
        LD add, eax, ecx
        LD add, edx, ecx
        LD add, eax, ebp
        LD add, edx, ebp
        mov dword [byte edi+010h], eax
        mov dword [byte edi+014h], edx
        mov eax, dword [byte esi+018h]
        mov edx, dword [byte esi+01Ch]
        shr eax, 11h
        mov ecx, dword [byte ebx+0Ch]
        shr edx, 11h
        mov ebp, dword [dword ebx+010Ch]
        shr ecx, 11h
        and eax, byte 7Fh
        shr ebp, 11h
        and edx, byte 7Fh
        and ecx, byte 7Fh
        and ebp, byte 7Fh
        mov eax, dword [nosplit eax*4+VideoCodeTableC]
        mov edx, dword [nosplit edx*4+VideoCodeTableC]
        mov ecx, dword [nosplit ecx*4+VideoCodeTableA]
        mov ebp, dword [nosplit ebp*4+VideoCodeTableB]
        LD add, eax, ecx
        LD add, edx, ecx
        LD add, eax, ebp
        LD add, edx, ebp
        mov dword [byte edi+018h], eax
        mov dword [byte edi+01Ch], edx
        mov eax, dword [byte esi+020h]
        mov edx, dword [byte esi+024h]
        shr eax, 11h
        mov ecx, dword [byte ebx+010h]
        shr edx, 11h
        mov ebp, dword [dword ebx+0110h]
        shr ecx, 11h
        and eax, byte 7Fh
        shr ebp, 11h
        and edx, byte 7Fh
        and ecx, byte 7Fh
        and ebp, byte 7Fh
        mov eax, dword [nosplit eax*4+VideoCodeTableC]
        mov edx, dword [nosplit edx*4+VideoCodeTableC]
        mov ecx, dword [nosplit ecx*4+VideoCodeTableA]
        mov ebp, dword [nosplit ebp*4+VideoCodeTableB]
        LD add, eax, ecx
        LD add, edx, ecx
        LD add, eax, ebp
        LD add, edx, ebp
        mov dword [byte edi+020h], eax
        mov dword [byte edi+024h], edx
        mov eax, dword [byte esi+028h]
        mov edx, dword [byte esi+02Ch]
        shr eax, 11h
        mov ecx, dword [byte ebx+014h]
        shr edx, 11h
        mov ebp, dword [dword ebx+0114h]
        shr ecx, 11h
        and eax, byte 7Fh
        shr ebp, 11h
        and edx, byte 7Fh
        and ecx, byte 7Fh
        and ebp, byte 7Fh
        mov eax, dword [nosplit eax*4+VideoCodeTableC]
        mov edx, dword [nosplit edx*4+VideoCodeTableC]
        mov ecx, dword [nosplit ecx*4+VideoCodeTableA]
        mov ebp, dword [nosplit ebp*4+VideoCodeTableB]
        LD add, eax, ecx
        LD add, edx, ecx
        LD add, eax, ebp
        LD add, edx, ebp
        mov dword [byte edi+028h], eax
        mov dword [byte edi+02Ch], edx
        mov eax, dword [byte esi+030h]
        mov edx, dword [byte esi+034h]
        shr eax, 11h
        mov ecx, dword [byte ebx+018h]
        shr edx, 11h
        mov ebp, dword [dword ebx+0118h]
        shr ecx, 11h
        and eax, byte 7Fh
        shr ebp, 11h
        and edx, byte 7Fh
        and ecx, byte 7Fh
        and ebp, byte 7Fh
        mov eax, dword [nosplit eax*4+VideoCodeTableC]
        mov edx, dword [nosplit edx*4+VideoCodeTableC]
        mov ecx, dword [nosplit ecx*4+VideoCodeTableA]
        mov ebp, dword [nosplit ebp*4+VideoCodeTableB]
        LD add, eax, ecx
        LD add, edx, ecx
        LD add, eax, ebp
        LD add, edx, ebp
        mov dword [byte edi+030h], eax
        mov dword [byte edi+034h], edx
        mov eax, dword [byte esi+038h]
        mov edx, dword [byte esi+03Ch]
        shr eax, 11h
        mov ecx, dword [byte ebx+01Ch]
        shr edx, 11h
        mov ebp, dword [dword ebx+011Ch]
        shr ecx, 11h
        and eax, byte 7Fh
        shr ebp, 11h
        and edx, byte 7Fh
        and ecx, byte 7Fh
        and ebp, byte 7Fh
        mov eax, dword [nosplit eax*4+VideoCodeTableC]
        mov edx, dword [nosplit edx*4+VideoCodeTableC]
        mov ecx, dword [nosplit ecx*4+VideoCodeTableA]
        mov ebp, dword [nosplit ebp*4+VideoCodeTableB]
        LD add, eax, ecx
        LD add, edx, ecx
        LD add, eax, ebp
        LD add, edx, ebp
        mov dword [byte edi+038h], eax
        mov dword [byte edi+03Ch], edx
        ret
;-----------------------------------------------------------------------------
; DecodeVideoFrame                               117C26  97 PC, low confidence
; Video player: decodes one frame block by block
;-----------------------------------------------------------------------------
DecodeVideoFrame:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov esi, dword [byte esp+01Ch]
        LD xor, eax, eax
        mov al, byte [esi]
        inc esi
        mov dword [VideoCodePtr], esi
        mov dword [VideoBitCount], eax
        mov dword [VideoBitBuffer], 8
        call ReadVideoCodes
        mov esi, VideoCoefs
        mov dword [VideoOutPtr], VideoIdctTemp
        call VideoBlockFill
        mov esi, VideoCoefs+20h
        mov dword [VideoOutPtr], VideoIdctTemp+4
        call VideoBlockFill
        mov esi, VideoCoefs+40h
        mov dword [VideoOutPtr], VideoIdctTemp+8
        call VideoBlockFill
        mov esi, VideoCoefs+60h
        mov dword [VideoOutPtr], VideoIdctTemp+0Ch
        call VideoBlockFill
        mov esi, VideoCoefs+80h
        mov dword [VideoOutPtr], VideoIdctTemp+10h
        call VideoBlockFill
        mov esi, VideoCoefs+0A0h
        mov dword [VideoOutPtr], VideoIdctTemp+14h
        call VideoBlockFill
        mov esi, VideoCoefs+0C0h
        mov dword [VideoOutPtr], VideoIdctTemp+18h
        call VideoBlockFill
        mov esi, VideoCoefs+0E0h
        mov dword [VideoOutPtr], VideoIdctTemp+1Ch
        call VideoBlockFill
        mov esi, VideoIdctTemp
        mov dword [VideoOutPtr], VideoIdctOut
        call VideoBlockDelta
        mov esi, VideoIdctTemp+24h
        mov dword [VideoOutPtr], VideoIdctOut+40h
        call VideoBlockDelta
        mov esi, VideoIdctTemp+48h
        mov dword [VideoOutPtr], VideoIdctOut+80h
        call VideoBlockDelta
        mov esi, VideoIdctTemp+6Ch
        mov dword [VideoOutPtr], VideoIdctOut+0C0h
        call VideoBlockDelta
        mov esi, VideoIdctTemp+90h
        mov dword [VideoOutPtr], VideoIdctOut+100h
        call VideoBlockDelta
        mov esi, VideoIdctTemp+0B4h
        mov dword [VideoOutPtr], VideoIdctOut+140h
        call VideoBlockDelta
        mov esi, VideoIdctTemp+0D8h
        mov dword [VideoOutPtr], VideoIdctOut+180h
        call VideoBlockDelta
        mov esi, VideoIdctTemp+0FCh
        mov dword [VideoOutPtr], VideoIdctOut+1C0h
        call VideoBlockDelta
        call ReadVideoCodes
        mov esi, VideoCoefs
        mov dword [VideoOutPtr], VideoIdctTemp
        call VideoBlockFill
        mov esi, VideoCoefs+20h
        mov dword [VideoOutPtr], VideoIdctTemp+4
        call VideoBlockFill
        mov esi, VideoCoefs+40h
        mov dword [VideoOutPtr], VideoIdctTemp+8
        call VideoBlockFill
        mov esi, VideoCoefs+60h
        mov dword [VideoOutPtr], VideoIdctTemp+0Ch
        call VideoBlockFill
        mov esi, VideoCoefs+80h
        mov dword [VideoOutPtr], VideoIdctTemp+10h
        call VideoBlockFill
        mov esi, VideoCoefs+0A0h
        mov dword [VideoOutPtr], VideoIdctTemp+14h
        call VideoBlockFill
        mov esi, VideoCoefs+0C0h
        mov dword [VideoOutPtr], VideoIdctTemp+18h
        call VideoBlockFill
        mov esi, VideoCoefs+0E0h
        mov dword [VideoOutPtr], VideoIdctTemp+1Ch
        call VideoBlockFill
        mov esi, VideoIdctTemp
        mov dword [VideoOutPtr], VideoIdctOut+20h
        call VideoBlockDelta
        mov esi, VideoIdctTemp+24h
        mov dword [VideoOutPtr], VideoIdctOut+60h
        call VideoBlockDelta
        mov esi, VideoIdctTemp+48h
        mov dword [VideoOutPtr], VideoIdctOut+0A0h
        call VideoBlockDelta
        mov esi, VideoIdctTemp+6Ch
        mov dword [VideoOutPtr], VideoIdctOut+0E0h
        call VideoBlockDelta
        mov esi, VideoIdctTemp+90h
        mov dword [VideoOutPtr], VideoIdctOut+120h
        call VideoBlockDelta
        mov esi, VideoIdctTemp+0B4h
        mov dword [VideoOutPtr], VideoIdctOut+160h
        call VideoBlockDelta
        mov esi, VideoIdctTemp+0D8h
        mov dword [VideoOutPtr], VideoIdctOut+1A0h
        call VideoBlockDelta
        mov esi, VideoIdctTemp+0FCh
        mov dword [VideoOutPtr], VideoIdctOut+1E0h
        call VideoBlockDelta
        call ReadVideoCodes
        mov esi, VideoCoefs
        mov dword [VideoOutPtr], VideoIdctTemp
        call VideoBlockFill
        mov esi, VideoCoefs+20h
        mov dword [VideoOutPtr], VideoIdctTemp+4
        call VideoBlockFill
        mov esi, VideoCoefs+40h
        mov dword [VideoOutPtr], VideoIdctTemp+8
        call VideoBlockFill
        mov esi, VideoCoefs+60h
        mov dword [VideoOutPtr], VideoIdctTemp+0Ch
        call VideoBlockFill
        mov esi, VideoCoefs+80h
        mov dword [VideoOutPtr], VideoIdctTemp+10h
        call VideoBlockFill
        mov esi, VideoCoefs+0A0h
        mov dword [VideoOutPtr], VideoIdctTemp+14h
        call VideoBlockFill
        mov esi, VideoCoefs+0C0h
        mov dword [VideoOutPtr], VideoIdctTemp+18h
        call VideoBlockFill
        mov esi, VideoCoefs+0E0h
        mov dword [VideoOutPtr], VideoIdctTemp+1Ch
        call VideoBlockFill
        mov esi, VideoIdctTemp
        mov dword [VideoOutPtr], VideoIdctOut+200h
        call VideoBlockDelta
        mov esi, VideoIdctTemp+24h
        mov dword [VideoOutPtr], VideoIdctOut+240h
        call VideoBlockDelta
        mov esi, VideoIdctTemp+48h
        mov dword [VideoOutPtr], VideoIdctOut+280h
        call VideoBlockDelta
        mov esi, VideoIdctTemp+6Ch
        mov dword [VideoOutPtr], VideoIdctOut+2C0h
        call VideoBlockDelta
        mov esi, VideoIdctTemp+90h
        mov dword [VideoOutPtr], VideoIdctOut+300h
        call VideoBlockDelta
        mov esi, VideoIdctTemp+0B4h
        mov dword [VideoOutPtr], VideoIdctOut+340h
        call VideoBlockDelta
        mov esi, VideoIdctTemp+0D8h
        mov dword [VideoOutPtr], VideoIdctOut+380h
        call VideoBlockDelta
        mov esi, VideoIdctTemp+0FCh
        mov dword [VideoOutPtr], VideoIdctOut+3C0h
        call VideoBlockDelta
        call ReadVideoCodes
        mov esi, VideoCoefs
        mov dword [VideoOutPtr], VideoIdctTemp
        call VideoBlockFill
        mov esi, VideoCoefs+20h
        mov dword [VideoOutPtr], VideoIdctTemp+4
        call VideoBlockFill
        mov esi, VideoCoefs+40h
        mov dword [VideoOutPtr], VideoIdctTemp+8
        call VideoBlockFill
        mov esi, VideoCoefs+60h
        mov dword [VideoOutPtr], VideoIdctTemp+0Ch
        call VideoBlockFill
        mov esi, VideoCoefs+80h
        mov dword [VideoOutPtr], VideoIdctTemp+10h
        call VideoBlockFill
        mov esi, VideoCoefs+0A0h
        mov dword [VideoOutPtr], VideoIdctTemp+14h
        call VideoBlockFill
        mov esi, VideoCoefs+0C0h
        mov dword [VideoOutPtr], VideoIdctTemp+18h
        call VideoBlockFill
        mov esi, VideoCoefs+0E0h
        mov dword [VideoOutPtr], VideoIdctTemp+1Ch
        call VideoBlockFill
        mov esi, VideoIdctTemp
        mov dword [VideoOutPtr], VideoIdctOut+220h
        call VideoBlockDelta
        mov esi, VideoIdctTemp+24h
        mov dword [VideoOutPtr], VideoIdctOut+260h
        call VideoBlockDelta
        mov esi, VideoIdctTemp+48h
        mov dword [VideoOutPtr], VideoIdctOut+2A0h
        call VideoBlockDelta
        mov esi, VideoIdctTemp+6Ch
        mov dword [VideoOutPtr], VideoIdctOut+2E0h
        call VideoBlockDelta
        mov esi, VideoIdctTemp+90h
        mov dword [VideoOutPtr], VideoIdctOut+320h
        call VideoBlockDelta
        mov esi, VideoIdctTemp+0B4h
        mov dword [VideoOutPtr], VideoIdctOut+360h
        call VideoBlockDelta
        mov esi, VideoIdctTemp+0D8h
        mov dword [VideoOutPtr], VideoIdctOut+3A0h
        call VideoBlockDelta
        mov esi, VideoIdctTemp+0FCh
        mov dword [VideoOutPtr], VideoIdctOut+3E0h
        call VideoBlockDelta
        call ReadVideoCodes
        mov esi, VideoCoefs
        mov dword [VideoOutPtr], VideoIdctTemp
        call VideoBlockFill
        mov esi, VideoCoefs+20h
        mov dword [VideoOutPtr], VideoIdctTemp+4
        call VideoBlockFill
        mov esi, VideoCoefs+40h
        mov dword [VideoOutPtr], VideoIdctTemp+8
        call VideoBlockFill
        mov esi, VideoCoefs+60h
        mov dword [VideoOutPtr], VideoIdctTemp+0Ch
        call VideoBlockFill
        mov esi, VideoCoefs+80h
        mov dword [VideoOutPtr], VideoIdctTemp+10h
        call VideoBlockFill
        mov esi, VideoCoefs+0A0h
        mov dword [VideoOutPtr], VideoIdctTemp+14h
        call VideoBlockFill
        mov esi, VideoCoefs+0C0h
        mov dword [VideoOutPtr], VideoIdctTemp+18h
        call VideoBlockFill
        mov esi, VideoCoefs+0E0h
        mov dword [VideoOutPtr], VideoIdctTemp+1Ch
        call VideoBlockFill
        mov esi, VideoIdctTemp
        mov dword [VideoOutPtr], VideoIdctOut+400h
        call VideoBlockDelta
        mov esi, VideoIdctTemp+24h
        mov dword [VideoOutPtr], VideoIdctOut+420h
        call VideoBlockDelta
        mov esi, VideoIdctTemp+48h
        mov dword [VideoOutPtr], VideoIdctOut+440h
        call VideoBlockDelta
        mov esi, VideoIdctTemp+6Ch
        mov dword [VideoOutPtr], VideoIdctOut+460h
        call VideoBlockDelta
        mov esi, VideoIdctTemp+90h
        mov dword [VideoOutPtr], VideoIdctOut+480h
        call VideoBlockDelta
        mov esi, VideoIdctTemp+0B4h
        mov dword [VideoOutPtr], VideoIdctOut+4A0h
        call VideoBlockDelta
        mov esi, VideoIdctTemp+0D8h
        mov dword [VideoOutPtr], VideoIdctOut+4C0h
        call VideoBlockDelta
        mov esi, VideoIdctTemp+0FCh
        mov dword [VideoOutPtr], VideoIdctOut+4E0h
        call VideoBlockDelta
        call ReadVideoCodes
        mov esi, VideoCoefs
        mov dword [VideoOutPtr], VideoIdctTemp
        call VideoBlockFill
        mov esi, VideoCoefs+20h
        mov dword [VideoOutPtr], VideoIdctTemp+4
        call VideoBlockFill
        mov esi, VideoCoefs+40h
        mov dword [VideoOutPtr], VideoIdctTemp+8
        call VideoBlockFill
        mov esi, VideoCoefs+60h
        mov dword [VideoOutPtr], VideoIdctTemp+0Ch
        call VideoBlockFill
        mov esi, VideoCoefs+80h
        mov dword [VideoOutPtr], VideoIdctTemp+10h
        call VideoBlockFill
        mov esi, VideoCoefs+0A0h
        mov dword [VideoOutPtr], VideoIdctTemp+14h
        call VideoBlockFill
        mov esi, VideoCoefs+0C0h
        mov dword [VideoOutPtr], VideoIdctTemp+18h
        call VideoBlockFill
        mov esi, VideoCoefs+0E0h
        mov dword [VideoOutPtr], VideoIdctTemp+1Ch
        call VideoBlockFill
        mov esi, VideoIdctTemp
        mov dword [VideoOutPtr], VideoIdctOut+500h
        call VideoBlockDelta
        mov esi, VideoIdctTemp+24h
        mov dword [VideoOutPtr], VideoIdctOut+520h
        call VideoBlockDelta
        mov esi, VideoIdctTemp+48h
        mov dword [VideoOutPtr], VideoIdctOut+540h
        call VideoBlockDelta
        mov esi, VideoIdctTemp+6Ch
        mov dword [VideoOutPtr], VideoIdctOut+560h
        call VideoBlockDelta
        mov esi, VideoIdctTemp+90h
        mov dword [VideoOutPtr], VideoIdctOut+580h
        call VideoBlockDelta
        mov esi, VideoIdctTemp+0B4h
        mov dword [VideoOutPtr], VideoIdctOut+5A0h
        call VideoBlockDelta
        mov esi, VideoIdctTemp+0D8h
        mov dword [VideoOutPtr], VideoIdctOut+5C0h
        call VideoBlockDelta
        mov esi, VideoIdctTemp+0FCh
        mov dword [VideoOutPtr], VideoIdctOut+5E0h
        call VideoBlockDelta
        mov edi, dword [byte esp+020h]
        mov esi, VideoIdctOut
        mov ebx, VideoIdctOut+400h
        call VideoBlockPattern
        add edi, dword [byte esp+024h]
        mov esi, VideoIdctOut+40h
        mov ebx, VideoIdctOut+400h
        call VideoBlockPattern
        add edi, dword [byte esp+024h]
        mov esi, VideoIdctOut+80h
        mov ebx, VideoIdctOut+420h
        call VideoBlockPattern
        add edi, dword [byte esp+024h]
        mov esi, VideoIdctOut+0C0h
        mov ebx, VideoIdctOut+420h
        call VideoBlockPattern
        add edi, dword [byte esp+024h]
        mov esi, VideoIdctOut+100h
        mov ebx, VideoIdctOut+440h
        call VideoBlockPattern
        add edi, dword [byte esp+024h]
        mov esi, VideoIdctOut+140h
        mov ebx, VideoIdctOut+440h
        call VideoBlockPattern
        add edi, dword [byte esp+024h]
        mov esi, VideoIdctOut+180h
        mov ebx, VideoIdctOut+460h
        call VideoBlockPattern
        add edi, dword [byte esp+024h]
        mov esi, VideoIdctOut+1C0h
        mov ebx, VideoIdctOut+460h
        call VideoBlockPattern
        add edi, dword [byte esp+024h]
        mov esi, VideoIdctOut+200h
        mov ebx, VideoIdctOut+480h
        call VideoBlockPattern
        add edi, dword [byte esp+024h]
        mov esi, VideoIdctOut+240h
        mov ebx, VideoIdctOut+480h
        call VideoBlockPattern
        add edi, dword [byte esp+024h]
        mov esi, VideoIdctOut+280h
        mov ebx, VideoIdctOut+4A0h
        call VideoBlockPattern
        add edi, dword [byte esp+024h]
        mov esi, VideoIdctOut+2C0h
        mov ebx, VideoIdctOut+4A0h
        call VideoBlockPattern
        add edi, dword [byte esp+024h]
        mov esi, VideoIdctOut+300h
        mov ebx, VideoIdctOut+4C0h
        call VideoBlockPattern
        add edi, dword [byte esp+024h]
        mov esi, VideoIdctOut+340h
        mov ebx, VideoIdctOut+4C0h
        call VideoBlockPattern
        add edi, dword [byte esp+024h]
        mov esi, VideoIdctOut+380h
        mov ebx, VideoIdctOut+4E0h
        call VideoBlockPattern
        add edi, dword [byte esp+024h]
        mov esi, VideoIdctOut+3C0h
        mov ebx, VideoIdctOut+4E0h
        call VideoBlockPattern
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
