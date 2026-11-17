; EA library: SetTextFont, FillShadowRect, DrawTitleBand.
bits 32
%include "hockey.inc"
section s_11FAAC progbits alloc exec nowrite align=1
extern ClipLeftCol, ClipRight, ClipTopRow, CurrentFont, FillBandEdges, FillBandRows, FillBandRowsBlend, FillRectColor
extern FillRectList, PrepareTextDraw, ScreenHeight, SetupRectFill, SetupRectFillShaded, ShadowFillFunc, TitleBandFunc
global SetTextFont, FillShadowRect, FillShadowRect_10, DrawTitleBand, DrawTitleBand_10, DrawTitleBand_27
;-----------------------------------------------------------------------------
; SetTextFont                                    11FAAC  97 PC, low confidence
; Sets the current text font and prepares text drawing; followed by the
; getter
;-----------------------------------------------------------------------------
SetTextFont:
        mov eax, dword [byte esp+04h]
        mov dword [CurrentFont], eax
        jmp near PrepareTextDraw
        db 08Bh,0C0h
        mov eax, dword [CurrentFont]
        ret
        db 00h,00h
        push ebp
        LD mov, ebp, esp
        add esp, 0FFFFD6F4h
        push ebx
        push esi
        push edi
        mov byte [byte ebp-011h], 1
        jmp short FillShadowRect_10
;-----------------------------------------------------------------------------
; FillShadowRect                                 11FAD6  97 PC, low confidence
; Entry that sets the rectangle fill callbacks and draws a shadowed rectangle
;-----------------------------------------------------------------------------
FillShadowRect:
        push ebp
        LD mov, ebp, esp
        add esp, 0FFFFD6F4h
        push ebx
        push esi
        push edi
        mov byte [byte ebp-011h], 0
FillShadowRect_10:
        mov eax, FillRectList
        mov dword [ShadowFillFunc], eax
        mov eax, FillRectColor
        mov dword [TitleBandFunc], eax
        mov esi, dword [byte ebp+010h]
        jmp short DrawTitleBand_27
        push ebp
        LD mov, ebp, esp
        add esp, 0FFFFD6F4h
        push ebx
        push esi
        push edi
        mov byte [byte ebp-011h], 1
        jmp short DrawTitleBand_10
;-----------------------------------------------------------------------------
; DrawTitleBand                                  11FB11  97 PC, low confidence
; Entry that sets the fill callbacks and draws a shaded title band
;-----------------------------------------------------------------------------
DrawTitleBand:
        db 055h                                 ; insn: push ebp
        LD mov, ebp, esp
        add esp, 0FFFFD6F4h
        push ebx
        push esi
        push edi
        mov byte [byte ebp-011h], 0
DrawTitleBand_10:
        mov eax, FillRectList
        mov dword [ShadowFillFunc], eax
        mov eax, FillRectColor
        mov dword [TitleBandFunc], eax
        lea esi, [byte ebp+010h]
DrawTitleBand_27:
        mov dword [byte ebp-0Ch], esi
        mov ecx, dword [byte ebp+0Ch]
        LD mov, eax, ecx
        dec eax
        lea eax, [esi+eax*8]
        mov dword [byte ebp-010h], eax
        cld
        lea eax, [dword ebp-0282Ch]
        mov dword [byte ebp-02Ch], eax
        mov eax, dword [ClipTopRow]
        mov dword [byte ebp-04h], eax
        mov eax, dword [ClipRight]
        dec eax
        mov dword [byte ebp-08h], eax
        mov eax, dword [byte esi+04h]
        mov dword [byte ebp-018h], eax
        mov dword [byte ebp-020h], eax
        mov ebx, dword [esi]
        LD mov, edx, ebx
        mov dword [byte ebp-01Ch], esi
        mov dword [byte ebp-024h], esi
        add esi, byte 8
        dec ecx
        jne short .1
        push dword [byte ebp+08h]
        mov esi, dword [byte ebp-0Ch]
        push dword [byte esi+04h]
        push dword [esi]
        push dword [byte esi+04h]
        push dword [esi]
        call dword [TitleBandFunc]
        add esp, byte 14h
        pop edi
        pop esi
        pop ebx
        leave
        ret
.1:
        mov eax, dword [byte esi+04h]
        cmp eax, dword [byte ebp-018h]
        jg short .2
        mov dword [byte ebp-018h], eax
        mov dword [byte ebp-01Ch], esi
.2:
        cmp eax, dword [byte ebp-020h]
        jle short .3
        mov dword [byte ebp-020h], eax
        mov dword [byte ebp-024h], esi
.3:
        mov eax, dword [esi]
        LD cmp, eax, ebx
        jge short .4
        LD mov, ebx, eax
.4:
        LD cmp, eax, edx
        jle short .5
        LD mov, edx, eax
.5:
        add esi, byte 8
        dec ecx
        jne short .1
        mov eax, dword [byte ebp-020h]
        sub eax, dword [byte ebp-018h]
        cmp eax, byte 0
        jle short .9
        cmp edx, dword [byte ebp-04h]
        jl short .9
        cmp ebx, dword [byte ebp-08h]
        jge short .9
        mov eax, dword [byte ebp-020h]
        cmp eax, dword [ClipLeftCol]
        jl short .9
        mov ecx, dword [byte ebp-018h]
        cmp ecx, dword [ScreenHeight]
        jge short .9
        mov byte [byte ebp-012h], 0
        cmp edx, dword [byte ebp-08h]
        jg short .6
        cmp ebx, dword [byte ebp-04h]
        jl short .6
        cmp eax, dword [ScreenHeight]
        jge short .6
        cmp ecx, dword [ClipLeftCol]
        jge short .7
.6:
        mov byte [byte ebp-012h], 1
.7:
        LD cmp, eax, ecx
        je short .8
        LD cmp, edx, ebx
        jne short .10
.8:
        push dword [byte ebp+08h]
        mov esi, dword [byte ebp-0Ch]
        push eax
        push edx
        push ecx
        push ebx
        call dword [TitleBandFunc]
        add esp, byte 14h
.9:
        pop edi
        pop esi
        pop ebx
        leave
        ret
.10:
        lea esi, [dword ebp-0290Ch]
        mov edi, dword [byte ebp-01Ch]
.11:
        mov eax, dword [byte edi+04h]
        mov ecx, dword [edi]
        add edi, byte 8
        cmp edi, dword [byte ebp-010h]
        jbe short .12
        mov edi, dword [byte ebp-0Ch]
.12:
        mov edx, dword [byte edi+04h]
        LD cmp, edx, eax
        jle short .15
        push esi
        push edx
        push dword [edi]
        push eax
        push ecx
        cmp byte [byte ebp-012h], 0
        je short .13
        call SetupRectFill
        mov dword [byte ebp-028h], edi
        call FillBandEdges
        jmp short .14
.13:
        call SetupRectFillShaded
        mov dword [byte ebp-028h], edi
        call FillBandRows
.14:
        mov edi, dword [byte ebp-028h]
        add esp, byte 14h
.15:
        cmp edi, dword [byte ebp-024h]
        jne short .11
        mov edi, dword [byte ebp-01Ch]
.16:
        mov eax, dword [byte edi+04h]
        mov ecx, dword [edi]
        sub edi, byte 8
        cmp edi, dword [byte ebp-0Ch]
        jae short .17
        mov edi, dword [byte ebp-010h]
.17:
        mov edx, dword [byte edi+04h]
        LD cmp, edx, eax
        jle short .20
        push esi
        push edx
        push dword [edi]
        push eax
        push ecx
        cmp byte [byte ebp-012h], 0
        je short .18
        call SetupRectFill
        jmp short .19
.18:
        call SetupRectFillShaded
.19:
        mov dword [byte ebp-028h], edi
        call FillBandRowsBlend
        mov edi, dword [byte ebp-028h]
        add esp, byte 14h
.20:
        cmp edi, dword [byte ebp-024h]
        jne short .16
        mov eax, dword [byte ebp-020h]
        cmp eax, dword [ScreenHeight]
        jl short .21
        mov eax, dword [ScreenHeight]
        dec eax
.21:
        mov ebx, dword [byte ebp-018h]
        cmp ebx, dword [ClipLeftCol]
        jge short .22
        mov ebx, dword [ClipLeftCol]
.22:
        LD sub, eax, ebx
        jle short .23
        inc eax
        push dword [byte ebp+08h]
        push eax
        push ebx
        lea ebx, [nosplit ebx*4+00h]
        lea eax, [dword ebp-0142Ch]
        LD add, eax, ebx
        push eax
        lea eax, [dword ebp-0282Ch]
        LD add, eax, ebx
        push eax
        call dword [ShadowFillFunc]
        add esp, byte 14h
.23:
        pop edi
        pop esi
        pop ebx
        leave
        ret
