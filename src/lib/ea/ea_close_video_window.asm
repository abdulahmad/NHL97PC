; EA library: CloseVideoWindow, SetGraphicsMode, WritePaletteRegs, AllocRowTable, FreeRowTable.
bits 32
%include "hockey.inc"
section s_103232 progbits alloc exec nowrite align=1
extern AllocMemBlock, BackBufferHeight, BackBufferWidth, BytesPerPixelForDepth, CurrentDrawContext, DefaultModeHeight, DefaultModeWidth, FillRowTable
extern FindClosestMode, FrameCounter, FreeBitmap, FreeMemBlock, GraphicsModeSet, MenuScreenBitmap, MessageBoxActive, ModeBankSize
extern ModeBitsPerPixel, ModeFrameBuffer, ModeHeight, ModeLinear, ModePitch, ModeSetCount, ModeTableBpp, ModeTableHeight
extern ModeTableNumber, ModeTableWidth, ModeWidth, PaletteDirty, PaletteWords, removewindow, RowTable, RowTableBytes
extern RowTableSize, SaveTextMode, ScreenModeHeight, ScreenModeWidth, ScreenWidth, SetScreenTarget, str_Punct_SetGraphicsMode, str_Rowtbl
extern VesaBank, VesaBankFunc, VesaGetModeInfo, VesaSetBank, VesaSetMode, VesaSetWindow, VideoModeHook, VideoModeIndex
extern VideoModeNumber, VideoWindowHandle, VideoWindowTable, ViewScreenHeight, ViewScreenWidth
global CloseVideoWindow, SetGraphicsMode, WritePaletteRegs, AllocRowTable, FreeRowTable
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; CloseVideoWindow                               103234  97 PC, low confidence
; Removes the current video window and rebuilds the row table
;-----------------------------------------------------------------------------
CloseVideoWindow:
        push ebx
        push esi
        push edi
        mov ecx, dword [byte esp+010h]
        mov esi, dword [byte esp+014h]
        mov edx, dword [VideoWindowHandle]
        mov ebx, dword [byte ecx+04h]
        test edx, edx
        je short .1
        mov eax, edx
        call removewindow
.1:
        mov edx, esi
        xor edi, edi
        xor eax, eax
        mov dword [byte ecx+020h], esi
        mov dword [VideoWindowHandle], edi
        call FillRowTable
        mov ebx, 10000h
        mov dword [byte ecx+028h], eax
        xor ecx, ecx
.2:
        mov edx, ebx
        mov eax, ebx
        sar edx, 1Fh
        idiv esi
        add ecx, byte 4
        add ebx, 10000h
        mov dword [dword ecx+VideoWindowTable], eax
        cmp ecx, 140h
        jne short .2
        pop edi
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; SetGraphicsMode                                103298  97 PC, low confidence
; Switches to a graphics mode: saves the text mode, sets the VESA or VGA mode
; and builds the row table
;-----------------------------------------------------------------------------
SetGraphicsMode:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, 15Ch
        mov edx, dword [VideoModeHook]
        xor edi, edi
        test edx, edx
        je short .1
        mov ebx, dword [dword esp+0178h]
        push ebx
        mov ecx, dword [dword esp+0178h]
        push ecx
        mov edi, dword [dword esp+0178h]
        push edi
        call dword [VideoModeHook]
        add esp, byte 0Ch
        mov edi, eax
        test eax, eax
        jne near .26
.1:
        cmp dword [GraphicsModeSet], byte 0
        jne short .2
        call SaveTextMode
        call AllocRowTable
.2:
        mov eax, dword [VideoWindowHandle]
        test eax, eax
        je short .3
        call removewindow
.3:
        mov edx, dword [ModeLinear]
        test edx, edx
        je short .4
        mov eax, edx
        call removewindow
.4:
        xor ebx, ebx
        mov ebp, dword [dword esp+0170h]
        mov dword [ModeLinear], ebx
        mov dword [VideoWindowHandle], ebx
        test ebp, ebp
        jne short .5
        mov dword [dword esp+0170h], 280h
.5:
        cmp dword [dword esp+0174h], byte 0
        jne short .6
        mov dword [dword esp+0174h], 1E0h
.6:
        cmp dword [dword esp+0178h], byte 0
        jne short .7
        mov dword [dword esp+0178h], 10h
.7:
        xor ebp, ebp
        mov dword [dword esp+0154h], ebp
.8:
        mov ecx, dword [dword esp+0178h]
        mov ebx, dword [dword esp+0174h]
        mov edx, dword [dword esp+0170h]
        mov eax, ebp
        call FindClosestMode
        mov edx, dword [dword esp+0154h]
        add edx, byte 4
        inc ebp
        mov dword [dword esp+edx+0FCh], eax
        mov dword [dword esp+0154h], edx
        cmp ebp, byte 15h
        jl short .8
        xor ebp, ebp
.9:
        test edi, edi
        jne near .15
        mov esi, ebp
        mov eax, ebp
        mov edx, ebp
.10:
        mov ecx, dword [dword esp+edx+0100h]
        cmp ecx, dword [dword esp+esi*4+0100h]
        jg short .11
        mov esi, eax
.11:
        inc eax
        add edx, byte 4
        cmp eax, byte 15h
        jl short .10
        mov eax, esi
        call VesaSetMode
        mov edi, eax
        cmp eax, byte 2
        jne short .14
        mov ebx, esi
        shl ebx, 4
        mov edx, esp
        mov eax, dword [dword ebx+ModeTableNumber]
        call VesaGetModeInfo
        mov ecx, dword [byte esp+0Eh]
        mov edi, eax
        mov edx, dword [dword ebx+ModeTableHeight]
        sar ecx, 10h
        test eax, eax
        je short .13
        imul edx, ecx
        mov eax, dword [byte esp+028h]
        call VesaSetWindow
        mov dword [dword esp+0158h], eax
        test eax, eax
        jne short .12
        mov edi, ebp
        jmp short .13
.12:
        mov edi, 2
.13:
        test edi, edi
        jne short .9
        mov dword [VideoModeIndex], ebp
        jmp near .9
.14:
        test eax, eax
        jne near .9
        mov dword [dword esp+esi*4+0100h], 7FFFFFFFh
        jmp near .9
.15:
        mov ecx, esi
        shl ecx, 4
        xor ebp, ebp
        mov ebx, dword [dword ecx+ModeTableWidth]
        mov ecx, dword [dword ecx+ModeTableHeight]
        cmp edi, byte 2
        jne short .16
        mov ebp, 1
.16:
        mov dword [GraphicsModeSet], 1
        mov eax, esi
        mov edi, 8
        shl eax, 4
        mov dword [dword esp+0178h], edi
        mov eax, dword [dword eax+ModeTableNumber]
        mov edi, ebx
        cmp eax, 100h
        jl near .20
        mov edx, esp
        call VesaGetModeInfo
        xor eax, eax
        mov al, byte [byte esp+019h]
        mov edi, dword [byte esp+0Eh]
        mov dword [dword esp+0178h], eax
        xor eax, eax
        mov edx, 8
        mov dword [VesaBankFunc], eax
        mov eax, dword [byte esp+02h]
        sar edi, 10h
        sar eax, 10h
        mov dword [GraphicsModeSet], edx
        test eax, eax
        je short .18
.17:
        cmp eax, byte 40h
        jge short .18
        mov edx, dword [VesaBankFunc]
        inc edx
        add eax, eax
        mov dword [VesaBankFunc], edx
        jmp short .17
.18:
        xor eax, eax
        mov dword [VesaBank], eax
        test byte [byte esp+03h], 1
        je short .19
        mov dword [VesaBank], 1
.19:
        mov eax, 0FFFFFFFFh
        call VesaSetBank
.20:
        cmp dword [dword esp+0178h], byte 0
        jne short .21
        shl esi, 4
        mov eax, dword [dword esi+ModeTableBpp]
        mov dword [dword esp+0178h], eax
.21:
        mov esi, dword [dword esp+0178h]
        inc esi
        and si, byte 0FFFEh
        test edi, edi
        jne short .22
        mov edx, ebx
        imul edx, esi
        mov eax, edx
        sar edx, 1Fh
        shl edx, 3
        LD sbb, eax, edx
        sar eax, 3
        mov edi, eax
.22:
        mov eax, dword [dword esp+0178h]
        mov dword [ViewScreenWidth], ebx
        mov edx, ebx
        mov dword [MenuScreenBitmap], eax
        mov eax, dword [ScreenModeWidth]
        mov dword [ViewScreenHeight], ecx
        sub edx, eax
        mov eax, dword [ScreenModeHeight]
        mov dword [DefaultModeWidth], edx
        mov edx, ecx
        mov dword [BackBufferWidth], ebx
        sub edx, eax
        mov dword [ModeHeight], ecx
        mov dword [DefaultModeHeight], edx
        xor edx, edx
        mov dword [ModeWidth], ebx
        mov dword [ModeFrameBuffer], edx
        mov dword [ModeBankSize], edx
        mov edx, dword [dword esp+0178h]
        mov al, byte [dword esp+0178h]
        push edx
        mov dword [BackBufferHeight], ecx
        mov byte [ModeBitsPerPixel], al
        call BytesPerPixelForDepth
        add esp, byte 4
        mov edx, esi
        mov byte [str_Punct_SetGraphicsMode], al
        sar edx, 3
        xor eax, eax
        call FillRowTable
        mov dword [ModeLinear], eax
        test ebp, ebp
        je short .23
        mov eax, dword [dword esp+0158h]
        xor esi, esi
        mov dword [ModePitch], eax
        mov dword [VideoModeNumber], esi
        jmp short .24
.23:
        mov ebx, 0A0000h
        mov ecx, dword [GraphicsModeSet]
        mov dword [ModePitch], ebx
        cmp ecx, byte 1
        setne al
        and eax, 0FFh
        mov dword [VideoModeNumber], eax
.24:
        push edi
        push BackBufferWidth
        call CloseVideoWindow
        mov edi, dword [ModeSetCount]
        add esp, byte 8
        test edi, edi
        je short .25
        push edi
        call FreeBitmap
        xor eax, eax
        add esp, byte 4
        mov dword [ModeSetCount], eax
.25:
        call SetScreenTarget
        mov dword [CurrentDrawContext], ScreenWidth
.26:
        add esp, 15Ch
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 00h,00h,00h
;-----------------------------------------------------------------------------
; WritePaletteRegs                               103648  97 PC, low confidence
; Writes a range of palette entries to the VGA DAC for the video set-up code
;-----------------------------------------------------------------------------
WritePaletteRegs:
        push ebx
        push esi
        push edi
        push ebp
        inc dword [FrameCounter]
        cmp dword [MenuScreenBitmap], byte 8
        jg short .2
        mov ebp, dword [byte esp+01Ch]
        mov edx, 3C8h
        mov eax, dword [byte esp+014h]
        out dx, al
        lea edi, [nosplit eax*4+PaletteWords]
        mov ebx, dword [byte esp+018h]
        inc edx
        push edx
.1:
        mov eax, dword [byte ebp-01h]
        bswap eax
        or eax, 0FF000000h
        mov dword [edi], eax
        bswap eax
        shr eax, 2
        and eax, 3F3F3F00h
        mov dword [esp], eax
        lea esi, [byte esp+01h]
        mov ecx, 3
        rep outsb
        dec ebx
        lea ebp, [byte ebp+03h]
        lea edi, [byte edi+04h]
        jne short .1
        mov byte [PaletteDirty], 0
        pop edx
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.2:
        mov ebp, dword [byte esp+01Ch]
        mov eax, dword [byte esp+014h]
        lea edi, [nosplit eax*4+PaletteWords]
        mov ebx, dword [byte esp+018h]
.3:
        mov eax, dword [byte ebp-01h]
        bswap eax
        or eax, 0FF000000h
        mov dword [edi], eax
        dec ebx
        lea ebp, [byte ebp+03h]
        lea edi, [byte edi+04h]
        jne short .3
        mov byte [PaletteDirty], 0
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; AllocRowTable                                  1036F0  97 PC, low confidence
; Allocates the screen row address table
;-----------------------------------------------------------------------------
AllocRowTable:
        push ebx
        push ecx
        push edx
        cmp dword [RowTable], byte 0
        jne short .1
        mov ebx, dword [MessageBoxActive]
        mov eax, dword [RowTableBytes]
        push ebx
        shl eax, 2
        push eax
        push str_Rowtbl
        call AllocMemBlock
        add esp, byte 0Ch
        mov dword [RowTable], eax
.1:
        mov edx, dword [RowTableBytes]
        mov eax, dword [RowTable]
        shl edx, 2
        lea ebx, [eax+edx]
        mov edx, dword [RowTableBytes]
        mov dword [byte eax+04h], 0
        sub edx, byte 2
        mov dword [RowTableSize], ebx
        mov dword [eax], edx
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; FreeRowTable                                   10374C  97 PC, low confidence
; Frees the screen row address table
;-----------------------------------------------------------------------------
FreeRowTable:
        push ecx
        push edx
        mov edx, dword [RowTable]
        test edx, edx
        je short .1
        push edx
        call FreeMemBlock
        add esp, byte 4
.1:
        xor ecx, ecx
        mov dword [RowTable], ecx
        pop edx
        pop ecx
        ret
