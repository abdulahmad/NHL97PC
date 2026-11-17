; Modem commands: reset, hang-up, dial, auto answer, connect and results.
bits 32
%include "hockey.inc"
section s_7C5F1 progbits alloc exec nowrite align=1
extern atoi_, ModemLastResult, ModemResultCodeTable, ModemResultCount, ModemResultTextTable, SerialFlushTx, SerialRaiseDtr, SerialWaitTxEmpty
extern SerialWrite, str_AT, str_ATA, str_ATD, str_ATE1Q0X4F1, str_ATH0, str_ATM0, str_ATS01
extern str_ATZS760S1155, str_D_UpdateFrameRate, str_P, str_Punct2, str_Punct_ModemSendCommand, str_T, strcat_, strcpy_
extern strlen_, strncmp_, strstr_, WaitTicks
global putchar, ModemReset, ModemHangup, ModemDial, ModemAutoAnswer, ModemWaitConnect, ModemReadResult, ModemSendCommand
global ModemAttention, ModemSpeakerOff
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; putchar                                      7C600  96 PC, medium confidence
; Run-time library putchar slot; here it passes its second argument to ModemReset
;-----------------------------------------------------------------------------
putchar:
        push str_ATZS760S1155
        mov edx, dword [byte esp+08h]
        push edx
        call ModemReset
        add esp, byte 8
        ret
        db 090h
;-----------------------------------------------------------------------------
; ModemReset                                      7C614  97 PC, low confidence
; Sends the modem set-up string "ATE1Q0X4F1"
;-----------------------------------------------------------------------------
ModemReset:
        push ebx
        push esi
        mov esi, dword [byte esp+0Ch]
        mov edx, dword [byte esp+010h]
        mov eax, esi
        call ModemAttention
        test eax, eax
        jne short .1
        mov eax, 4
        pop esi
        pop ebx
        ret
.1:
        mov eax, esi
        xor ebx, ebx
        call ModemSendCommand
        test eax, eax
        jne short .2
        mov eax, 4
        pop esi
        pop ebx
        ret
.2:
        mov eax, dword [str_D_UpdateFrameRate]
        add eax, eax
        push eax
        push esi
        call ModemReadResult
        add esp, byte 8
        mov edx, eax
        test eax, eax
        jne short .4
        mov edx, str_ATE1Q0X4F1
        mov eax, esi
        xor ebx, ebx
        call ModemSendCommand
        test eax, eax
        jne short .3
        mov eax, 4
        pop esi
        pop ebx
        ret
.3:
        mov eax, dword [str_D_UpdateFrameRate]
        add eax, eax
        push eax
        push esi
        call ModemReadResult
        add esp, byte 8
        mov edx, eax
.4:
        mov eax, edx
        pop esi
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; ModemHangup                                  7C690  96 PC, medium confidence
; (port): ModemAttention, then ATH0 and its answer; 4 when the modem does not
; answer
;-----------------------------------------------------------------------------
ModemHangup:
        push ebx
        mov ecx, dword [byte esp+08h]
        mov eax, ecx
        call ModemAttention
        test eax, eax
        jne short .1
        mov eax, 4
        pop ebx
        ret
.1:
        mov edx, str_ATH0
        mov eax, ecx
        xor ebx, ebx
        call ModemSendCommand
        test eax, eax
        jne short .2
        mov eax, 4
        pop ebx
        ret
.2:
        mov eax, dword [str_D_UpdateFrameRate]
        add eax, eax
        push eax
        push ecx
        call ModemReadResult
        add esp, byte 8
        pop ebx
        ret
        db 090h
        push ebx
        push esi
        sub esp, byte 50h
        mov esi, dword [byte esp+05Ch]
        push esi
        call ModemHangup
        add esp, byte 4
        mov edx, str_ATD
        mov eax, esp
        call strcpy_
        mov edx, dword [byte esp+060h]
        mov eax, esp
        mov ebx, 1
        call strcat_
        mov edx, esp
        mov eax, esi
        call ModemSendCommand
        add esp, byte 50h
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ModemDial                                    7C714  97 PC, medium confidence
; Hangs up, then dials with "ATD" + the number (ModemSendCommand,
; ModemReadResult)
;-----------------------------------------------------------------------------
ModemDial:
        push ebx
        push esi
        sub esp, byte 50h
        mov esi, dword [byte esp+05Ch]
        push esi
        call ModemHangup
        add esp, byte 4
        mov eax, esp
        mov edx, dword [byte esp+064h]
        call strcpy_
        cmp dword [byte esp+068h], byte 0
        je short .1
        mov edx, str_T
        jmp short .2
.1:
        mov edx, str_P
.2:
        mov eax, esp
        call strcat_
        mov edx, dword [byte esp+060h]
        mov eax, esp
        mov ebx, 1
        call strcat_
        mov edx, esp
        mov eax, esi
        call ModemSendCommand
        add esp, byte 50h
        pop esi
        pop ebx
        ret
        db 08Bh,0C0h
        push ebx
        push esi
        mov esi, dword [byte esp+0Ch]
        push esi
        call ModemHangup
        xor ebx, ebx
        add esp, byte 4
        mov eax, esi
        mov edx, str_ATD
        call ModemAttention
        mov eax, esi
        call ModemSendCommand
        mov eax, dword [str_D_UpdateFrameRate]
        add eax, eax
        push eax
        push esi
        call ModemReadResult
        add esp, byte 8
        pop esi
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ModemAutoAnswer                              7C7A4  96 PC, medium confidence
; (port): hangs up, then ATS0=1 (answer on the first ring)
;-----------------------------------------------------------------------------
ModemAutoAnswer:
        push ebx
        push esi
        mov esi, dword [byte esp+0Ch]
        push esi
        mov ebx, 1
        call ModemHangup
        add esp, byte 4
        mov edx, str_ATS01
        mov eax, esi
        call ModemSendCommand
        pop esi
        pop ebx
        ret
        db 090h
        push str_ATA
        push byte 4
        mov edx, dword [byte esp+0Ch]
        push edx
        call SerialWrite
        add esp, byte 0Ch
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ModemWaitConnect                             7C7E0  96 PC, medium confidence
; (port): reads one modem result: 0 for none / NO CARRIER-type results, 4 for
; an error, else the result code (1 / 5 / 10+ = CONNECT at some speed)
;-----------------------------------------------------------------------------
ModemWaitConnect:
        mov eax, dword [str_D_UpdateFrameRate]
        mov edx, eax
        sar edx, 1Fh
        shl edx, 2
        LD sbb, eax, edx
        sar eax, 2
        push eax
        mov edx, dword [byte esp+08h]
        push edx
        call ModemReadResult
        add esp, byte 8
        mov edx, eax
        test eax, eax
        je short .1
        cmp eax, byte 2
        je short .1
        cmp eax, byte 0FFFFFFFFh
        jne short .2
.1:
        xor eax, eax
        ret
.2:
        cmp eax, byte 1
        je short .3
        cmp eax, byte 5
        je short .3
        cmp eax, byte 0Ah
        setl al
        and eax, 0FFh
        je short .3
        mov eax, 4
        ret
.3:
        mov eax, edx
        ret
        db 090h
;-----------------------------------------------------------------------------
; ModemReadResult                              7C834  96 PC, medium confidence
; (port, timeout): reads a line from the modem (at most 41 characters) and matches it against
; ModemResultTextTable; returns its code, -1 for none
;-----------------------------------------------------------------------------
ModemReadResult:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 3Ch
        xor edx, edx
        mov eax, esp
        mov dword [byte esp+02Ch], edx
        dec eax
        mov dword [byte esp+038h], edx
        mov dword [byte esp+034h], eax
.1:
        mov ecx, dword [byte esp+054h]
        mov eax, esp
        mov esi, dword [byte esp+02Ch]
        push ecx
        add eax, esi
        push eax
        push byte 1
        mov edi, dword [byte esp+05Ch]
        push edi
        call SerialWaitTxEmpty
        add esp, byte 10h
        test eax, eax
        je near .14
        mov ebp, dword [byte esp+034h]
        lea eax, [byte esi+01h]
        inc ebp
        mov dword [byte esp+02Ch], eax
        mov dl, byte [byte esp+eax-01h]
        mov dword [byte esp+034h], ebp
        cmp dl, 20h
        jae short .2
        mov byte [byte esp+eax-01h], 5Fh
.2:
        mov eax, dword [byte esp+02Ch]
        mov bl, byte [byte esp+eax-01h]
        cmp bl, 30h
        jb short .3
        cmp bl, 39h
        ja short .3
        mov eax, 1
        jmp short .4
.3:
        xor eax, eax
.4:
        mov edx, dword [byte esp+038h]
        mov dword [byte esp+030h], eax
        test edx, edx
        jne short .5
        test eax, eax
        je short .5
        mov eax, dword [byte esp+034h]
        mov dword [byte esp+038h], eax
.5:
        mov eax, dword [byte esp+02Ch]
        xor cl, cl
        xor ebp, ebp
        xor edi, edi
        mov byte [esp+eax], cl
.6:
        mov ebx, dword [ModemResultCount]
        dec ebx
        test ebx, ebx
        jl short .9
        imul ecx, ebx, byte 0Ch
        add ecx, edi
.7:
        imul esi, ebx, byte 0Ch
        mov eax, esp
        mov edx, dword [dword ecx+ModemResultTextTable]
        call strstr_
        test eax, eax
        je short .8
        test ebp, ebp
        setg al
        mov ebx, dword [ModemLastResult]
        and eax, 0FFh
        or ebx, eax
        mov eax, dword [dword esi+ModemResultCodeTable]
        mov dword [ModemLastResult], ebx
        call atoi_
        jmp near .15
.8:
        dec ebx
        sub ecx, byte 0Ch
        test ebx, ebx
        jge short .7
.9:
        add edi, byte 4
        inc ebp
        cmp edi, byte 8
        jl short .6
        mov ecx, dword [byte esp+038h]
        test ecx, ecx
        je short .10
        cmp dword [byte esp+030h], byte 0
        jne short .10
        cmp dword [ModemLastResult], byte 0
        jne short .11
.10:
        cmp dword [byte esp+02Ch], byte 29h
        jl near .1
        jmp short .14
.11:
        mov eax, ecx
        call atoi_
        mov edx, eax
        cmp eax, byte 0Ah
        jl short .12
        mov edx, 1
        jmp short .13
.12:
        test eax, eax
        jge short .13
        mov edx, 0FFFFFFFFh
.13:
        mov eax, edx
        add esp, byte 3Ch
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.14:
        mov eax, 0FFFFFFFFh
.15:
        add esp, byte 3Ch
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; ModemSendCommand                             7C988  96 PC, medium confidence
; (port, command, flush): sends command + CR (at most 79 characters) and
; checks the modem echoes it; 1 when it does
;-----------------------------------------------------------------------------
ModemSendCommand:
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 50h
        mov esi, eax
        mov edi, edx
        mov eax, edx
        call strlen_
        mov ebp, eax
        cmp eax, byte 4Fh
        jle short .1
        xor eax, eax
        jmp short .3
.1:
        test ebx, ebx
        je short .2
        push esi
        call SerialRaiseDtr
        add esp, byte 4
        push esi
        call SerialFlushTx
        add esp, byte 4
.2:
        push byte 14h
        lea eax, [byte esp+04h]
        push eax
        push byte 1
        push esi
        call SerialWaitTxEmpty
        add esp, byte 10h
        test eax, eax
        jne short .2
        push edi
        push ebp
        push esi
        call SerialWrite
        add esp, byte 0Ch
        push str_Punct_ModemSendCommand
        push byte 1
        push esi
        call SerialWrite
        add esp, byte 0Ch
        push byte 19h
        lea eax, [byte esp+04h]
        push eax
        push ebp
        push esi
        call SerialWaitTxEmpty
        lea edx, [byte esp+010h]
        add esp, byte 10h
        mov ebx, eax
        mov eax, edi
        call strncmp_
        test eax, eax
        sete al
        and eax, 0FFh
.3:
        add esp, byte 50h
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; ModemAttention                               7CA1C  96 PC, medium confidence
; (port): flushes, waits, sends "+++" (escape to command mode), waits, sends
; AT and reads the answer; 1 when the modem answers
;-----------------------------------------------------------------------------
ModemAttention:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov esi, eax
        mov edi, 1
        xor ebp, ebp
.1:
        dec edi
        cmp edi, byte 0FFFFFFFFh
        je near .3
        push esi
        call SerialFlushTx
        add esp, byte 4
        push esi
        call SerialRaiseDtr
        add esp, byte 4
        push byte 69h
        call WaitTicks
        add esp, byte 4
        push str_Punct2
        push byte 3
        push esi
        call SerialWrite
        add esp, byte 0Ch
        push byte 69h
        mov ebx, ebp
        call WaitTicks
        add esp, byte 4
        mov edx, str_AT
        mov eax, esi
        call ModemSendCommand
        test eax, eax
        je short .2
        mov eax, dword [str_D_UpdateFrameRate]
        add eax, eax
        push eax
        push esi
        call ModemReadResult
        add esp, byte 8
        test eax, eax
        jne short .2
        mov eax, 1
        jmp short .4
.2:
        test edi, edi
        je short .1
        push byte 32h
        call WaitTicks
        add esp, byte 4
        jmp short .1
.3:
        xor eax, eax
.4:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; ModemSpeakerOff                                 7CAB4  97 PC, low confidence
; Sends "ATM0"
;-----------------------------------------------------------------------------
ModemSpeakerOff:
        push ebx
        mov ecx, dword [byte esp+08h]
        mov edx, str_ATM0
        mov eax, ecx
        xor ebx, ebx
        call ModemSendCommand
        mov eax, dword [str_D_UpdateFrameRate]
        add eax, eax
        push eax
        push ecx
        call ModemReadResult
        add esp, byte 8
        pop ebx
        ret
