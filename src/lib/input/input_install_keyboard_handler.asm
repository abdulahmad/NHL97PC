; Input: InstallKeyboardHandler, RemoveKeyboardHandler, KeyboardISR, Int16Handler, Int16Service and 6 more.
bits 32
%include "hockey.inc"
section s_116425 progbits alloc exec nowrite align=1
extern AddExitHandler, AssertFileName, AssertLine, AssertMessage, AssertPreserveRegs, bcopy, BiosKeyFunc, ClipLeftCol
extern ClipRight, ClipTopRow, DosGetVector, DosSetVector, DrawDestBuffer, DrawDestOffset, DrawDestPitch, ExitGraphics
extern ExitHandler, KbdCapsLock, KbdDataSelector, KbdHandlerInstalled, KbdInsertMode, KbdPauseState, KbdPrefixByte, KeyBuffer
extern KeyBufferHead, KeyBufferMask, KeyBufferTail, KeyDownTable, KeyStateTable, PrintScreen, RestoreDS, SavedInt16Offset
extern SavedInt16Selector, SavedKbdVecOffset, SavedKbdVecSelector, SavedRealKbdOffset, SavedRealKbdSegment, KeyMapNormal, KeyMapCaps, KeyMapAlt
extern KeyMapCtrl, KeyMapShift, ScreenBitsPerPixel, ScreenBuffer, ScreenHeight, StoreLittleEndian, str_FILESLINED, VesaSetBank
global __saved_DS, RestoreDSEnd, InstallKeyboardHandler, RemoveKeyboardHandler, KeyboardISR, IretStub, Int16Handler, Int16Service
global IsKeyDown, BiosKeyCall, AssertFail, AssertFailEntry, PlotPixel, PlotPixelAt
__saved_DS:                                     ; used by RestoreDS, start
        db 00h,00h
RestoreDSEnd:                                   ; used by __CommonInit_
        db 00h
;-----------------------------------------------------------------------------
; InstallKeyboardHandler                         116428  97 PC, low confidence
; Keyboard: hooks the keyboard interrupt and clears the key table
;-----------------------------------------------------------------------------
InstallKeyboardHandler:
        push ebx
        cmp word [KbdDataSelector], byte 0
        jne near .1
        o16 mov word [KbdDataSelector], ds
        cld
        lea edi, [KeyStateTable]
        mov ecx, 20h
        mov eax, 0
        rep stosd
        in al, 21h
        push eax
        or al, 3
        out 21h, al
        mov ebx, 9
        call DosGetVector
        mov dword [SavedKbdVecOffset], eax
        mov word [SavedKbdVecSelector], dx
        mov ebx, 16h
        call DosGetVector
        mov dword [SavedInt16Offset], eax
        mov word [SavedInt16Selector], dx
        mov ebx, 23h
        call DosGetVector
        mov dword [SavedRealKbdOffset], eax
        mov word [SavedRealKbdSegment], dx
        mov dx, cs
        mov ebx, 9
        db 0B8h                                 ; insn: mov eax,KeyboardISR
        dd KeyboardISR
        call DosSetVector
        mov dx, cs
        mov ebx, 16h
        db 0B8h                                 ; insn: mov eax,Int16Handler
        dd Int16Handler
        mov dx, cs
        mov ebx, 23h
        db 0B8h                                 ; insn: mov eax,IretStub
        dd IretStub
        call DosSetVector
        pop eax
        out 21h, al
        db 0BBh                                 ; insn: mov ebx,Int16Service
        dd Int16Service
        mov dword [BiosKeyFunc], ebx
        db 068h                                 ; insn: push RemoveKeyboardHandler
        dd RemoveKeyboardHandler
        call AddExitHandler
        add esp, byte 4
.1:
        pop ebx
        ret
;-----------------------------------------------------------------------------
; RemoveKeyboardHandler                          1164E8  97 PC, low confidence
; Keyboard: restores the original keyboard interrupt
;-----------------------------------------------------------------------------
RemoveKeyboardHandler:
        push ebx
        cmp word [KbdDataSelector], byte 0
        je short .1
        mov word [KbdDataSelector], 0
        pusha
        in al, 21h
        push eax
        or al, 3
        out 21h, al
        mov ebx, 9
        mov eax, dword [SavedKbdVecOffset]
        mov dx, word [SavedKbdVecSelector]
        call DosSetVector
        mov ebx, 16h
        mov eax, dword [SavedInt16Offset]
        mov dx, word [SavedInt16Selector]
        mov ebx, 23h
        mov eax, dword [SavedRealKbdOffset]
        mov dx, word [SavedRealKbdSegment]
        call DosSetVector
        and byte [0417h], 0F0h
        pop eax
        out 21h, al
        db 0BBh                                 ; insn: mov ebx,BiosKeyCall
        dd BiosKeyCall
        mov dword [BiosKeyFunc], ebx
        popa
.1:
        pop ebx
        ret
;-----------------------------------------------------------------------------
; KeyboardISR                                    116559  97 PC, low confidence
; Keyboard: interrupt handler, reads the scan code and updates the key table
; and buffer
;-----------------------------------------------------------------------------
KeyboardISR:
        push eax
        push ebx
        push ds
        in al, 61h
        LD mov, ah, al
        or al, 80h
        out 61h, al
        LD mov, al, ah
        out 61h, al
        LD xor, eax, eax
        in al, 60h
        LD mov, ebx, eax
        db 066h,02Eh,08Eh,01Dh                  ; insn: o16 mov ds,[cs:KbdDataSelector]
        dd KbdDataSelector
        mov byte [KbdPauseState], 0
        cmp byte [KbdPrefixByte], 0E0h
        jne short .1
        mov byte [KbdPauseState], 1
.1:
        mov byte [KbdPrefixByte], al
        LD or, bl, bl
        jns short .4
        cmp byte [KbdPauseState], 0
        je short .2
        cmp ebx, 0AAh
        je short .3
        cmp ebx, 0B6h
        je short .3
.2:
        mov byte [dword ebx+KeyDownTable], 0
.3:
        mov al, 20h
        out 20h, al
        pop ds
        pop ebx
        pop eax
        iret
.4:
        cmp byte [KbdPauseState], 0
        je short .6
        cmp ebx, byte 2Ah
        je short .5
        cmp ebx, byte 36h
        jne short .6
.5:
        mov al, 20h
        out 20h, al
        jmp short .9
.6:
        mov byte [dword ebx+KeyStateTable], 1
        mov al, 20h
        out 20h, al
        cmp ebx, byte 3Ah
        je short .10
        cmp ebx, byte 45h
        je short .11
        test byte [KeyStateTable+38h], 1
        jne near .15
        test byte [KeyStateTable+1Dh], 1
        jne near .14
        test byte [KeyStateTable+2Ah], 1
        jne short .13
        test byte [KeyStateTable+36h], 1
        jne short .13
        test byte [KbdCapsLock], 1
        jne near .17
        mov al, byte [dword ebx+KeyMapNormal]
.7:
        cmp al, 80h
        jae short .12
.8:
        LD or, eax, eax
        je short .9
        mov ebx, dword [KeyBufferHead]
        mov dword [nosplit ebx*4+KeyBuffer], eax
        add ebx, byte 1
        and ebx, dword [KeyBufferMask]
        mov dword [KeyBufferHead], ebx
.9:
        pop ds
        pop ebx
        pop eax
        iret
.10:
        xor dword [KbdCapsLock], byte 1
        mov al, 0EDh
        out 60h, al
        mov al, byte [KbdCapsLock]
        shl al, 2
        out 60h, al
        jmp short .9
.11:
        xor byte [KbdInsertMode], 1
        jmp short .9
.12:
        LD mov, ah, al
        LD xor, al, al
        cmp ah, 90h
        jb short .8
        and ah, 7Fh
        jmp short .8
.13:
        mov al, byte [dword ebx+KeyMapShift]
        cmp ebx, byte 37h
        jne short .7
        cmp dword [KbdHandlerInstalled], byte 0
        je short .7
        mov byte [dword ebx+KeyStateTable], 0
        call PrintScreen
        jmp short .7
.14:
        mov al, byte [dword ebx+KeyMapCtrl]
        cmp ebx, byte 1
        jne near .7
        jmp short .19
.15:
        test byte [KeyStateTable+1Dh], 1
        jne short .18
.16:
        mov al, byte [dword ebx+KeyMapAlt]
        jmp near .7
.17:
        mov al, byte [dword ebx+KeyMapCaps]
        jmp near .7
.18:
        test byte [KeyStateTable+53h], 1
        je short .16
.19:
        cmp dword [KbdHandlerInstalled], byte 0
        je near .7
        call dword [ExitHandler]
IretStub:                                       ; used by InstallKeyboardHandler
        db 0CFh
;-----------------------------------------------------------------------------
; Int16Handler                                   1166F0  97 PC, low confidence
; Keyboard: BIOS keyboard service replacement that reads from the game's key
; buffer
;-----------------------------------------------------------------------------
Int16Handler:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        push ds
        push es
        push fs
        push gs
        LD mov, ebp, esp
        sub esp, byte 8
        cld
        call RestoreDS
        sti
        call Int16Service
        pushf
        pop ebx
        and ebx, 4000h
        jne short .1
        LD mov, esp, ebp
        pop gs
        pop fs
        pop es
        pop ds
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        LD or, eax, eax
        retfw 4
.1:
        LD mov, esp, ebp
        pop gs
        pop fs
        pop es
        pop ds
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        iret
;-----------------------------------------------------------------------------
; Int16Service                                   11673A  97 PC, low confidence
; Keyboard: handles the BIOS keyboard read and status calls
;-----------------------------------------------------------------------------
Int16Service:
        cmp ah, 0
        je short .3
        cmp ah, 10h
        je short .3
        cmp ah, 1
        je short .2
        cmp ah, 11h
        je short .2
        cmp ah, 2
        je short .4
        cmp ah, 12h
        je short .4
.1:
        LD xor, eax, eax
        LD or, eax, eax
        ret
.2:
        mov edx, dword [KeyBufferTail]
        cmp edx, dword [KeyBufferHead]
        je short .1
        mov eax, dword [nosplit edx*4+KeyBuffer]
        LD or, eax, eax
        ret
.3:
        mov edx, dword [KeyBufferTail]
        cmp edx, dword [KeyBufferHead]
        je short .3
        mov eax, dword [nosplit edx*4+KeyBuffer]
        add edx, byte 1
        and edx, dword [KeyBufferMask]
        mov dword [KeyBufferTail], edx
        LD or, eax, eax
        ret
.4:
        LD xor, eax, eax
        mov al, byte [KeyStateTable+2Ah]
        or al, byte [KeyStateTable+36h]
        and al, 1
        LD or, eax, eax
        ret
;-----------------------------------------------------------------------------
; IsKeyDown                                      1167AE  97 PC, low confidence
; Keyboard: returns whether the key of a scan code is held
;-----------------------------------------------------------------------------
IsKeyDown:
        push ebp
        LD mov, ebp, esp
        mov edx, dword [byte ebp+08h]
        movzx eax, byte [dword edx+KeyStateTable]
        leave
        ret
;-----------------------------------------------------------------------------
; BiosKeyCall                                    1167BD  97 PC, low confidence
; Keyboard: calls the BIOS keyboard service
;-----------------------------------------------------------------------------
BiosKeyCall:
        push ebx
        push esi
        push edi
        movzx eax, ax
        int 16h
        movzx eax, ax
        pop edi
        pop esi
        pop ebx
        ret
;-----------------------------------------------------------------------------
; AssertFail                                     1167CC  97 PC, low confidence
; Stops the program with the "FILE %s LINE %d." message after restoring the
; screen
;-----------------------------------------------------------------------------
AssertFail:
        call RestoreDS
        pop eax
        mov eax, dword [AssertLine]
        cmp eax, byte 0
        je short .1
        mov dword [esp], eax
.1:
        call ExitGraphics
        call AssertPreserveRegs
        cmp dword [AssertFileName], byte 0
        je short .2
        push dword [AssertMessage]
        push dword [AssertFileName]
        push str_FILESLINED
        call AssertPreserveRegs
        add esp, byte 0Ch
.2:
        call dword [ExitHandler]
        ret
        push ebp
        LD mov, ebp, esp
        mov eax, dword [byte ebp+08h]
        mov dword [AssertLine], eax
        leave
        ret
        db 00h
;-----------------------------------------------------------------------------
; AssertFailEntry                                116820  97 PC, low confidence
; Jumps to AssertFail
;-----------------------------------------------------------------------------
AssertFailEntry:
        jmp near AssertFail
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; PlotPixel                                      116830  97 PC, low confidence
; Graphics library: plots a pixel, clipped to the window
;-----------------------------------------------------------------------------
PlotPixel:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov eax, dword [byte esp+01Ch]
        mov ebx, dword [byte esp+018h]
        cmp ebx, dword [ClipTopRow]
        jl near .11
        cmp ebx, dword [ClipRight]
        jge near .11
        cmp eax, dword [ClipLeftCol]
        jl near .11
        cmp eax, dword [ScreenHeight]
        jge near .11
        mov ebx, dword [DrawDestBuffer]
        shl eax, 2
        lea esi, [ebx+eax]
        mov eax, dword [byte esp+018h]
        mov ebx, dword [DrawDestOffset]
        mov esi, dword [esi]
        mov ecx, dword [ebx+eax*4]
        mov eax, dword [ScreenBuffer]
        add esi, ecx
        test eax, eax
        je short .1
        mov ebp, esi
        sar ebp, 10h
        mov edi, 10000h
        mov eax, ebp
        and esi, 0FFFFh
        call VesaSetBank
        sub edi, esi
        xor eax, eax
        lea ebx, [nosplit edi*8+00h]
        mov al, byte [ScreenBitsPerPixel]
        cmp ebx, eax
        jge short .1
        push edi
        lea eax, [byte esp+04h]
        mov ebx, dword [DrawDestPitch]
        push eax
        add ebx, esi
        push ebx
        call bcopy
        add esp, byte 0Ch
        lea eax, [byte ebp+01h]
        call VesaSetBank
        mov eax, 4
        sub eax, edi
        push eax
        lea eax, [byte esp+04h]
        add eax, edi
        push eax
        mov ebx, dword [DrawDestPitch]
        push ebx
        call bcopy
        lea ebx, [byte esp+0Ch]
        add esp, byte 0Ch
        jmp short .2
.1:
        mov ebx, dword [DrawDestPitch]
        add ebx, esi
.2:
        mov al, byte [ScreenBitsPerPixel]
        cmp al, 0Fh
        jb short .3
        cmp al, 10h
        jbe short .7
        cmp al, 18h
        jb near .10
        jbe short .8
        cmp al, 20h
        je short .9
        jmp short .10
.3:
        cmp al, 4
        jb short .10
        jbe short .4
        cmp al, 8
        je short .6
        jmp short .10
.4:
        test byte [byte esp+018h], 1
        je short .5
        mov al, byte [ebx]
        and al, 0F0h
        mov ah, byte [byte esp+020h]
        or ah, al
        mov byte [ebx], ah
        jmp short .10
.5:
        mov al, byte [ebx]
        and al, 0Fh
        mov ah, byte [byte esp+020h]
        shl ah, 4
        or al, ah
        mov byte [ebx], al
        jmp short .10
.6:
        mov al, byte [byte esp+020h]
        mov byte [ebx], al
        jmp short .10
.7:
        mov eax, dword [byte esp+020h]
        mov word [ebx], ax
        jmp short .10
.8:
        push byte 3
        mov edx, dword [byte esp+024h]
        push edx
        push ebx
        call StoreLittleEndian
        add esp, byte 0Ch
        jmp short .10
.9:
        mov eax, dword [byte esp+020h]
        mov dword [ebx], eax
.10:
        mov eax, esp
        cmp ebx, eax
        jne short .11
        mov eax, ebp
        call VesaSetBank
        mov eax, dword [DrawDestPitch]
        push edi
        add eax, esi
        push eax
        lea eax, [byte esp+08h]
        push eax
        mov ebx, 4
        call bcopy
        add esp, byte 0Ch
        lea eax, [byte ebp+01h]
        sub ebx, edi
        call VesaSetBank
        push ebx
        mov eax, dword [DrawDestPitch]
        push eax
        lea eax, [byte esp+08h]
        add eax, edi
        push eax
        call bcopy
        add esp, byte 0Ch
.11:
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; PlotPixelAt                                    1169D4  97 PC, low confidence
; Graphics library: (x, y, colour) entry of PlotPixel
;-----------------------------------------------------------------------------
PlotPixelAt:
        push ebx
        mov edx, dword [byte esp+010h]
        push edx
        mov ebx, dword [byte esp+010h]
        push ebx
        mov ecx, dword [byte esp+010h]
        push ecx
        call PlotPixel
        add esp, byte 0Ch
        pop ebx
        ret
