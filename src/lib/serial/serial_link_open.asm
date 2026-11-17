; Serial port: SerialLinkOpen, SerialLinkClose, SerialLinkIsOpen, SerialLinkTxFree and 3 more.
bits 32
%include "hockey.inc"
section s_11C004 progbits alloc exec nowrite align=1
extern SerialConfigure, SerialFlushRx, SerialFlushTx, SerialIsOpen, SerialOpen, SerialProgramUart, SerialRead, SerialRxCount
extern SerialSetBaud, SerialTxFree, SerialWriteIfRoom
global SerialLinkOpen, SerialLinkClose, SerialLinkIsOpen, SerialLinkTxFree, SerialLinkRxCount, SerialLinkRead, SerialLinkWrite
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; SerialLinkOpen                                 11C010  97 PC, low confidence
; Opens the serial link (null modem)
;-----------------------------------------------------------------------------
SerialLinkOpen:
        push ebx
        push esi
        push edi
        push ebp
        mov esi, dword [byte esp+014h]
        mov edx, dword [byte esi+030h]
        mov ebx, esi
        test edx, edx
        je short .1
        push edx
        mov eax, dword [byte esi+02Ch]
        push eax
        jmp short .2
.1:
        mov ecx, dword [byte esi+02Ch]
        push ecx
        call SerialProgramUart
        add esp, byte 4
        push eax
        mov edi, dword [byte esi+02Ch]
        push edi
.2:
        call SerialSetBaud
        add esp, byte 8
        mov edx, dword [byte ebx+02Ch]
        push edx
        call SerialOpen
        add esp, byte 4
        mov ecx, dword [byte ebx+02Ch]
        push ecx
        call SerialIsOpen
        add esp, byte 4
        test eax, eax
        je short .3
        mov esi, dword [byte ebx+040h]
        push esi
        mov edi, dword [byte ebx+03Ch]
        push edi
        mov ebp, dword [byte ebx+038h]
        push ebp
        mov eax, dword [byte ebx+034h]
        push eax
        mov edx, dword [byte ebx+02Ch]
        push edx
        call SerialConfigure
        add esp, byte 14h
        mov ecx, dword [byte ebx+02Ch]
        push ecx
        call SerialFlushRx
        add esp, byte 4
        mov esi, dword [byte ebx+02Ch]
        push esi
        call SerialFlushTx
        add esp, byte 4
        mov dword [byte ebx+028h], 1
        jmp short .4
.3:
        mov dword [byte ebx+028h], eax
.4:
        mov eax, dword [byte ebx+028h]
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; SerialLinkClose                                11C0A8  97 PC, low confidence
; Marks the serial link closed
;-----------------------------------------------------------------------------
SerialLinkClose:
        mov eax, dword [byte esp+04h]
        mov dword [byte eax+028h], 0
        mov eax, 1
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; SerialLinkIsOpen                               11C0BC  97 PC, low confidence
; Returns whether the serial link is open
;-----------------------------------------------------------------------------
SerialLinkIsOpen:
        mov eax, dword [byte esp+04h]
        mov eax, dword [byte eax+028h]
        ret
;-----------------------------------------------------------------------------
; SerialLinkTxFree                               11C0C4  97 PC, low confidence
; Returns the free space of the serial send buffer
;-----------------------------------------------------------------------------
SerialLinkTxFree:
        mov eax, dword [byte esp+04h]
        mov edx, dword [byte eax+02Ch]
        push edx
        call SerialTxFree
        add esp, byte 4
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; SerialLinkRxCount                              11C0D8  97 PC, low confidence
; Returns the bytes waiting in the serial receive buffer
;-----------------------------------------------------------------------------
SerialLinkRxCount:
        mov eax, dword [byte esp+04h]
        mov edx, dword [byte eax+02Ch]
        push edx
        call SerialRxCount
        add esp, byte 4
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; SerialLinkRead                                 11C0EC  97 PC, low confidence
; Reads from the serial link
;-----------------------------------------------------------------------------
SerialLinkRead:
        push ebx
        mov edx, dword [byte esp+0Ch]
        push edx
        mov ebx, dword [byte esp+014h]
        mov eax, dword [byte esp+0Ch]
        push ebx
        mov ecx, dword [byte eax+02Ch]
        push ecx
        call SerialRead
        add esp, byte 0Ch
        mov edx, eax
        test eax, eax
        jge short .1
        neg edx
.1:
        mov eax, edx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; SerialLinkWrite                                11C114  97 PC, low confidence
; Writes to the serial link when there is room
;-----------------------------------------------------------------------------
SerialLinkWrite:
        push ebx
        mov edx, dword [byte esp+0Ch]
        push edx
        mov ebx, dword [byte esp+014h]
        mov eax, dword [byte esp+0Ch]
        push ebx
        mov ecx, dword [byte eax+02Ch]
        push ecx
        call SerialWriteIfRoom
        add esp, byte 0Ch
        pop ebx
        ret
