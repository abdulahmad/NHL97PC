; Serial port: SerialConfigure, SerialOpen, SerialClose, SerialCloseAll, SerialIsOpen and 13 more.
bits 32
%include "hockey.inc"
section s_118D54 progbits alloc exec nowrite align=1
extern AddExitHandler, DosGetVector, DosSetVector, GetTicks, SerialBaudDivisors, SerialIrqMask, SerialIsrPort1, SerialIsrPort2
extern SerialPorts, SerialPortTable, TicksSince
global SerialConfigure, SerialOpen, SerialClose, SerialCloseAll, SerialIsOpen, SerialSetBaud, SerialProgramUart, SerialRaiseDtr
global SerialCarrier, SerialWriteIfRoom, SerialWriteIfRoom_20, SerialWrite, SerialWrite_6, SerialRxCount, SerialTxFree, SerialFlushTx
global SerialWaitTxEmpty, SerialRead, SerialRead_46, SerialFlushRx, SerialISR, SerialISR_9, SerialISR_12, SerialISR_1B
global SerialISR_85, SerialIsrJumpTable, SerialISR_B1
;-----------------------------------------------------------------------------
; SerialConfigure                                118D54  97 PC, low confidence
; Serial port: sets the port's address, interrupt and buffers
;-----------------------------------------------------------------------------
SerialConfigure:
        push ebp
        LD mov, ebp, esp
        push ebx
        mov ebx, dword [byte ebp+08h]
        mov ebx, dword [nosplit ebx*4+SerialPortTable]
        mov eax, dword [byte ebp+0Ch]
        mov byte [ebx], al
        mov eax, dword [byte ebp+010h]
        mov byte [byte ebx+01h], al
        mov eax, dword [byte ebp+014h]
        mov byte [byte ebx+02h], al
        mov eax, dword [byte ebp+018h]
        mov byte [byte ebx+03h], al
        mov dx, word [byte ebx+08h]
        and dx, byte 0FFF8h
        or dx, byte 1
        LD xor, ax, ax
        out dx, al
        and dx, byte 0FFF8h
        or dx, byte 4
        mov al, 9
        out dx, al
        and dx, byte 0FFF8h
        or dx, byte 3
        mov eax, dword [byte ebp+018h]
        mov ecx, dword [byte ebp+014h]
        LD add, cl, cl
        LD add, cl, cl
        LD or, al, cl
        mov ecx, dword [byte ebp+010h]
        LD add, cl, cl
        LD add, cl, cl
        LD add, cl, cl
        LD or, al, cl
        or al, 80h
        out dx, al
        and dx, byte 0FFF8h
        or dx, byte 0
        mov ebx, dword [byte ebp+0Ch]
        LD add, ebx, ebx
        mov ax, word [dword ebx+SerialBaudDivisors]
        out dx, ax
        and dx, byte 0FFF8h
        or dx, byte 3
        in al, dx
        and al, 1Fh
        out dx, al
        and dx, byte 0FFF8h
        or dx, byte 5
        in al, dx
        and dx, byte 0FFF8h
        in al, dx
        or dx, byte 2
        in al, dx
        and dx, byte 0FFF8h
        or dx, byte 6
        in al, dx
        mov al, 3
        and dx, byte 0FFF8h
        or dx, byte 1
        out dx, al
        pop ebx
        leave
        ret
        push ebp
        LD mov, ebp, esp
        push ebx
        mov eax, dword [byte ebp+08h]
        mov ebx, dword [nosplit eax*4+SerialPortTable]
        mov dx, word [byte ebx+08h]
        or dx, byte 2
        mov al, 87h
        out dx, al
        LD xor, eax, eax
        mov dx, word [byte ebx+08h]
        or dx, byte 2
        in al, dx
        and al, 80h
        pop ebx
        leave
        ret
        push ebp
        LD mov, ebp, esp
        push ebx
        mov eax, dword [byte ebp+08h]
        mov ebx, dword [nosplit eax*4+SerialPortTable]
        mov eax, dword [byte ebx+044h]
        pop ebx
        leave
        ret
;-----------------------------------------------------------------------------
; SerialOpen                                     118E3F  97 PC, low confidence
; Serial port: installs the port's interrupt handler and enables it
;-----------------------------------------------------------------------------
SerialOpen:
        push ebp
        LD mov, ebp, esp
        add esp, byte 0FFFFFFFCh
        push ebx
        push esi
        mov ax, ds
        mov word [SerialIrqMask], ax
        mov eax, dword [byte ebp+08h]
        mov ebx, dword [nosplit eax*4+SerialPortTable]
        mov dword [byte ebp-04h], ebx
        LD xor, eax, eax
        mov al, byte [byte ebx+03h]
        push eax
        mov al, byte [byte ebx+02h]
        push eax
        mov al, byte [byte ebx+01h]
        push eax
        mov al, byte [ebx]
        push eax
        push dword [byte ebp+08h]
        call SerialConfigure
        add esp, byte 14h
        mov ebx, dword [byte ebp-04h]
        lea eax, [byte ebx+04Ch]
        mov dword [byte ebx+018h], eax
        mov dword [byte ebx+020h], eax
        mov dword [byte ebx+024h], eax
        add eax, 200h
        mov dword [byte ebx+01Ch], eax
        mov dword [byte ebx+02Ch], eax
        mov dword [byte ebx+034h], eax
        mov dword [byte ebx+038h], eax
        add eax, 200h
        mov dword [byte ebx+030h], eax
        LD xor, eax, eax
        mov dword [byte ebx+028h], eax
        mov dword [byte ebx+03Ch], eax
        mov eax, dword [byte ebx+010h]
        LD or, eax, eax
        jne short .1
        LD xor, eax, eax
        mov ax, word [byte ebx+04h]
        LD mov, ebx, eax
        call DosGetVector
        mov ebx, dword [byte ebp-04h]
        mov dword [byte ebx+0Ah], eax
        mov word [byte ebx+0Eh], dx
        mov dx, cs
        mov eax, dword [byte ebx+014h]
        LD xor, ecx, ecx
        mov cx, word [byte ebx+04h]
        LD mov, ebx, ecx
        call DosSetVector
        mov ebx, dword [byte ebp-04h]
        mov dword [byte ebx+010h], 1
        mov dx, word [byte ebx+08h]
        or dx, byte 2
        mov al, 87h
        out dx, al
        mov ax, word [byte ebx+04h]
        shr al, 2
        and al, 7
        or al, 0C0h
        out 20h, al
        pushf
        cli
        in al, 21h
        mov dx, word [byte ebx+06h]
        not dl
        LD and, al, dl
        out 21h, al
        popf
        db 068h                                 ; insn: push SerialCloseAll
        dd SerialCloseAll
        call AddExitHandler
        add esp, byte 4
.1:
        pop esi
        pop ebx
        leave
        ret
;-----------------------------------------------------------------------------
; SerialClose                                    118F1C  97 PC, low confidence
; Serial port: disables the port and restores its interrupt
;-----------------------------------------------------------------------------
SerialClose:
        push ebp
        LD mov, ebp, esp
        push ebx
        mov eax, dword [byte ebp+08h]
        mov ebx, dword [nosplit eax*4+SerialPortTable]
        mov eax, dword [byte ebx+010h]
        LD or, eax, eax
        je short .1
        mov dword [byte ebx+010h], 0
        in al, 21h
        or ax, word [byte ebx+06h]
        out 21h, al
        mov dx, word [byte ebx+0Eh]
        mov eax, dword [byte ebx+0Ah]
        LD xor, ecx, ecx
        mov cx, word [byte ebx+04h]
        LD mov, ebx, ecx
        call DosSetVector
        mov eax, dword [byte ebp+08h]
        mov ebx, dword [nosplit eax*4+SerialPortTable]
        push dword [byte ebx+018h]
        add esp, byte 4
.1:
        pop ebx
        leave
        ret
;-----------------------------------------------------------------------------
; SerialCloseAll                                 118F67  97 PC, low confidence
; Serial port: closes both ports
;-----------------------------------------------------------------------------
SerialCloseAll:
        pusha
        push byte 0
        call SerialClose
        push byte 1
        call SerialClose
        add esp, byte 8
        popa
        ret
;-----------------------------------------------------------------------------
; SerialIsOpen                                   118F7B  97 PC, low confidence
; Serial port: returns whether the port is open
;-----------------------------------------------------------------------------
SerialIsOpen:
        push ebp
        LD mov, ebp, esp
        push ebx
        push esi
        mov eax, dword [byte ebp+08h]
        mov ebx, dword [nosplit eax*4+SerialPortTable]
        mov eax, dword [byte ebx+010h]
        pop esi
        pop ebx
        leave
        ret
;-----------------------------------------------------------------------------
; SerialSetBaud                                  118F91  97 PC, low confidence
; Serial port: sets the baud rate
;-----------------------------------------------------------------------------
SerialSetBaud:
        push ebp
        LD mov, ebp, esp
        push ebx
        mov eax, dword [byte ebp+08h]
        mov ebx, dword [nosplit eax*4+SerialPortTable]
        mov eax, dword [byte ebp+0Ch]
        mov word [byte ebx+06h], ax
        mov edx, 7
.1:
        inc edx
        shr eax, 1
        jne short .1
        mov word [byte ebx+04h], dx
        pop ebx
        leave
        ret
;-----------------------------------------------------------------------------
; SerialProgramUart                              118FB7  97 PC, low confidence
; Serial port: programs the UART's divisor and line settings
;-----------------------------------------------------------------------------
SerialProgramUart:
        push ebp
        LD mov, ebp, esp
        add esp, byte 0FFFFFFF8h
        push ebx
        mov eax, dword [byte ebp+08h]
        mov ebx, dword [nosplit eax*4+SerialPortTable]
        pushf
        cli
        mov dx, word [byte ebx+08h]
        or dx, byte 3
        in al, dx
        and al, 7Fh
        out dx, al
        mov dx, word [byte ebx+08h]
        or dx, byte 1
        LD xor, eax, eax
        out dx, al
        mov dx, word [byte ebx+08h]
        or dx, byte 4
        and al, 0EFh
        or al, 8
        out dx, al
        in al, 21h
        mov byte [byte ebp-05h], al
        mov al, 0Ah
        out 20h, al
        mov dx, word [byte ebx+08h]
        or dx, byte 1
        mov al, 2
        out dx, al
        in al, 20h
        and al, 0FCh
        LD mov, ah, al
        LD xor, al, al
        out dx, al
        in al, 20h
        not al
        LD and, ah, al
        mov al, 2
        out dx, al
        in al, 20h
        LD and, al, ah
        cbw
        mov dword [byte ebp-04h], eax
        mov dx, word [byte ebx+08h]
        or dx, byte 5
        in al, dx
        mov dx, word [byte ebx+08h]
        or dx, byte 0
        in al, dx
        mov dx, word [byte ebx+08h]
        or dx, byte 2
        in al, dx
        mov dx, word [byte ebx+08h]
        or dx, byte 6
        in al, dx
        mov dx, word [byte ebx+08h]
        or dx, byte 1
        in al, dx
        LD xor, eax, eax
        out dx, al
        popf
        mov eax, dword [byte ebp-04h]
        pop ebx
        leave
        ret
;-----------------------------------------------------------------------------
; SerialRaiseDtr                                 119054  97 PC, low confidence
; Serial port: raises DTR
;-----------------------------------------------------------------------------
SerialRaiseDtr:
        push ebp
        LD mov, ebp, esp
        push ebx
        mov eax, dword [byte ebp+08h]
        mov ebx, dword [nosplit eax*4+SerialPortTable]
        mov dx, word [byte ebx+08h]
        or dx, byte 4
        in al, dx
        or al, 1
        out dx, al
        pop ebx
        leave
        ret
        push ebp
        LD mov, ebp, esp
        push ebx
        mov eax, dword [byte ebp+08h]
        mov ebx, dword [nosplit eax*4+SerialPortTable]
        mov dx, word [byte ebx+08h]
        or dx, byte 4
        in al, dx
        and al, 0FEh
        out dx, al
        pop ebx
        leave
        ret
;-----------------------------------------------------------------------------
; SerialCarrier                                  11908E  97 PC, low confidence
; Serial port: returns the carrier detect bit
;-----------------------------------------------------------------------------
SerialCarrier:
        push ebp
        LD mov, ebp, esp
        push ebx
        mov eax, dword [byte ebp+08h]
        mov ebx, dword [nosplit eax*4+SerialPortTable]
        mov dx, word [byte ebx+08h]
        or dx, byte 6
        LD xor, eax, eax
        pushf
        cli
        in al, dx
        popf
        and al, 80h
        pop ebx
        leave
        ret
        push ebp
        LD mov, ebp, esp
        push ebx
        push esi
        push edi
        call GetTicks
        LD mov, esi, eax
.1:
        mov eax, dword [byte ebp+08h]
        mov ebx, dword [nosplit eax*4+SerialPortTable]
        mov eax, 200h
        sub eax, dword [byte ebx+028h]
        cmp eax, dword [byte ebp+0Ch]
        jge short SerialWrite_6
        push esi
        call TicksSince
        add esp, byte 4
        cmp eax, dword [byte ebp+014h]
        jl short .1
        LD xor, eax, eax
        pop edi
        pop esi
        pop ebx
        leave
        ret
;-----------------------------------------------------------------------------
; SerialWriteIfRoom                              1190E8  97 PC, low confidence
; Serial port: writes the bytes when the send buffer has room
;-----------------------------------------------------------------------------
SerialWriteIfRoom:
        push ebp
        LD mov, ebp, esp
        push ebx
        push esi
        push edi
        mov eax, dword [byte ebp+08h]
        mov ebx, dword [nosplit eax*4+SerialPortTable]
        mov eax, 200h
        sub eax, dword [byte ebx+028h]
        cmp eax, dword [byte ebp+0Ch]
        jge short SerialWrite_6
        LD xor, ax, ax
SerialWriteIfRoom_20:
        pop edi
        pop esi
        pop ebx
        leave
        ret
;-----------------------------------------------------------------------------
; SerialWrite                                    11910D  97 PC, low confidence
; Serial port: puts bytes in the send buffer and starts sending
;-----------------------------------------------------------------------------
SerialWrite:
        push ebp
        LD mov, ebp, esp
        push ebx
        push esi
        push edi
SerialWrite_6:
        mov eax, dword [byte ebp+08h]
        mov ebx, dword [nosplit eax*4+SerialPortTable]
        pushf
        mov ecx, dword [byte ebp+0Ch]
        LD or, ecx, ecx
        jle short SerialWriteIfRoom_20
        mov esi, dword [byte ebp+010h]
        mov edi, dword [byte ebx+024h]
        mov edx, dword [byte ebx+01Ch]
.1:
        mov al, byte [esi]
        mov byte [edi], al
        inc esi
        inc edi
        LD cmp, edi, edx
        jb short .2
        mov edi, dword [byte ebx+018h]
.2:
        loop .1
        mov dword [byte ebx+024h], edi
        cli
        mov eax, dword [byte ebp+0Ch]
        mov edx, dword [byte ebx+028h]
        LD or, edx, edx
        jl short .3
        LD add, eax, edx
.3:
        mov dword [byte ebx+028h], eax
        mov dx, word [byte ebx+08h]
        or dx, byte 4
        in al, dx
        or al, 2
        jmp short .4
.4:
        out dx, al
        and dx, byte 0FFF8h
        or dx, byte 5
        jmp short .5
.5:
        in al, dx
        test al, 20h
        je short .7
        dec dword [byte ebx+028h]
        mov esi, dword [byte ebx+020h]
        mov al, byte [esi]
        inc esi
        cmp esi, dword [byte ebx+01Ch]
        jb short .6
        mov esi, dword [byte ebx+018h]
.6:
        mov word [byte ebx+020h], si
        and dx, byte 0FFF8h
        out dx, al
.7:
        popf
        mov eax, dword [byte ebp+0Ch]
        pop edi
        pop esi
        pop ebx
        leave
        ret
        push ebp
        LD mov, ebp, esp
        push ebx
        mov eax, dword [byte ebp+08h]
        mov ebx, dword [nosplit eax*4+SerialPortTable]
        mov eax, dword [byte ebx+028h]
        pop ebx
        leave
        ret
;-----------------------------------------------------------------------------
; SerialRxCount                                  1191A4  97 PC, low confidence
; Serial port: number of bytes received and not read
;-----------------------------------------------------------------------------
SerialRxCount:
        push ebp
        LD mov, ebp, esp
        push ebx
        mov eax, dword [byte ebp+08h]
        mov ebx, dword [nosplit eax*4+SerialPortTable]
        mov eax, dword [byte ebx+03Ch]
        pop ebx
        leave
        ret
;-----------------------------------------------------------------------------
; SerialTxFree                                   1191B8  97 PC, low confidence
; Serial port: free room in the send buffer
;-----------------------------------------------------------------------------
SerialTxFree:
        push ebp
        LD mov, ebp, esp
        push ebx
        mov eax, dword [byte ebp+08h]
        mov ebx, dword [nosplit eax*4+SerialPortTable]
        mov eax, 200h
        sub eax, dword [byte ebx+028h]
        pop ebx
        leave
        ret
;-----------------------------------------------------------------------------
; SerialFlushTx                                  1191D1  97 PC, low confidence
; Serial port: empties the send buffer
;-----------------------------------------------------------------------------
SerialFlushTx:
        push ebp
        LD mov, ebp, esp
        push ebx
        mov eax, dword [byte ebp+08h]
        mov ebx, dword [nosplit eax*4+SerialPortTable]
        pushf
        cli
        mov eax, dword [byte ebx+020h]
        mov dword [byte ebx+024h], eax
        mov dword [byte ebx+028h], 0FFFFFFFFh
        popf
        pop ebx
        leave
        ret
;-----------------------------------------------------------------------------
; SerialWaitTxEmpty                              1191F2  97 PC, low confidence
; Serial port: waits until the send buffer is empty or the time runs out
;-----------------------------------------------------------------------------
SerialWaitTxEmpty:
        push ebp
        LD mov, ebp, esp
        add esp, byte 0FFFFFFFCh
        push edi
        push ebx
        push esi
        call GetTicks
        LD mov, esi, eax
        mov eax, dword [byte ebp+08h]
        mov ebx, dword [nosplit eax*4+SerialPortTable]
        mov dword [byte ebp-04h], ebx
.1:
        mov ebx, dword [byte ebp-04h]
        mov ecx, dword [byte ebp+0Ch]
        cmp ecx, dword [byte ebx+03Ch]
        jle short .2
        push esi
        call TicksSince
        add esp, byte 4
        cmp eax, dword [byte ebp+014h]
        jl short .1
        mov ebx, dword [byte ebp-04h]
        mov ecx, dword [byte ebx+03Ch]
        mov dword [byte ebp+0Ch], ecx
.2:
        jmp short SerialRead_46
        push ebp
        LD mov, ebp, esp
        add esp, byte 0FFFFFFFCh
        push edi
        push ebx
        push esi
        mov eax, dword [byte ebp+08h]
        mov ebx, dword [nosplit eax*4+SerialPortTable]
        mov ecx, dword [byte ebp+0Ch]
        cmp ecx, dword [byte ebx+03Ch]
        jle short SerialRead_46
        LD xor, eax, eax
        pop esi
        pop ebx
        pop edi
        leave
        ret
;-----------------------------------------------------------------------------
; SerialRead                                     119255  97 PC, low confidence
; Serial port: reads received bytes
;-----------------------------------------------------------------------------
SerialRead:
        push ebp
        LD mov, ebp, esp
        add esp, byte 0FFFFFFFCh
        push edi
        push ebx
        push esi
        mov eax, dword [byte ebp+08h]
        mov ebx, dword [nosplit eax*4+SerialPortTable]
        mov ecx, dword [byte ebx+03Ch]
        LD or, ecx, ecx
        jne short .1
        LD xor, eax, eax
        pop esi
        pop ebx
        pop edi
        leave
        ret
.1:
        cmp ecx, dword [byte ebp+0Ch]
        jle short SerialRead_46
        mov ecx, dword [byte ebp+0Ch]
        jmp short SerialRead_46
        push ebp
        LD mov, ebp, esp
        add esp, byte 0FFFFFFFCh
        push edi
        push ebx
        push esi
        mov eax, dword [byte ebp+08h]
        mov ebx, dword [nosplit eax*4+SerialPortTable]
        mov ecx, dword [byte ebp+0Ch]
.2:
        cmp ecx, dword [byte ebx+03Ch]
        jg short .2
SerialRead_46:
        cld
        mov dword [byte ebp+0Ch], ecx
        LD or, ecx, ecx
        jle short .5
        mov edi, dword [byte ebp+010h]
        mov edx, dword [byte ebx+030h]
        mov esi, dword [byte ebx+038h]
.3:
        mov al, byte [esi]
        mov byte [edi], al
        inc esi
        inc edi
        LD cmp, esi, edx
        jb short .4
        mov esi, dword [byte ebx+02Ch]
.4:
        loop .3
        mov dword [byte ebx+038h], esi
.5:
        mov eax, dword [byte ebp+0Ch]
        LD or, eax, eax
        je short .6
        sub dword [byte ebx+03Ch], eax
        pushf
        cli
        mov ecx, dword [byte ebx+040h]
        mov dword [byte ebx+040h], 0
        popf
        LD or, ecx, ecx
        je short .6
        neg eax
.6:
        pop esi
        pop ebx
        pop edi
        leave
        ret
        push ebp
        LD mov, ebp, esp
        add esp, byte 0FFFFFFFCh
        push edi
        push ebx
        push esi
        mov eax, dword [byte ebp+08h]
        mov ebx, dword [nosplit eax*4+SerialPortTable]
        mov eax, dword [byte ebx+03Ch]
        LD or, eax, eax
        je short .10
        mov ecx, dword [byte ebp+0Ch]
        LD cmp, ecx, eax
        jle short .7
        LD mov, ecx, eax
.7:
        LD mov, eax, ecx
        LD or, ecx, ecx
        jle short .10
        push eax
        mov edi, dword [byte ebp+010h]
        mov edx, dword [byte ebx+030h]
        mov esi, dword [byte ebx+038h]
.8:
        mov al, byte [esi]
        mov byte [edi], al
        inc esi
        inc edi
        LD cmp, esi, edx
        jb short .9
        mov esi, dword [byte ebx+02Ch]
.9:
        loop .8
        pop eax
.10:
        pop esi
        pop ebx
        pop edi
        leave
        ret
;-----------------------------------------------------------------------------
; SerialFlushRx                                  119328  97 PC, low confidence
; Serial port: empties the receive buffer
;-----------------------------------------------------------------------------
SerialFlushRx:
        push ebp
        LD mov, ebp, esp
        push ebx
        mov eax, dword [byte ebp+08h]
        mov ebx, dword [nosplit eax*4+SerialPortTable]
        pushf
        cli
        mov eax, dword [byte ebx+034h]
        mov dword [byte ebx+038h], eax
        mov dword [byte ebx+03Ch], 0
        popf
        pop ebx
        leave
        ret
;-----------------------------------------------------------------------------
; SerialISR                                      119349  97 PC, low confidence
; Serial port: interrupt handler entries of the ports
;-----------------------------------------------------------------------------
SerialISR:
        push ebx
        lea ebx, [SerialPorts]
        jmp short SerialISR_1B.1
SerialISR_9:
        push ebx
        lea ebx, [SerialPorts+44Ch]
        jmp short SerialISR_1B.1
SerialISR_12:
        push ebx
        lea ebx, [SerialPorts+898h]
        jmp short SerialISR_1B.1
SerialISR_1B:
        push ebx
        lea ebx, [SerialPorts+0CE4h]
.1:
        push eax
        push ecx
        push edx
        push esi
        push edi
        push ds
        db 066h,02Eh,0A1h                       ; insn: mov ax,[cs:SerialIrqMask]
        dd SerialIrqMask
        mov ds, ax
        inc dword [byte ebx+044h]
        cld
        mov dx, word [byte ebx+08h]
        or dx, byte 2
        LD xor, eax, eax
        in al, dx
        test al, 1
        je short SerialISR_85.2
        jmp short SerialISR_B1
        db 01Fh,05Fh,05Eh,05Ah,059h,058h,03Bh,01Dh
        dd SerialPortTable
        db 075h,08h,05Bh,0EAh
        dd SerialPorts+0Ah wrt ..gotoff
        db 00h,00h,03Bh,01Dh
        dd SerialIsrPort1
        db 075h,08h,05Bh,0EAh
        dd SerialPorts+456h wrt ..gotoff
        db 00h,00h,03Bh,01Dh
        dd SerialIsrPort2
        db 075h,08h,05Bh,0EAh
        dd SerialPorts+8A2h wrt ..gotoff
        db 00h,00h,05Bh,0EAh
        dd SerialPorts+0CEEh wrt ..gotoff
        db 00h,00h
SerialISR_85:
        mov dx, word [byte ebx+08h]
        or dx, byte 2
        LD xor, eax, eax
        in al, dx
        test al, 1
        jne short SerialISR_B1
.2:
        LD mov, esi, eax
        and esi, byte 6
        db 02Eh,0FFh,024h,075h                  ; insn: jmp dword [cs:esi*2+SerialIsrJumpTable]
        dd SerialIsrJumpTable
SerialIsrJumpTable:                             ; jump table for the switch cases of SerialISR
        dd SerialISR_B1.1
        dd SerialISR_B1.6
        dd SerialISR_B1.12
        dd SerialISR_B1.12
SerialISR_B1:
        mov al, 20h
        out 20h, al
        pop ds
        pop edi
        pop esi
        pop edx
        pop ecx
        pop eax
        pop ebx
        iret
.1:
        and dx, byte 0FFF8h
        or dx, byte 6
        in al, dx
        test al, 8
        je short .4
.2:
        test al, 80h
        je short .3
        jmp short .12
.3:
        jmp short SerialISR_85
.4:
        test al, 1
        je short .5
        test al, 10h
        je short .2
        jmp short .6
.5:
        test al, 2
        je short .2
        test al, 20h
        je short .2
        jmp short .12
.6:
        mov ecx, dword [byte ebx+028h]
        dec ecx
        jl short .8
        mov esi, dword [byte ebx+020h]
        mov al, byte [esi]
        and dx, byte 0FFF8h
        out dx, al
        mov dword [byte ebx+028h], ecx
        inc esi
        cmp esi, dword [byte ebx+01Ch]
        jb short .7
        mov esi, dword [byte ebx+018h]
.7:
        mov dword [byte ebx+020h], esi
        jmp near SerialISR_85
.8:
        cmp ecx, byte 0FFFFFFFFh
        jne short .9
        mov dword [byte ebx+028h], ecx
        jmp near SerialISR_85
.9:
        and dx, byte 0FFF8h
        or dx, byte 4
        in al, dx
        and al, 19h
        jmp short .10
.10:
        out dx, al
.11:
        jmp near SerialISR_85
.12:
        and dx, byte 0FFF8h
        or dx, byte 5
        in al, dx
        LD mov, ah, al
        test ah, 10h
        jne short .11
        test ah, 1
        je short .11
        and dx, byte 0FFF8h
        in al, dx
        test ah, 2
        je short .14
        inc dword [byte ebx+03Ch]
        inc dword [byte ebx+040h]
        mov esi, dword [byte ebx+034h]
        mov byte [esi], 0
        inc esi
        cmp esi, dword [byte ebx+030h]
        jb short .13
        mov esi, dword [byte ebx+02Ch]
.13:
        mov dword [byte ebx+034h], esi
.14:
        inc dword [byte ebx+03Ch]
        mov esi, dword [byte ebx+034h]
        mov byte [esi], al
        inc esi
        cmp esi, dword [byte ebx+030h]
        jb short .15
        mov esi, dword [byte ebx+02Ch]
.15:
        mov dword [byte ebx+034h], esi
        mov ecx, dword [byte ebx+03Ch]
        cmp ecx, 200h
        jle short .16
        add dword [byte ebx+040h], 10000h
.16:
        jmp near SerialISR_85
