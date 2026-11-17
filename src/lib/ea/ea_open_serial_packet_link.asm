; EA library: OpenSerialPacketLink, ModemLinkClose, ModemLinkOpen, ModemLinkHangup and 70 more.
bits 32
%include "hockey.inc"
section s_11C131 progbits alloc exec nowrite align=1
extern AddExitHandler, AddIdleHandler, addtimer, AllocMemBlock, AllocMemData, bcopy, FillMem, FreeMemBlock
extern int386_, int386x_, IpxBufferOffset, IpxBufferSegment, IpxCallOffset, IpxCallSegment, IpxEcb, IpxHookBase
extern IpxHookCodeA, IpxHookCodeB, IpxHookCodeC, IpxHookInstalled, IpxListenEcb, IpxListening, IpxLocalAddr, IpxPacketBuffer
extern IpxPacketFlags, IpxPacketType, IpxPresent, IpxRealRegs, IpxRealSegment, IpxSavedVecOffset, IpxSavedVecSegment, IpxSocket
extern IpxSocketNum, IpxSocketResult, IpxStartupState, IpxTargetAddr, LinkTextFont, MessageBoxActive, ModemAutoAnswer, ModemConnected
extern ModemDial, ModemHangup, ModemLinkFuncs, ModemReset, ModemSpeakerOff, ModemWaitConnect, NetAnnounceFn, NetBufferPool
extern NetCloseFn, NetDisconnectFn, NetDropFn, NetJoinFn, NetLastTime, NetLeaveFn, NetLinkFuncs, NetLinkOpenFn
extern NetListNextFn, NetListStartFn, NetLocalName, NetMaxPeers, NetMessageBuf, NetNameFn, NetOpenFn, NetPeerDropFn
extern NetPeerSendFn, NetPollState, NetProtocolName, NetRxCount, NetSendFn, NetSendRetries, NetSessionHandle, NetSessionName
extern NetSessionOpen, OpenPacketLink, putchar, QueueAppend, QueueCount, QueueFind, QueueFreeAll, QueueInit
extern QueueNoOp, QueuePeek, QueuePostBuffer, QueueTakeHead, QueueTakeTail, RemoveIdleHandler, RemoveTimerCallback, RunIdleHandlers
extern segread_, SerialCarrier, SerialConfigure, SerialFlushRx, SerialIsOpen, SerialLinkFuncs, SerialOpen, SerialProgramUart
extern SerialRead, SerialRxCount, SerialSetBaud, SerialTxFree, SerialWrite, SerialWriteIfRoom, sprintf_, StoreBigEndian
extern str_ATD2, str_D_NetHandleMessage, str_D_UpdateFrameRate, str_EAGAME08x04x04x02x02x02x0, str_Galloc, str_GEND, str_GFRE, str_GMEM
extern str_IPXINTF, str_IPXSOCK, str_Netserv, str_Punct_IpxHookCheck, str_Punct_ModemLinkOpen, str_Punct_NetLeaveGame, strncmp_, strncpy_
extern TextOriginX, TextOriginY, TimerTicks, WaitTicks, ZeroMem
global OpenSerialPacketLink, ModemLinkClose, ModemLinkOpen, ModemLinkHangup, ModemLinkCarrier, ModemLinkTxFree, ModemLinkRxCount, ModemLinkRead
global ModemLinkWrite, OpenModemPacketLink, NetPollMsgBlank, NetAnnounceMsgBlank, NetJoinMsgBlank, NetDisconnectMsgBlank, NetBroadcastMsgBlank, NetLogf
global SameNetAddress, NetTimeoutPassed, LowestSetBit, NetSendMessage, NetSendWait, NetFindPeer, NetFreeSlot, NetQueueMessage
global NetHandleMessage, NetPollMessages, NetPollMessages_168, NetPollMessages_184, NetCopyName, NetOpenSession, NetCloseSession, NetAnnounce
global NetJoinGame, NetLeaveGame, NetListGames, NetDisconnectPeer, OpenNetPacketLink, NetPeerSend, NetLinkRead, NetLinkWrite
global NetLinkConnected, NetLinkRxCount, NetLinkTxFree, NetBroadcast, NetHashName, IpxCloseSocketCall, IpxGetAddressCall, IpxGetTargetCall
global IpxRelinquishCall, IpxOpenSocketCall, IpxSetupPacket, IpxResolveTarget, IpxResolveTarget_8C, IpxSendPacket, IpxPostListen, SetPairOneZero
global IpxDetect, IpxHookCheck, IpxRestoreVector, IpxSetupLayer, IpxShutdown, IpxSocketNumber, IpxStart, IpxStop
global IpxBuildHeader, IpxClearName, IpxSameNode, IpxCopyAddress, IpxLookupTarget, IpxLockSend, IpxLockListen, IpxQueueSend
global IpxReceive, IpxPeek, IpxLinkStartup, SetNetCallback, AllocNetBuffer, FreeNetBuffer, ReadBigEndian, WriteBigEndian
global GetCurrentFont, SetTextOrigin
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; OpenSerialPacketLink                           11C134  97 PC, low confidence
; Opens a packet link over the serial port
;-----------------------------------------------------------------------------
OpenSerialPacketLink:
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
        push SerialLinkFuncs
        mov edi, dword [byte esp+024h]
        push edi
        call OpenPacketLink
        add esp, byte 18h
        pop edi
        pop esi
        pop ebx
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; ModemLinkClose                                 11C170  97 PC, low confidence
; Hangs up the modem and closes the link
;-----------------------------------------------------------------------------
ModemLinkClose:
        push ebx
        push esi
        xor ebx, ebx
.1:
        mov edx, dword [ModemConnected]
        test edx, edx
        jne short .4
.2:
        cmp dword [ModemConnected], byte 0
        jne short .3
        db 068h                                 ; insn: push ModemLinkClose
        dd ModemLinkClose
        call RemoveIdleHandler
        add esp, byte 4
.3:
        xor eax, eax
        pop esi
        pop ebx
        ret
.4:
        mov eax, 1
        mov cl, bl
        shl eax, cl
        test eax, edx
        je short .5
        not eax
        mov esi, edx
        and esi, eax
        push ebx
        mov dword [ModemConnected], esi
        call ModemHangup
        add esp, byte 4
        push ebx
        call putchar
        add esp, byte 4
.5:
        inc ebx
        cmp ebx, byte 20h
        jl short .1
        jmp short .2
;-----------------------------------------------------------------------------
; ModemLinkOpen                                  11C1CC  97 PC, low confidence
; Opens the modem link: resets, dials or answers
;-----------------------------------------------------------------------------
ModemLinkOpen:
        push ebx
        push esi
        push edi
        push ebp
        mov esi, dword [byte esp+014h]
        mov ebx, esi
        mov dword [byte esi+028h], 0
        mov edx, dword [byte esi+030h]
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
        je near .13
        mov edi, dword [byte ebx+040h]
        push edi
        mov ebp, dword [byte ebx+03Ch]
        push ebp
        mov eax, dword [byte ebx+038h]
        push eax
        mov edx, dword [byte ebx+034h]
        push edx
        mov ecx, dword [byte ebx+02Ch]
        push ecx
        call SerialConfigure
        add esp, byte 14h
        mov edi, dword [byte ebx+02Ch]
        push edi
        xor esi, esi
        call SerialFlushRx
        mov ebp, dword [byte ebx+04Ch]
        add esp, byte 4
        test ebp, ebp
        je short .3
        push ebp
        mov edx, dword [byte ebx+02Ch]
        push edx
        call ModemReset
        add esp, byte 8
        mov esi, eax
.3:
        test esi, esi
        jne near .13
        cmp dword [byte ebx+044h], byte 0
        je short .4
        mov esi, dword [byte ebx+02Ch]
        push esi
        call ModemSpeakerOff
        add esp, byte 4
.4:
        mov edi, dword [byte ebx+054h]
        test edi, edi
        je short .5
        sub ecx, ecx
        dec ecx
        xor eax, eax
        repne scasb
        not ecx
        dec ecx
        test ecx, ecx
        jne short .6
.5:
        mov edi, dword [byte ebx+02Ch]
        push edi
        call ModemAutoAnswer
        add esp, byte 4
        jmp short .9
.6:
        mov ebp, dword [byte ebx+050h]
        test ebp, ebp
        je short .7
        mov edi, ebp
        sub ecx, ecx
        dec ecx
        xor eax, eax
        repne scasb
        not ecx
        dec ecx
        test ecx, ecx
        jne short .8
.7:
        mov dword [byte ebx+050h], str_ATD2
.8:
        mov eax, dword [byte ebx+048h]
        push eax
        mov edx, dword [byte ebx+050h]
        push edx
        mov ecx, dword [byte ebx+054h]
        push ecx
        mov esi, dword [byte ebx+02Ch]
        push esi
        call ModemDial
        add esp, byte 10h
.9:
        xor esi, esi
.10:
        cmp esi, dword [byte ebx+028h]
        jne short .12
        push ebx
        call dword [byte ebx+014h]
        add esp, byte 4
        test eax, eax
        jne short .12
        mov eax, dword [byte ebx+02Ch]
        push eax
        call ModemWaitConnect
        add esp, byte 4
        cmp eax, byte 4
        je short .12
        test eax, eax
        jle short .11
        mov dword [byte ebx+028h], 1
.11:
        push esi
        call RunIdleHandlers
        add esp, byte 4
        jmp short .10
.12:
        cmp dword [byte ebx+028h], byte 0
        jne short .13
        push str_Punct_ModemLinkOpen
        push byte 1
        mov ecx, dword [byte ebx+02Ch]
        push ecx
        call SerialWrite
        add esp, byte 0Ch
        mov esi, dword [byte ebx+02Ch]
        push esi
        call putchar
        add esp, byte 4
.13:
        mov eax, dword [byte ebx+028h]
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ModemLinkHangup                                11C340  97 PC, low confidence
; Hangs up the modem link
;-----------------------------------------------------------------------------
ModemLinkHangup:
        push ebx
        mov ebx, dword [byte esp+08h]
        cmp dword [byte ebx+028h], byte 0
        je short .1
        push byte 0
        push byte 0
        db 068h                                 ; insn: push ModemLinkClose
        dd ModemLinkClose
        call AddIdleHandler
        mov eax, 1
        mov cl, byte [byte ebx+02Ch]
        shl eax, cl
        mov ecx, dword [ModemConnected]
        or ecx, eax
        add esp, byte 0Ch
        mov dword [ModemConnected], ecx
        mov dword [byte ebx+028h], 0
.1:
        mov eax, 1
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; ModemLinkCarrier                               11C384  97 PC, low confidence
; Returns whether the modem has carrier
;-----------------------------------------------------------------------------
ModemLinkCarrier:
        push ebx
        mov eax, dword [byte esp+08h]
        cmp dword [byte eax+028h], byte 0
        je short .1
        mov ebx, dword [byte eax+02Ch]
        push ebx
        call SerialCarrier
        add esp, byte 4
        test eax, eax
        je short .1
        mov eax, 1
        pop ebx
        ret
.1:
        xor eax, eax
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; ModemLinkTxFree                                11C3AC  97 PC, low confidence
; Returns the free space of the modem send buffer
;-----------------------------------------------------------------------------
ModemLinkTxFree:
        mov eax, dword [byte esp+04h]
        mov edx, dword [byte eax+02Ch]
        push edx
        call SerialTxFree
        add esp, byte 4
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ModemLinkRxCount                               11C3C0  97 PC, low confidence
; Returns the bytes waiting in the modem receive buffer
;-----------------------------------------------------------------------------
ModemLinkRxCount:
        mov eax, dword [byte esp+04h]
        mov edx, dword [byte eax+02Ch]
        push edx
        call SerialRxCount
        add esp, byte 4
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ModemLinkRead                                  11C3D4  97 PC, low confidence
; Reads from the modem link
;-----------------------------------------------------------------------------
ModemLinkRead:
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
; ModemLinkWrite                                 11C3FC  97 PC, low confidence
; Writes to the modem link when there is room
;-----------------------------------------------------------------------------
ModemLinkWrite:
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
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; OpenModemPacketLink                            11C41C  97 PC, low confidence
; Opens a packet link over the modem
;-----------------------------------------------------------------------------
OpenModemPacketLink:
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
        push ModemLinkFuncs
        mov edi, dword [byte esp+024h]
        push edi
        call OpenPacketLink
        add esp, byte 18h
        pop edi
        pop esi
        pop ebx
        ret
        db 00h,00h,00h,00h,00h,00h,00h
NetPollMsgBlank:                                ; used by NetPollMessages
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
        db 00h,00h,00h,00h,00h,00h,00h,00h
NetAnnounceMsgBlank:                            ; used by NetAnnounce
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
        db 00h,00h,00h,00h,00h,00h,00h,00h
NetJoinMsgBlank:                                ; used by NetJoinGame
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
        db 00h,00h,00h,00h,00h,00h,00h,00h
NetDisconnectMsgBlank:                          ; used by NetDisconnectPeer
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
        db 00h,00h,00h,00h,00h,00h,00h,00h
NetBroadcastMsgBlank:                           ; used by NetBroadcast
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
        db 00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; NetLogf                                        11C4C8  97 PC, low confidence
; Formats a network log message
;-----------------------------------------------------------------------------
NetLogf:
        push ebx
        xor ebx, ebx
        mov bl, byte [byte eax+0Fh]
        push ebx
        xor ebx, ebx
        mov bl, byte [byte eax+0Eh]
        push ebx
        xor ebx, ebx
        mov bl, byte [byte eax+0Dh]
        push ebx
        xor ebx, ebx
        mov bl, byte [byte eax+0Ch]
        push ebx
        xor ebx, ebx
        mov bl, byte [byte eax+0Bh]
        push ebx
        xor ebx, ebx
        mov bl, byte [byte eax+0Ah]
        push ebx
        xor ebx, ebx
        mov bl, byte [byte eax+09h]
        push ebx
        xor ebx, ebx
        mov bl, byte [byte eax+08h]
        push ebx
        xor ebx, ebx
        mov bx, word [byte eax+06h]
        push ebx
        xor ebx, ebx
        mov bx, word [byte eax+04h]
        push ebx
        mov ebx, dword [eax]
        push ebx
        push str_EAGAME08x04x04x02x02x02x0
        push edx
        call sprintf_
        add esp, byte 34h
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; SameNetAddress                                 11C51C  97 PC, low confidence
; Returns whether two network addresses are equal
;-----------------------------------------------------------------------------
SameNetAddress:
        push ebx
        push ecx
        push esi
        push edi
        mov esi, eax
        mov edi, edx
        mov eax, dword [eax]
        cmp eax, dword [edx]
        je short .1
        xor eax, eax
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.1:
        mov ax, word [byte esi+04h]
        cmp ax, word [byte edi+04h]
        je short .2
        xor eax, eax
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.2:
        mov ax, word [byte esi+06h]
        cmp ax, word [byte edi+06h]
        je short .3
        xor eax, eax
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.3:
        mov ebx, edi
        mov cl, byte [byte esi+08h]
        mov eax, esi
        mov ch, byte [byte edi+08h]
        xor edx, edx
        cmp cl, ch
        je short .5
.4:
        xor eax, eax
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.5:
        inc ebx
        inc edx
        inc eax
        cmp edx, byte 8
        jge short .6
        mov cl, byte [byte eax+08h]
        cmp cl, byte [byte ebx+08h]
        jne short .4
        jmp short .5
.6:
        mov eax, 1
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
        push edx
        mov edx, dword [TimerTicks]
        add eax, edx
        mov dword [NetLastTime], eax
        pop edx
        ret
;-----------------------------------------------------------------------------
; NetTimeoutPassed                               11C598  97 PC, low confidence
; Returns whether the network timeout has passed
;-----------------------------------------------------------------------------
NetTimeoutPassed:
        mov eax, dword [TimerTicks]
        sub eax, dword [NetLastTime]
        test eax, eax
        setge al
        and eax, 0FFh
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; LowestSetBit                                   11C5B0  97 PC, low confidence
; Returns the lowest set bit of a mask
;-----------------------------------------------------------------------------
LowestSetBit:
        push ebx
        push edx
        mov ebx, eax
        xor edx, edx
        test eax, eax
        je short .2
.1:
        mov ebx, eax
        neg ebx
        not ebx
        and eax, ebx
        inc edx
        test eax, eax
        jne short .1
.2:
        mov eax, edx
        pop edx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; NetSendMessage                                 11C5CC  97 PC, low confidence
; Sends a network message
;-----------------------------------------------------------------------------
NetSendMessage:
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 4Ch
        mov esi, eax
        mov edi, edx
        mov ebp, dword [byte eax+04h]
        test ebx, ebx
        jne short .1
        cmp dword [byte eax+08h], byte 0
        jne near .2
.1:
        push byte 4
        push ebx
        lea eax, [byte esp+08h]
        push eax
        call StoreBigEndian
        add esp, byte 0Ch
        push byte 4
        mov ebx, dword [dword esi+080h]
        push ebx
        lea eax, [byte esp+040h]
        push eax
        call StoreBigEndian
        add esp, byte 0Ch
        push byte 4
        mov ecx, dword [dword esi+084h]
        push ecx
        lea eax, [byte esp+044h]
        push eax
        call StoreBigEndian
        add esp, byte 0Ch
        push byte 4
        mov eax, dword [dword esi+088h]
        push eax
        lea eax, [byte esp+048h]
        push eax
        call StoreBigEndian
        add esp, byte 0Ch
        push byte 4
        mov edx, dword [dword esi+08Ch]
        push edx
        lea eax, [byte esp+04Ch]
        push eax
        call StoreBigEndian
        add esp, byte 0Ch
        push byte 4
        mov ebx, dword [dword esi+090h]
        push ebx
        lea eax, [byte esp+050h]
        push eax
        call StoreBigEndian
        add esp, byte 0Ch
        push byte 4
        mov ecx, dword [byte esi+04Ch]
        push ecx
        lea eax, [byte esp+0Ch]
        push eax
        mov ebx, 20h
        call StoreBigEndian
        add esp, byte 0Ch
        lea eax, [byte esp+08h]
        lea edx, [byte esi+050h]
        call strncpy_
        mov ebx, 10h
        lea eax, [byte esp+028h]
        lea edx, [byte esi+070h]
        mov ecx, esp
        call strncpy_
        push byte 4Ch
        mov ebx, 0EA646563h
        mov esi, dword [byte ebp+08h]
        mov edx, edi
        mov eax, dword [byte ebp+010h]
        call dword [byte esi+054h]
.2:
        add esp, byte 4Ch
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; NetSendWait                                    11C6B8  97 PC, low confidence
; Sends a network message and waits
;-----------------------------------------------------------------------------
NetSendWait:
        push esi
        push edi
        push ebp
        sub esp, byte 0Ch
        mov esi, eax
        mov dword [byte esp+08h], edx
        mov dword [byte esp+04h], ebx
        mov edi, ecx
        push byte 4
        mov dword [byte edx+0Ch], eax
        mov eax, dword [NetSendRetries]
        push eax
        mov dword [edx], eax
        push ecx
        inc eax
        mov dword [byte edx+04h], 0
        mov dword [NetSendRetries], eax
        call StoreBigEndian
        mov eax, dword [byte esi+08h]
        mov ecx, dword [byte eax+048h]
        add esp, byte 0Ch
        test ecx, ecx
        je short .1
        mov ebp, eax
        lea edx, [byte esi+014h]
        mov eax, dword [byte esi+010h]
        call dword [byte ebp+048h]
.1:
        mov eax, dword [byte esp+08h]
        mov dword [dword esi+094h], eax
        mov eax, dword [TimerTicks]
        mov ebp, dword [byte esp+020h]
        add eax, ebp
        mov dword [NetLastTime], eax
        mov eax, dword [byte esp+08h]
        cmp dword [byte eax+04h], byte 0
        jne short .5
        lea eax, [byte esi+014h]
        mov dword [esp], eax
.2:
        call NetTimeoutPassed
        test eax, eax
        jne short .5
        mov ecx, dword [byte esp+01Ch]
        mov ebx, dword [byte esp+04h]
        mov edx, dword [esp]
        mov ebp, dword [byte esi+08h]
        push ecx
        mov eax, dword [byte esi+010h]
        mov ecx, edi
        call dword [byte ebp+054h]
        test eax, eax
        je short .3
        mov ebp, dword [NetSessionHandle]
        push ebp
        jmp short .4
.3:
        push byte 1
.4:
        call WaitTicks
        add esp, byte 4
        mov eax, dword [byte esp+08h]
        cmp dword [byte eax+04h], byte 0
        je short .2
.5:
        mov dword [dword esi+094h], 0
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        ret 8
;-----------------------------------------------------------------------------
; NetFindPeer                                    11C780  97 PC, low confidence
; Finds a network peer
;-----------------------------------------------------------------------------
NetFindPeer:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov edi, eax
        mov ebp, edx
        lea esi, [dword eax+094h]
        xor ebx, ebx
.1:
        mov eax, 1
        mov cl, bl
        mov edx, dword [byte edi+04Ch]
        shl eax, cl
        test eax, edx
        je short .2
        imul eax, ebx, byte 64h
        push esi
        push ebp
        mov ecx, dword [byte edi+04h]
        push ecx
        mov dword [byte esp+0Ch], eax
        call NetPeerSend
        add esp, byte 0Ch
        test eax, eax
        je short .2
        add edi, dword [esp]
        mov eax, dword [NetMaxPeers]
        mov dword [dword edi+0F0h], eax
        mov eax, esi
        jmp short .3
.2:
        inc ebx
        add esi, byte 64h
        cmp ebx, byte 1Fh
        jl short .1
        xor eax, eax
.3:
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; NetFreeSlot                                    11C7E4  97 PC, low confidence
; Finds a free network slot
;-----------------------------------------------------------------------------
NetFreeSlot:
        push ebx
        push ecx
        push esi
        push edi
        mov ebx, eax
        mov esi, edx
        xor eax, eax
        jmp short .3
.1:
        mov edx, 1
        mov cl, al
        shl edx, cl
        mov ecx, dword [byte ebx+04Ch]
        test edx, ecx
        jne short .2
        mov edi, ecx
        or edi, edx
        lea edx, [nosplit eax*4+00h]
        sub edx, eax
        shl edx, 3
        add edx, eax
        shl edx, 2
        mov dword [byte ebx+04Ch], edi
        add ebx, edx
        mov ecx, 17h
        lea edi, [dword ebx+094h]
        mov edx, dword [NetMaxPeers]
        rep movsd
        mov dword [dword ebx+0F0h], edx
        mov dword [dword ebx+0F4h], eax
        mov edx, eax
        jmp short .4
.2:
        inc eax
.3:
        mov edx, dword [dword ebx+090h]
        dec edx
        cmp eax, edx
        jb short .1
        xor edx, edx
.4:
        mov eax, edx
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; NetQueueMessage                                11C854  97 PC, low confidence
; Queues a network message
;-----------------------------------------------------------------------------
NetQueueMessage:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, 8Ch
        mov esi, eax
        add eax, byte 28h
        mov edi, edx
        mov dword [dword esp+088h], eax
.1:
        push byte 14h
        lea eax, [byte esp+074h]
        push eax
        mov ebx, dword [dword esp+090h]
        mov edx, 0EA646174h
        push ebx
        mov dword [dword esp+090h], edx
        call bcopy
        lea ecx, [byte esp+0Ch]
        add esp, byte 0Ch
        lea ebx, [dword esp+084h]
        mov ebp, dword [byte esi+08h]
        push byte 70h
        lea edx, [byte esp+074h]
        mov eax, dword [byte esi+010h]
        call dword [byte ebp+058h]
        cmp dword [dword esp+084h], byte 0
        je short .2
        mov ecx, esp
        mov ebx, dword [dword esp+084h]
        push eax
        lea edx, [byte esp+074h]
        mov eax, edi
        call NetHandleMessage
.2:
        cmp dword [dword esp+084h], byte 0
        jne short .1
        add esp, 8Ch
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; NetHandleMessage                               11C8E0  97 PC, low confidence
; Handles a network message by its tag (get, ply, rsp, srv, req, opn, out,
; bad)
;-----------------------------------------------------------------------------
NetHandleMessage:
        push esi
        push edi
        push ebp
        sub esp, 0CCh
        mov edi, eax
        mov dword [dword esp+0C8h], edx
        mov esi, ecx
        mov ebp, dword [byte eax+0Ch]
        cmp ebx, 0EA676574h
        jb short .3
        lea eax, [byte ecx+04h]
        mov dword [dword esp+0C0h], eax
        jbe near .15
        cmp ebx, 0EA706C79h
        jb short .2
        jbe near .19
        cmp ebx, 0EA727370h
        jb short .1
        jbe near .33
        cmp ebx, 0EA737276h
        je near .6
        jmp near .41
.1:
        cmp ebx, 0EA726571h
        je near .7
        jmp near .41
.2:
        cmp ebx, 0EA6F706Eh
        jb near .41
        jbe near .34
        cmp ebx, 0EA6F7574h
        je near .39
        jmp near .41
.3:
        cmp ebx, 0EA626164h
        jb short .5
        jbe near .19
        cmp ebx, 0EA646174h
        jb short .4
        jbe near .37
        cmp ebx, 0EA646563h
        je near .8
        add esp, 0CCh
        pop ebp
        pop edi
        pop esi
        ret 4
.4:
        cmp ebx, 0EA627965h
        je near .39
        add esp, 0CCh
        pop ebp
        pop edi
        pop esi
        ret 4
.5:
        cmp ebx, 0EA61636Bh
        jb near .41
        jbe near .35
        cmp ebx, 0EA616464h
        je near .22
        add esp, 0CCh
        pop ebp
        pop edi
        pop esi
        ret 4
.6:
        test ebp, ebp
        je near .41
        mov edx, dword [byte ebp+0Ch]
        test edx, edx
        je near .41
        lea eax, [byte edx+0Ch]
        mov ebx, 20h
        mov edx, ecx
        call strncmp_
        test eax, eax
        jne near .41
        mov edx, dword [dword esp+0C8h]
        mov eax, dword [byte ebp+0Ch]
        xor ebx, ebx
        call NetSendMessage
        add esp, 0CCh
        pop ebp
        pop edi
        pop esi
        ret 4
.7:
        test ebp, ebp
        je near .41
        cmp dword [byte ebp+0Ch], byte 0
        je near .41
        mov ecx, 4
        mov eax, esi
        mov eax, dword [eax]
        bswap eax
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        mov ecx, dword [byte ebp+0Ch]
        mov ebx, eax
        mov eax, ecx
        call NetSendMessage
        add esp, 0CCh
        pop ebp
        pop edi
        pop esi
        ret 4
.8:
        mov ecx, 4
        mov eax, esi
        mov eax, dword [eax]
        bswap eax
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        mov ebx, eax
        test eax, eax
        jne short .9
        cmp dword [edi], byte 0
        jne short .9
        cmp dword [byte edi+010h], byte 0
        je short .9
        mov eax, 1
        jmp short .10
.9:
        xor eax, eax
.10:
        mov edx, eax
        test eax, eax
        jne short .13
        cmp dword [byte edi+010h], byte 0
        jne short .11
        mov ecx, dword [edi]
        test ecx, ecx
        je short .11
        cmp ebx, ecx
        jne short .11
        lea eax, [byte ebp+014h]
        push eax
        mov edx, dword [dword esp+0CCh]
        push edx
        push ebp
        call NetPeerSend
        add esp, byte 0Ch
        test eax, eax
        je short .11
        mov eax, 1
        jmp short .12
.11:
        xor eax, eax
.12:
        mov edx, eax
.13:
        test edx, edx
        je near .41
        cmp dword [dword ebp+09Ch], byte 0
        je short .14
        cmp dword [byte edi+010h], byte 0
        jne short .14
        mov eax, dword [str_D_NetHandleMessage]
        mov dword [dword ebp+09Ch], eax
.14:
        mov ecx, 4
        lea eax, [byte esi+038h]
        mov eax, dword [eax]
        bswap eax
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        mov ecx, 4
        mov dword [dword esp+0A0h], eax
        lea eax, [byte esi+03Ch]
        mov eax, dword [eax]
        bswap eax
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        mov ecx, 4
        mov dword [dword esp+0A4h], eax
        lea eax, [byte esi+040h]
        mov eax, dword [eax]
        bswap eax
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        mov ecx, 4
        mov dword [dword esp+0A8h], eax
        lea eax, [byte esi+044h]
        mov eax, dword [eax]
        bswap eax
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        mov ecx, 4
        mov dword [dword esp+0ACh], eax
        lea eax, [byte esi+048h]
        mov ebx, 20h
        mov eax, dword [eax]
        bswap eax
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        mov dword [dword esp+0B0h], eax
        lea edx, [byte esi+08h]
        lea eax, [byte esp+070h]
        call strncpy_
        mov ebx, 10h
        lea eax, [dword esp+090h]
        lea edx, [byte esi+028h]
        mov ecx, 4
        call strncpy_
        lea eax, [byte esi+04h]
        mov eax, dword [eax]
        bswap eax
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        mov dword [byte edi+08h], eax
        mov eax, dword [byte edi+010h]
        mov dword [byte edi+04h], 1
        test eax, eax
        je near .41
        mov edx, dword [dword esp+0C8h]
        push edx
        mov eax, dword [byte esi+04h]
        call LowestSetBit
        push eax
        lea eax, [byte esp+078h]
        push eax
        push ebp
        call dword [byte edi+010h]
        add esp, byte 10h
        test eax, eax
        jne near .41
        mov dword [byte edi+010h], eax
        add esp, 0CCh
        pop ebp
        pop edi
        pop esi
        ret 4
.15:
        cmp dword [byte ebp+0Ch], byte 0
        je near .41
        mov eax, dword [esi]
        mov ecx, 64h
        mov dword [esp], eax
        mov dword [dword esp+0C4h], ecx
        mov eax, dword [byte esi+04h]
        mov ecx, 4
        mov dword [byte esp+04h], eax
        mov eax, dword [dword esp+0C0h]
        mov ebx, 0EA706C79h
        mov eax, dword [eax]
        bswap eax
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        cmp eax, byte 0FFFFFFFFh
        jne short .16
        mov ecx, 17h
        lea edi, [byte esp+08h]
        lea esi, [byte ebp+028h]
        rep movsd
        jmp short .18
.16:
        mov esi, dword [byte ebp+0Ch]
        mov edx, 1
        mov cl, al
        mov edi, dword [byte esi+04Ch]
        shl edx, cl
        test edx, edi
        je short .17
        mov edx, eax
        shl eax, 2
        sub eax, edx
        shl eax, 3
        add eax, edx
        mov ecx, 17h
        lea edi, [byte esp+08h]
        lea esi, [dword esi+eax*4+094h]
        rep movsd
        jmp short .18
.17:
        mov eax, 8
        mov ebx, 0EA626164h
        mov dword [dword esp+0C4h], eax
.18:
        mov edx, dword [dword esp+0C4h]
        mov ecx, esp
        mov esi, dword [byte ebp+08h]
        push edx
        mov eax, dword [byte ebp+010h]
        mov edx, dword [dword esp+0CCh]
        call dword [byte esi+054h]
        add esp, 0CCh
        pop ebp
        pop edi
        pop esi
        ret 4
.19:
        lea eax, [byte ebp+014h]
        push eax
        mov eax, dword [dword esp+0CCh]
        push eax
        push ebp
        call NetPeerSend
        add esp, byte 0Ch
        test eax, eax
        je near .41
        cmp dword [dword ebp+09Ch], byte 0
        je short .20
        mov eax, dword [str_D_NetHandleMessage]
        mov dword [dword ebp+09Ch], eax
.20:
        mov ecx, 4
        mov eax, esi
        mov eax, dword [eax]
        bswap eax
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        cmp dword [byte edi+014h], byte 0
        je near .41
        cmp eax, dword [edi]
        jne near .41
        cmp ebx, 0EA706C79h
        jne short .21
        lea edx, [byte esi+04h]
        mov ecx, 4
        mov eax, edx
        mov eax, dword [eax]
        bswap eax
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        cmp eax, byte 0FFFFFFFFh
        sete al
        and eax, 0FFh
        push eax
        mov ecx, 4
        mov eax, edx
        mov eax, dword [eax]
        bswap eax
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        inc eax
        push eax
        add esi, byte 8
        push esi
        mov eax, dword [byte edi+0Ch]
        push eax
        call dword [byte edi+014h]
        add esp, byte 10h
        test eax, eax
        jne short .21
        mov dword [byte edi+014h], eax
.21:
        mov dword [byte edi+04h], 1
        mov dword [edi], 0
        add esp, 0CCh
        pop ebp
        pop edi
        pop esi
        ret 4
.22:
        mov edx, dword [byte ebp+0Ch]
        test edx, edx
        je near .41
        cmp dword [byte edx+08h], byte 0
        jne near .41
        mov edx, dword [dword esp+0C8h]
        mov ecx, 0EA727370h
        mov eax, dword [byte ebp+0Ch]
        mov edi, 0Ch
        call NetFindPeer
        mov ebx, eax
        mov dword [dword esp+0B8h], ecx
        mov eax, dword [esi]
        mov dword [dword esp+0BCh], edi
        mov dword [esp], eax
        test ebx, ebx
        jne near .30
        mov eax, dword [byte ebp+0Ch]
        mov eax, dword [byte eax+04Ch]
        xor edx, edx
        test eax, eax
        je short .24
.23:
        mov ebx, eax
        neg ebx
        not ebx
        and eax, ebx
        inc edx
        test eax, eax
        jne short .23
.24:
        mov eax, dword [byte ebp+0Ch]
        cmp edx, dword [dword eax+090h]
        jae near .29
        cmp byte [byte eax+03Ch], 0
        je short .25
        mov ebx, 10h
        lea edx, [byte esi+04h]
        add eax, byte 3Ch
        call strncmp_
        test eax, eax
        jne near .28
.25:
        lea ecx, [byte esi+014h]
        mov eax, dword [byte ebp+0Ch]
        mov edx, ecx
        call NetFreeSlot
        lea edi, [byte esi+014h]
        mov esi, dword [dword esp+0C8h]
        mov ebx, eax
        movsd
        movsd
        movsd
        movsd
        movsd
        mov dword [dword esp+0B4h], eax
        cmp dword [dword ebp+0A8h], byte 0
        je short .26
        push byte 0
        lea eax, [byte ebx+01h]
        push eax
        push ecx
        push ebp
        call dword [dword ebp+0A8h]
        add esp, byte 10h
        test eax, eax
        je short .27
.26:
        push byte 4
        push byte 1
        lea eax, [byte esp+0Ch]
        push eax
        call StoreBigEndian
        add esp, byte 0Ch
        push byte 4
        mov ecx, dword [dword esp+0B8h]
        push ecx
        jmp short .31
.27:
        mov edx, 1
        mov cl, bl
        mov eax, dword [byte ebp+0Ch]
        shl edx, cl
        mov ebx, dword [byte eax+04Ch]
        not edx
        push byte 4
        and ebx, edx
        push byte 0FFFFFFFDh
        mov dword [byte eax+04Ch], ebx
        lea eax, [byte esp+0Ch]
        jmp short .32
.28:
        push byte 4
        push byte 0FFFFFFFFh
        lea eax, [byte esp+0Ch]
        jmp short .32
.29:
        push byte 4
        push byte 0FFFFFFFEh
        lea eax, [byte esp+0Ch]
        jmp short .32
.30:
        push byte 4
        push byte 1
        lea eax, [byte esp+0Ch]
        push eax
        call StoreBigEndian
        mov eax, dword [byte ebp+0Ch]
        mov edx, ebx
        add eax, 94h
        sub edx, eax
        mov ebx, 64h
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        add esp, byte 0Ch
        push byte 4
        push eax
.31:
        lea eax, [byte esp+010h]
.32:
        push eax
        call StoreBigEndian
        add esp, byte 0Ch
        mov edi, dword [dword esp+0BCh]
        mov ecx, esp
        mov ebx, dword [dword esp+0B8h]
        mov esi, dword [byte ebp+08h]
        push edi
        mov edx, dword [dword esp+0CCh]
        mov eax, dword [byte ebp+010h]
        call dword [byte esi+054h]
        add esp, 0CCh
        pop ebp
        pop edi
        pop esi
        ret 4
.33:
        lea eax, [byte ebp+014h]
        push eax
        push edx
        push ebp
        call NetPeerSend
        add esp, byte 0Ch
        test eax, eax
        je near .41
        mov ecx, 4
        mov eax, esi
        mov eax, dword [eax]
        bswap eax
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        cmp eax, dword [edi]
        jne near .41
        mov ecx, 4
        mov eax, dword [dword esp+0C0h]
        mov eax, dword [eax]
        bswap eax
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        mov dword [byte edi+04h], eax
        mov esi, dword [byte edi+04h]
        mov dword [edi], 0
        cmp esi, byte 1
        jne near .41
        mov eax, dword [NetMaxPeers]
        mov dword [dword ebp+098h], eax
        mov eax, dword [str_D_NetHandleMessage]
        mov dword [dword ebp+09Ch], eax
        add esp, 0CCh
        pop ebp
        pop edi
        pop esi
        ret 4
.34:
        cmp dword [dword ebp+0ACh], byte 0
        je near .41
        push edx
        push ebp
        call dword [dword ebp+0ACh]
        add esp, byte 8
        add esp, 0CCh
        pop ebp
        pop edi
        pop esi
        ret 4
.35:
        mov eax, dword [byte ebp+0Ch]
        test eax, eax
        je short .36
        call NetFindPeer
        add esp, 0CCh
        pop ebp
        pop edi
        pop esi
        ret 4
.36:
        cmp dword [dword ebp+098h], byte 0
        je near .41
        cmp dword [dword ebp+09Ch], byte 0
        je near .41
        lea eax, [byte ebp+014h]
        push eax
        mov ecx, dword [dword esp+0CCh]
        push ecx
        push ebp
        call NetPeerSend
        add esp, byte 0Ch
        test eax, eax
        je near .41
        mov ebx, 0EA61636Bh
        push byte 0
        mov eax, dword [NetMaxPeers]
        lea edx, [byte ebp+014h]
        mov esi, dword [byte ebp+08h]
        mov dword [dword ebp+098h], eax
        xor ecx, ecx
        mov eax, dword [byte ebp+010h]
        call dword [byte esi+054h]
        add esp, 0CCh
        pop ebp
        pop edi
        pop esi
        ret 4
.37:
        mov ebx, dword [byte ebp+0Ch]
        test ebx, ebx
        je short .38
        mov eax, ebx
        call NetFindPeer
        add esp, 0CCh
        pop ebp
        pop edi
        pop esi
        ret 4
.38:
        lea eax, [byte ebp+014h]
        push eax
        push edx
        push ebp
        call NetPeerSend
        add esp, byte 0Ch
        test eax, eax
        je near .41
        cmp dword [dword ebp+09Ch], byte 0
        je near .41
        mov eax, dword [str_D_NetHandleMessage]
        mov dword [dword ebp+09Ch], eax
        add esp, 0CCh
        pop ebp
        pop edi
        pop esi
        ret 4
.39:
        mov edi, dword [byte ebp+0Ch]
        test edi, edi
        je short .40
        mov edx, dword [dword esp+0C8h]
        mov eax, edi
        call NetFindPeer
        mov ebx, eax
        test eax, eax
        je short .41
        mov esi, dword [byte ebp+0Ch]
        lea edx, [dword esi+094h]
        sub eax, edx
        mov edx, eax
        mov ecx, 64h
        sar edx, 1Fh
        idiv ecx
        mov cl, al
        mov eax, 1
        shl eax, cl
        mov ebp, dword [byte esi+04Ch]
        not eax
        and ebp, eax
        mov dword [byte esi+04Ch], ebp
        mov dword [byte ebx+05Ch], 0
        add esp, 0CCh
        pop ebp
        pop edi
        pop esi
        ret 4
.40:
        mov dword [dword ebp+09Ch], edi
        mov dword [dword ebp+098h], edi
.41:
        add esp, 0CCh
        pop ebp
        pop edi
        pop esi
        ret 4
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; NetPollMessages                                11D118  97 PC, low confidence
; Polls the network for messages
;-----------------------------------------------------------------------------
NetPollMessages:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 2Ch
        mov eax, dword [byte esp+040h]
        mov edx, dword [byte eax+04h]
        mov dword [byte esp+024h], eax
        test edx, edx
        jne near .8
        cmp dword [dword eax+0A4h], byte 0
        jne short .2
        mov ecx, 6
        mov edi, esp
        db 0BEh                                 ; insn: mov esi,NetPollMsgBlank
        dd NetPollMsgBlank
        mov edx, dword [dword eax+094h]
        rep movsd
        mov dword [byte esp+0Ch], eax
        test edx, edx
        jne short .1
        mov edx, esp
.1:
        mov eax, dword [byte esp+024h]
        call NetQueueMessage
        mov eax, dword [byte esp+024h]
        mov ecx, dword [dword eax+098h]
        test ecx, ecx
        je short .2
        cmp dword [byte eax+0Ch], byte 0
        jne short .2
        lea edi, [byte ecx-01h]
        mov dword [dword eax+098h], edi
.2:
        mov eax, dword [byte esp+024h]
        mov ebp, dword [byte eax+0Ch]
        test ebp, ebp
        je near .8
        mov eax, dword [byte ebp+08h]
        mov esi, ebp
        test eax, eax
        jne near .8
        cmp dword [byte ebp+04Ch], byte 0
        je near .8
        mov dword [byte esp+020h], eax
        mov eax, dword [byte esp+024h]
        mov ecx, 0EA61636Bh
        mov edi, dword [dword eax+09Ch]
        mov dword [byte esp+018h], ecx
        cmp edi, byte 2
        jge short .3
        mov edx, dword [byte esp+024h]
        mov eax, dword [str_D_NetHandleMessage]
        mov dword [dword edx+09Ch], eax
        mov dword [byte esp+020h], 1
        jmp short .4
.3:
        lea ebp, [byte edi-01h]
        mov dword [dword eax+09Ch], ebp
.4:
        xor edx, edx
        mov ebx, dword [dword esi+090h]
        mov dword [byte esp+028h], edx
        test ebx, ebx
        jbe near .8
        lea eax, [dword esi+094h]
        mov dword [byte esp+01Ch], eax
        mov edi, esi
.5:
        mov cl, byte [byte esp+028h]
        mov edx, 1
        mov eax, dword [byte esi+04Ch]
        shl edx, cl
        test edx, eax
        je short .7
        imul ebx, dword [byte esp+028h], byte 64h
        mov eax, dword [dword edi+0F0h]
        lea ebp, [byte eax-01h]
        mov dword [dword edi+0F0h], ebp
        test eax, eax
        jne short .6
        not edx
        and dword [byte esi+04Ch], edx
        jmp short .7
.6:
        cmp dword [byte esp+020h], byte 0
        je short .7
        mov ebp, dword [byte esp+024h]
        push byte 0
        mov edx, dword [byte esp+020h]
        mov eax, dword [byte esp+028h]
        xor ecx, ecx
        mov ebp, dword [byte ebp+08h]
        mov eax, dword [byte eax+010h]
        add edx, ebx
        mov ebx, dword [byte esp+01Ch]
        call dword [byte ebp+054h]
.7:
        mov ecx, dword [byte esp+028h]
        add edi, byte 64h
        inc ecx
        mov ebp, dword [dword esi+090h]
        mov dword [byte esp+028h], ecx
        cmp ecx, ebp
        jb short .5
.8:
        mov eax, 1
        add esp, byte 2Ch
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
NetPollMessages_168:
        push ecx
        push edx
        push byte 1
        db 068h                                 ; insn: push NetPollMessages
        dd NetPollMessages
        push NetMessageBuf
        call QueuePostBuffer
        add esp, byte 0Ch
        pop edx
        pop ecx
        ret
        db 08Dh,040h,00h
NetPollMessages_184:
        push ecx
        push edx
.9:
        push NetMessageBuf
        call QueueCount
        add esp, byte 4
        test eax, eax
        je short .10
        mov edx, dword [NetPollState]
        push edx
        call NetCloseSession
        add esp, byte 4
        jmp short .9
.10:
        push NetMessageBuf
        call QueueNoOp
        add esp, byte 4
        pop edx
        pop ecx
        ret
;-----------------------------------------------------------------------------
; NetCopyName                                    11D2D0  97 PC, low confidence
; Copies a network name
;-----------------------------------------------------------------------------
NetCopyName:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 8
        cmp dword [byte esp+028h], byte 20h
        ja short .3
        mov ebx, dword [NetSessionName]
        xor esi, esi
        test ebx, ebx
        jle short .3
        xor ebx, ebx
.1:
        mov ecx, dword [dword ebx+NetLocalName]
        mov edx, esp
        lea eax, [byte esp+04h]
        call dword [byte ecx+014h]
        test eax, eax
        je short .2
        mov edi, dword [esp]
        push edi
        mov ebp, dword [byte esp+08h]
        mov eax, dword [dword ebx+NetLocalName]
        push ebp
        mov edx, dword [eax]
        push edx
        add eax, byte 4
        push eax
        call dword [byte esp+02Ch]
        add esp, byte 10h
        test eax, eax
        je short .5
.2:
        mov ecx, dword [NetSessionName]
        inc esi
        add ebx, byte 4
        cmp esi, ecx
        jl short .1
.3:
        cmp dword [NetNameFn], byte 0
        je short .4
        mov ecx, dword [byte esp+028h]
        push ecx
        mov esi, dword [byte esp+028h]
        push esi
        mov edi, dword [byte esp+028h]
        push edi
        mov ebp, dword [byte esp+028h]
        push ebp
        call dword [NetNameFn]
        add esp, byte 10h
        jmp short .5
.4:
        mov eax, 1
.5:
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; NetOpenSession                                 11D364  97 PC, low confidence
; Opens a network session
;-----------------------------------------------------------------------------
NetOpenSession:
        push ebx
        push esi
        push edi
        push ebp
        mov edi, dword [byte esp+014h]
        mov esi, dword [byte esp+01Ch]
        mov edx, dword [NetSessionOpen]
        xor ebp, ebp
        test edx, edx
        jne short .2
        push ebp
        push ebp
        push NetMessageBuf
        call QueueInit
        add esp, byte 0Ch
        db 068h                                 ; insn: push NetPollMessages_184
        dd NetPollMessages_184
        call AddExitHandler
        mov ebx, dword [NetSessionHandle]
        add esp, byte 4
        test ebx, ebx
        jne short .1
        mov edx, dword [str_D_UpdateFrameRate]
        add edx, byte 9
        mov ebx, 0Ah
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        mov dword [NetSessionHandle], eax
.1:
        mov dword [NetSessionOpen], 1
.2:
        push edi
        push NetMessageBuf
        call QueueFind
        add esp, byte 8
        cmp eax, byte 0FFFFFFFFh
        je short .3
        push edi
        call NetCloseSession
        add esp, byte 4
.3:
        push dword 0C0h
        push edi
        call ZeroMem
        mov eax, dword [NetOpenFn]
        add esp, byte 8
        test eax, eax
        je short .4
        mov edx, dword [byte esp+024h]
        push edx
        mov ebx, dword [byte esp+024h]
        push ebx
        push esi
        mov ecx, dword [byte esp+024h]
        push ecx
        push edi
        call dword [NetOpenFn]
        add esp, byte 14h
        test eax, eax
        je short .4
        mov ebp, 1
        jmp near .8
.4:
        mov eax, dword [NetSessionName]
        xor ebx, ebx
        test eax, eax
        jle short .6
        xor ecx, ecx
.5:
        mov eax, dword [dword ecx+NetLocalName]
        mov edx, esi
        add eax, byte 4
        call SameNetAddress
        test eax, eax
        jne short .6
        mov edx, dword [NetSessionName]
        inc ebx
        add ecx, byte 4
        cmp ebx, edx
        jl short .5
.6:
        cmp ebx, dword [NetSessionName]
        jge short .8
        mov eax, dword [nosplit ebx*4+NetLocalName]
        mov dword [byte edi+08h], eax
        call dword [byte eax+018h]
        mov ebp, eax
        test eax, eax
        je short .8
        mov ebx, dword [byte edi+08h]
        xor edx, edx
        xor eax, eax
        call dword [byte ebx+020h]
        mov dword [byte edi+010h], eax
        test eax, eax
        je short .7
        mov ebx, dword [byte edi+08h]
        lea edx, [byte edi+028h]
        call dword [byte ebx+044h]
        mov dword [dword edi+0A0h], 1
        jmp short .8
.7:
        mov eax, dword [byte edi+08h]
        xor ebp, ebp
        call dword [byte eax+01Ch]
.8:
        test ebp, ebp
        je short .10
        push byte 10h
        lea eax, [dword edi+084h]
        push eax
        mov eax, dword [byte esp+020h]
        push eax
        mov ebx, 34h
        call bcopy
        add esp, byte 0Ch
        lea eax, [byte edi+03Ch]
        mov edx, dword [byte esp+020h]
        call strncpy_
        mov ebx, 14h
        mov edx, dword [byte esp+024h]
        lea eax, [byte edi+070h]
        call strncpy_
        push NetMessageBuf
        call QueueCount
        add esp, byte 4
        test eax, eax
        jne short .9
        db 068h                                 ; insn: push NetPollMessages_168
        dd NetPollMessages_168
        call addtimer
        add esp, byte 4
.9:
        push edi
        push NetMessageBuf
        call QueuePeek
        add esp, byte 8
.10:
        mov eax, ebp
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
;-----------------------------------------------------------------------------
; NetCloseSession                                11D508  97 PC, low confidence
; Closes a network session
;-----------------------------------------------------------------------------
NetCloseSession:
        push ebx
        push esi
        push edi
        push ebp
        mov ebx, dword [byte esp+014h]
        push ebx
        push NetMessageBuf
        xor esi, esi
        call QueueFind
        add esp, byte 8
        cmp eax, byte 0FFFFFFFFh
        je near .7
        cmp dword [byte ebx+04h], byte 0
        je short .1
        push ebx
        call dword [NetCloseFn]
        add esp, byte 4
        jmp short .6
.1:
        cmp dword [byte ebx+0Ch], byte 0
        jne short .2
        cmp dword [dword ebx+09Ch], byte 0
        je short .3
.2:
        push ebx
        call NetDisconnectPeer
        add esp, byte 4
.3:
        mov edi, dword [dword ebx+0A4h]
        mov dword [dword ebx+0A0h], 0
        test edi, edi
        je short .5
        xor esi, esi
.4:
        push esi
        call RunIdleHandlers
        mov ebp, dword [dword ebx+0A4h]
        add esp, byte 4
        cmp esi, ebp
        jne short .4
.5:
        mov esi, dword [byte ebx+08h]
        mov eax, dword [byte ebx+010h]
        call dword [byte esi+024h]
        mov eax, dword [byte ebx+08h]
        call dword [byte eax+01Ch]
.6:
        mov esi, eax
        push ebx
        push NetMessageBuf
        call QueueFreeAll
        add esp, byte 8
        push NetMessageBuf
        call QueueCount
        add esp, byte 4
        test eax, eax
        jne short .7
        db 068h                                 ; insn: push NetPollMessages_168
        dd NetPollMessages_168
        call RemoveTimerCallback
        add esp, byte 4
.7:
        mov eax, esi
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
;-----------------------------------------------------------------------------
; NetAnnounce                                    11D5C0  97 PC, low confidence
; Announces this game on the network
;-----------------------------------------------------------------------------
NetAnnounce:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 48h
        mov ebx, dword [byte esp+05Ch]
        mov edx, dword [byte ebx+04h]
        xor ebp, ebp
        test edx, edx
        je short .1
        mov edi, dword [byte esp+064h]
        push edi
        mov ebp, dword [byte esp+064h]
        push ebp
        push ebx
        call dword [NetAnnounceFn]
        add esp, byte 0Ch
        jmp near .6
.1:
        mov ecx, 6
        lea edi, [byte esp+030h]
        db 0BEh                                 ; insn: mov esi,NetAnnounceMsgBlank
        dd NetAnnounceMsgBlank
        mov edx, esp
        lea eax, [dword ebx+084h]
        rep movsd
        call NetLogf
        mov eax, dword [byte esp+060h]
        mov dword [byte esp+03Ch], ebx
        mov dword [byte esp+030h], ebp
        mov dword [byte esp+040h], eax
        lea eax, [byte esp+030h]
        mov dword [dword ebx+094h], eax
        mov eax, dword [TimerTicks]
        mov esi, dword [byte esp+064h]
        add eax, esi
        mov dword [NetLastTime], eax
        xor esi, esi
.2:
        test ebp, ebp
        jne short .3
        mov ebp, dword [byte ebx+08h]
        mov edx, esp
        mov eax, dword [byte ebx+010h]
        call dword [byte ebp+034h]
        mov ebp, eax
.3:
        push byte 1
        call WaitTicks
        add esp, byte 4
        mov eax, dword [TimerTicks]
        sub eax, dword [NetLastTime]
        test eax, eax
        setge al
        and eax, 0FFh
        jne short .4
        cmp esi, dword [byte esp+040h]
        jne short .2
.4:
        test ebp, ebp
        je short .5
        mov edx, dword [byte ebx+08h]
        mov eax, dword [byte ebx+010h]
        call dword [byte edx+038h]
.5:
        mov eax, ebp
        mov dword [dword ebx+094h], 0
.6:
        add esp, byte 48h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; NetJoinGame                                    11D690  97 PC, low confidence
; Joins a network game
;-----------------------------------------------------------------------------
NetJoinGame:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, 88h
        mov ebp, dword [dword esp+09Ch]
        mov ebx, dword [dword esp+0A0h]
        cmp dword [byte ebp+04h], byte 0
        je short .1
        mov edi, dword [dword esp+0A4h]
        push edi
        push ebx
        push ebp
        call dword [NetJoinFn]
        add esp, byte 0Ch
        jmp near .6
.1:
        mov ecx, 6
        lea edi, [byte esp+070h]
        db 0BEh                                 ; insn: mov esi,NetJoinMsgBlank
        dd NetJoinMsgBlank
        rep movsd
        cmp dword [dword ebp+098h], byte 0
        je short .3
        push ebx
        lea eax, [byte ebp+014h]
        push eax
        push ebp
        call NetPeerSend
        add esp, byte 0Ch
        test eax, eax
        je short .2
        mov eax, 1
        add esp, 88h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.2:
        push ebp
        call NetDisconnectPeer
        add esp, byte 4
        mov dword [dword ebp+098h], 0
.3:
        mov ecx, 17h
        lea edi, [byte esp+014h]
        lea esi, [byte ebp+028h]
        rep movsd
        mov esi, ebx
        lea edi, [byte ebp+014h]
        movsd
        movsd
        movsd
        movsd
        movsd
        mov esi, dword [dword esp+0A4h]
        test esi, esi
        je short .4
        mov ebx, 10h
        lea eax, [byte esp+04h]
        mov edx, esi
        call strncpy_
        jmp short .5
.4:
        mov eax, dword [byte ebp+0Ch]
        mov byte [byte eax+03Ch], 0
.5:
        mov eax, dword [str_D_UpdateFrameRate]
        add eax, eax
        push eax
        lea ecx, [byte esp+04h]
        mov ebx, 0EA616464h
        push byte 70h
        lea edx, [byte esp+078h]
        mov eax, ebp
        call NetSendWait
        mov eax, dword [byte esp+074h]
.6:
        add esp, 88h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; NetLeaveGame                                   11D780  97 PC, low confidence
; Leaves a network game
;-----------------------------------------------------------------------------
NetLeaveGame:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov ebp, dword [byte esp+018h]
        mov esi, dword [byte esp+01Ch]
        xor edx, edx
        mov ebx, dword [byte ebp+04h]
        mov dword [esp], edx
        test ebx, ebx
        je short .1
        mov edi, dword [byte esp+024h]
        push edi
        mov eax, dword [byte esp+024h]
        push eax
        push esi
        push ebp
        call dword [NetLeaveFn]
        add esp, byte 10h
        jmp near .8
.1:
        cmp dword [byte esi+040h], byte 0
        jne short .2
        mov dword [byte esi+040h], 20h
.2:
        cmp dword [dword ebp+098h], byte 0
        je short .3
        push ebp
        call NetDisconnectPeer
        add esp, byte 4
        mov dword [dword ebp+098h], 0
.3:
        mov edx, dword [byte esi+040h]
        mov eax, dword [str_Punct_NetLeaveGame]
        sub edx, byte 2
        push eax
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        shl eax, 3
        add eax, edx
        shl eax, 2
        add eax, 0F8h
        push eax
        push str_Netserv
        call AllocMemData
        add esp, byte 0Ch
        mov dword [byte ebp+0Ch], eax
        test eax, eax
        je near .7
        mov dword [byte eax+04h], ebp
        mov edi, dword [byte ebp+0Ch]
        mov ecx, 11h
        lea edi, [byte edi+050h]
        rep movsd
        mov eax, dword [byte ebp+0Ch]
        mov dword [byte eax+08h], 0
        mov eax, dword [byte ebp+0Ch]
        mov dword [byte eax+04Ch], 0
        mov eax, dword [NetMaxPeers]
        mov dword [dword ebp+098h], eax
        mov eax, dword [byte esp+024h]
        lea edi, [byte ebp+014h]
        mov dword [dword ebp+0A8h], eax
        mov eax, dword [str_D_NetHandleMessage]
        lea esi, [byte ebp+028h]
        mov dword [dword ebp+09Ch], eax
        mov ebx, dword [byte esp+020h]
        movsd
        movsd
        movsd
        movsd
        movsd
        test ebx, ebx
        je short .4
        mov ebx, 10h
        mov eax, dword [byte ebp+0Ch]
        mov edx, dword [byte esp+020h]
        add eax, byte 3Ch
        call strncpy_
        jmp short .5
.4:
        mov eax, dword [byte ebp+0Ch]
        mov byte [byte eax+03Ch], 0
.5:
        mov edx, dword [byte ebp+0Ch]
        lea eax, [dword ebp+084h]
        add edx, byte 0Ch
        call NetLogf
        mov esi, dword [byte ebp+08h]
        mov edx, dword [byte ebp+0Ch]
        mov eax, dword [byte ebp+010h]
        add edx, byte 0Ch
        call dword [byte esi+02Ch]
        test eax, eax
        je short .6
        mov dword [esp], 1
        jmp short .7
.6:
        mov ecx, dword [byte ebp+0Ch]
        push ecx
        call FreeMemBlock
        add esp, byte 4
        mov dword [byte ebp+0Ch], 0
.7:
        mov eax, dword [esp]
.8:
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
;-----------------------------------------------------------------------------
; NetListGames                                   11D8D8  97 PC, low confidence
; Lists the network games
;-----------------------------------------------------------------------------
NetListGames:
        push ebx
        push esi
        push ebp
        mov ebx, dword [byte esp+010h]
        cmp dword [byte ebx+04h], byte 0
        je short .1
        mov eax, dword [byte esp+014h]
        push eax
        push ebx
        call dword [NetListNextFn]
        add esp, byte 8
        pop ebp
        pop esi
        pop ebx
        ret
.1:
        mov ecx, dword [byte ebx+0Ch]
        test ecx, ecx
        je short .4
        mov esi, dword [byte ecx+08h]
        mov edx, ecx
        test esi, esi
        jne short .2
        mov ecx, dword [byte ebx+08h]
        add edx, byte 0Ch
        mov eax, dword [byte ebx+010h]
        call dword [byte ecx+030h]
        mov eax, dword [byte ebx+0Ch]
        mov byte [byte eax+0Ch], 0
        mov eax, dword [byte ebx+0Ch]
        mov dword [byte eax+08h], 1
.2:
        cmp dword [byte esp+014h], byte 0
        je short .3
        mov ebp, dword [byte ebx+0Ch]
        push ebp
        call FreeMemBlock
        add esp, byte 4
        mov dword [byte ebx+0Ch], 0
.3:
        mov eax, 1
        pop ebp
        pop esi
        pop ebx
        ret
.4:
        xor eax, eax
        pop ebp
        pop esi
        pop ebx
        ret
        db 08Bh,0C0h
        push ebx
        push esi
        push edi
        mov edi, dword [NetMaxPeers]
        mov esi, dword [byte esp+010h]
        cmp dword [byte esi+04h], byte 0
        je short .5
        push esi
        call dword [NetListStartFn]
        add esp, byte 4
        jmp near .10
.5:
        mov ebx, dword [byte esi+0Ch]
        test ebx, ebx
        je near .9
        mov ecx, dword [byte ebx+08h]
        mov eax, ebx
        test ecx, ecx
        je near .9
        mov dword [byte ebx+08h], 1
        mov edx, dword [byte esi+0Ch]
        lea eax, [dword esi+084h]
        add edx, byte 0Ch
        call NetLogf
        mov ebx, dword [byte esi+08h]
        mov edx, dword [byte esi+0Ch]
        mov eax, dword [byte esi+010h]
        add edx, byte 0Ch
        call dword [byte ebx+02Ch]
        test eax, eax
        je short .8
        mov edi, dword [NetMaxPeers]
        mov dword [dword esi+09Ch], 1
        xor eax, eax
        xor edx, edx
        jmp short .7
.6:
        add edx, byte 64h
        inc eax
        mov dword [dword edx+ebx+08Ch], edi
.7:
        mov ebx, dword [byte esi+0Ch]
        cmp eax, dword [dword ebx+090h]
        jb short .6
        mov eax, 1
        mov dword [NetMaxPeers], edi
        mov edi, dword [NetMaxPeers]
        pop edi
        pop esi
        pop ebx
        ret
.8:
        mov eax, dword [byte esi+0Ch]
        mov dword [byte eax+08h], 0
.9:
        xor eax, eax
.10:
        mov edi, dword [NetMaxPeers]
        pop edi
        pop esi
        pop ebx
        ret
;-----------------------------------------------------------------------------
; NetDisconnectPeer                              11DA0C  97 PC, low confidence
; Disconnects a network peer
;-----------------------------------------------------------------------------
NetDisconnectPeer:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 8
        mov esi, dword [byte esp+01Ch]
        push esi
        push NetMessageBuf
        call QueueFind
        add esp, byte 8
        cmp eax, byte 0FFFFFFFFh
        je near .9
        mov edx, dword [byte esi+04h]
        test edx, edx
        je short .1
        push esi
        call dword [NetPeerDropFn]
        add esp, byte 4
        jmp near .10
.1:
        cmp dword [dword esi+098h], byte 0
        je near .9
        mov ecx, dword [byte esi+0Ch]
        test ecx, ecx
        je near .7
        mov edi, dword [byte ecx+08h]
        mov edx, ecx
        test edi, edi
        je short .4
        jmp near .6
.2:
        mov cl, byte [byte esp+04h]
        mov edx, 1
        shl edx, cl
        mov dword [esp], edx
        mov ebx, dword [esp]
        test dword [byte eax+04Ch], ebx
        je short .3
        push byte 0
        mov ebx, 0EA627965h
        add eax, 94h
        mov ebp, dword [byte esi+08h]
        lea edx, [eax+edi]
        xor ecx, ecx
        mov eax, dword [byte esi+010h]
        call dword [byte ebp+054h]
        mov edx, dword [esp]
        mov eax, dword [byte esi+0Ch]
        not edx
        and dword [byte eax+04Ch], edx
.3:
        mov ebp, dword [byte esp+04h]
        inc ebp
        add edi, byte 64h
        mov dword [byte esp+04h], ebp
        cmp ebp, byte 1Fh
        jl short .5
        jmp short .6
.4:
        lea edx, [byte ecx+0Ch]
        mov edi, dword [byte esi+08h]
        mov eax, dword [byte esi+010h]
        xor ebp, ebp
        call dword [byte edi+030h]
        mov eax, dword [byte esi+0Ch]
        mov dword [byte esp+04h], ebp
        xor edi, edi
        mov byte [byte eax+0Ch], 0
.5:
        mov eax, dword [byte esi+0Ch]
        cmp dword [byte eax+04Ch], byte 0
        jne short .2
.6:
        mov edx, dword [byte esi+0Ch]
        push edx
        call FreeMemBlock
        add esp, byte 4
        mov dword [byte esi+0Ch], 0
        jmp short .8
.7:
        mov ebx, 0EA627965h
        push edx
        mov edi, dword [byte esi+08h]
        mov eax, dword [byte esi+010h]
        lea edx, [byte esi+014h]
        call dword [byte edi+054h]
.8:
        mov dword [dword esi+09Ch], 0
        mov dword [dword esi+098h], 0
.9:
        mov eax, 1
.10:
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        push ebx
        push esi
        push edi
        push ebp
        sub esp, 90h
        mov ebp, dword [dword esp+0A4h]
        mov eax, dword [dword esp+0A8h]
        xor edx, edx
        mov ebx, dword [byte ebp+04h]
        mov dword [dword esp+088h], edx
        test ebx, ebx
        je short .11
        mov edi, dword [dword esp+0ACh]
        push edi
        push eax
        push ebp
        call dword [NetDropFn]
        add esp, byte 0Ch
        mov dword [dword esp+088h], eax
        jmp near .22
.11:
        test eax, eax
        jne short .12
        cmp dword [dword ebp+098h], byte 0
        je short .12
        lea eax, [byte ebp+014h]
        jmp short .15
.12:
        test eax, eax
        je short .13
        cmp dword [dword ebp+098h], byte 0
        je short .14
.13:
        xor eax, eax
        jmp near .23
.14:
        mov esi, eax
        lea edi, [byte ebp+014h]
        movsd
        movsd
        movsd
        movsd
        movsd
.15:
        cmp dword [byte ebp+0Ch], byte 0
        je near .18
        push eax
        lea eax, [byte ebp+014h]
        push eax
        push ebp
        call NetPeerSend
        add esp, byte 0Ch
        test eax, eax
        je near .18
        push byte 1
        push byte 0
        lea eax, [byte ebp+028h]
        push eax
        push ebp
        call dword [dword esp+0BCh]
        add esp, byte 10h
        test eax, eax
        je near .22
        mov esi, 1
        xor ebx, ebx
        mov dword [dword esp+088h], esi
        xor esi, esi
.16:
        mov edx, 1
        mov cl, bl
        mov eax, dword [byte ebp+0Ch]
        shl edx, cl
        test dword [byte eax+04Ch], edx
        je short .17
        push byte 0
        lea edx, [byte ebx+01h]
        add eax, 94h
        push edx
        add eax, esi
        push eax
        push ebp
        call dword [dword esp+0BCh]
        add esp, byte 10h
        test eax, eax
        je near .22
        inc dword [dword esp+088h]
.17:
        inc ebx
        add esi, byte 64h
        cmp ebx, byte 1Fh
        jl short .16
        mov eax, dword [dword esp+088h]
        add esp, 90h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.18:
        mov ecx, 6
        lea edi, [byte esp+070h]
        mov ebx, 0EA726571h
        mov eax, dword [str_D_UpdateFrameRate]
        db 0BEh                                 ; insn: mov esi,NetDisconnectMsgBlank
        dd NetDisconnectMsgBlank
        add eax, eax
        lea edx, [byte esp+070h]
        push eax
        rep movsd
        push byte 4Ch
        lea ecx, [byte esp+08h]
        mov eax, ebp
        call NetSendWait
        cmp dword [byte esp+074h], byte 0
        je near .22
        push byte 4
        mov eax, dword [dword esp+0B0h]
        push byte 0FFFFFFFFh
        mov dword [dword esp+08Ch], eax
        lea eax, [byte esp+0Ch]
        mov edx, 1
        push eax
        mov esi, dword [dword esp+084h]
        mov dword [dword esp+080h], edx
        call StoreBigEndian
        mov eax, dword [str_D_UpdateFrameRate]
        add esp, byte 0Ch
        add eax, eax
        push eax
        mov ebx, 0EA676574h
        lea ecx, [byte esp+04h]
        push byte 8
        lea edx, [byte esp+078h]
        mov eax, ebp
        call NetSendWait
        cmp dword [byte esp+074h], byte 0
        setne al
        and eax, 0FFh
        xor ecx, ecx
        mov dword [dword esp+088h], eax
        mov dword [dword esp+08Ch], ecx
        jmp short .21
.19:
        mov cl, byte [dword esp+08Ch]
        mov eax, 1
        shl eax, cl
        test esi, eax
        je short .20
        push byte 4
        mov edi, dword [dword esp+090h]
        push edi
        lea eax, [byte esp+0Ch]
        push eax
        call StoreBigEndian
        mov eax, dword [str_D_UpdateFrameRate]
        add esp, byte 0Ch
        add eax, eax
        push eax
        mov ebx, 0EA676574h
        lea ecx, [byte esp+04h]
        push byte 8
        lea edx, [byte esp+078h]
        mov eax, ebp
        call NetSendWait
        cmp dword [byte esp+074h], byte 0
        setne al
        and eax, 0FFh
        mov dword [dword esp+088h], eax
.20:
        mov eax, dword [dword esp+08Ch]
        inc eax
        mov dword [dword esp+08Ch], eax
        cmp eax, byte 20h
        jge short .22
.21:
        cmp dword [dword esp+084h], byte 0
        je short .22
        cmp dword [dword esp+088h], byte 0
        jne near .19
.22:
        mov eax, dword [dword esp+088h]
.23:
        add esp, 90h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 090h
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov esi, dword [byte esp+018h]
        mov edx, dword [byte esp+01Ch]
        mov ebx, dword [byte esi+04h]
        test ebx, ebx
        je short .24
        push edx
        push esi
        call dword [NetDisconnectFn]
        add esp, byte 8
        jmp short .26
.24:
        mov ecx, dword [byte esi+0Ch]
        test ecx, ecx
        je short .25
        mov eax, ecx
        call NetFindPeer
        mov edi, eax
        test eax, eax
        je short .25
        mov edx, dword [byte esi+0Ch]
        add edx, 94h
        sub eax, edx
        mov edx, eax
        mov ebp, 64h
        sar edx, 1Fh
        idiv ebp
        push ebx
        xor ecx, ecx
        mov ebx, 0EA6F7574h
        mov dword [byte esp+04h], eax
        mov ebp, dword [byte esi+08h]
        mov edx, edi
        mov eax, dword [byte esi+010h]
        call dword [byte ebp+054h]
        mov cl, byte [esp]
        mov edx, 1
        mov eax, dword [byte esi+0Ch]
        shl edx, cl
        mov esi, dword [byte eax+04Ch]
        not edx
        and esi, edx
        mov dword [byte eax+04Ch], esi
.25:
        xor eax, eax
.26:
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; OpenNetPacketLink                              11DE04  97 PC, low confidence
; Opens a packet link over the network
;-----------------------------------------------------------------------------
OpenNetPacketLink:
        push ebx
        push esi
        push edi
        push ebp
        mov eax, dword [byte esp+014h]
        test eax, eax
        je short .1
        mov edx, dword [byte eax+028h]
        cmp dword [byte edx+04h], byte 0
        je short .1
        mov edx, dword [byte esp+024h]
        push edx
        mov ebx, dword [byte esp+024h]
        push ebx
        mov ecx, dword [byte esp+024h]
        push ecx
        mov esi, dword [byte esp+024h]
        push esi
        push eax
        call dword [NetLinkOpenFn]
        add esp, byte 14h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.1:
        mov ecx, dword [byte esp+024h]
        push ecx
        mov esi, dword [byte esp+024h]
        push esi
        mov edi, dword [byte esp+024h]
        push edi
        mov ebp, dword [byte esp+024h]
        push ebp
        push NetLinkFuncs
        push eax
        call OpenPacketLink
        add esp, byte 18h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; NetPeerSend                                    11DE64  97 PC, low confidence
; Sends to a network peer
;-----------------------------------------------------------------------------
NetPeerSend:
        push ebx
        mov eax, dword [byte esp+08h]
        mov edx, dword [byte esp+0Ch]
        mov ebx, dword [byte esp+010h]
        cmp dword [byte eax+04h], byte 0
        je short .1
        push ebx
        push edx
        push eax
        call dword [NetPeerSendFn]
        add esp, byte 0Ch
        pop ebx
        ret
.1:
        mov ecx, dword [byte eax+08h]
        mov eax, dword [byte eax+010h]
        call dword [byte ecx+040h]
        pop ebx
        ret
        push ebx
        push esi
        mov eax, dword [byte esp+0Ch]
        mov esi, dword [byte esp+010h]
        mov ebx, dword [byte esp+014h]
        cmp dword [byte eax+04h], byte 0
        jne short .2
        push ebx
        push esi
        push eax
        call dword [NetSendFn]
        add esp, byte 0Ch
        pop esi
        pop ebx
        ret
.2:
        mov edx, dword [byte eax+08h]
        cmp dword [byte edx+03Ch], byte 0
        je short .3
        mov ecx, edx
        mov eax, dword [byte eax+010h]
        mov edx, esi
        call dword [byte ecx+03Ch]
        pop esi
        pop ebx
        ret
.3:
        xor eax, eax
        pop esi
        pop ebx
        ret
        db 08Bh,0C0h
        mov edx, dword [byte esp+04h]
        mov eax, dword [byte esp+08h]
        mov dword [dword edx+0ACh], eax
        mov eax, 1
        ret
;-----------------------------------------------------------------------------
; NetLinkRead                                    11DEE4  97 PC, low confidence
; Reads from the network link
;-----------------------------------------------------------------------------
NetLinkRead:
        push ebx
        push esi
        push edi
        push ebp
        mov edx, dword [byte esp+014h]
        mov esi, dword [byte edx+028h]
        mov ebx, dword [byte esi+010h]
        mov edi, edx
        test ebx, ebx
        je short .2
        mov eax, dword [byte esi+08h]
        cmp dword [byte eax+048h], byte 0
        je short .1
        mov ebp, eax
        add edx, byte 2Ch
        mov eax, ebx
        call dword [byte ebp+048h]
.1:
        mov ebx, 0EA646174h
        lea edx, [byte edi+02Ch]
        mov ebp, dword [byte esi+08h]
        mov eax, dword [byte esi+010h]
        xor ecx, ecx
        call dword [byte ebp+05Ch]
        pushf
        pop eax
        and eax, 200h
        cli
        inc dword [dword esi+0A4h]
        pushf
        and dword [esp], 0FFFFFDFFh
        or dword [esp], eax
        popf
        mov dword [byte edi+040h], 0FFFFFFFFh
        jmp short .3
.2:
        mov dword [byte edx+040h], ebx
.3:
        mov eax, dword [byte edi+040h]
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
;-----------------------------------------------------------------------------
; NetLinkWrite                                   11DF4C  97 PC, low confidence
; Writes to the network link
;-----------------------------------------------------------------------------
NetLinkWrite:
        push ebx
        push esi
        push edi
        push ebp
        mov esi, dword [byte esp+014h]
        mov edx, dword [byte esi+028h]
        mov ebx, dword [byte edx+010h]
        mov edi, esi
        test ebx, ebx
        je short .1
        cmp dword [dword edx+0A4h], byte 0
        je short .1
        pushf
        pop eax
        and eax, 200h
        cli
        mov ecx, 1
        mov ebp, dword [dword edx+0A4h]
        mov ebx, 0EA646174h
        dec ebp
        add esi, byte 2Ch
        mov dword [dword edx+0A4h], ebp
        pushf
        and dword [esp], 0FFFFFDFFh
        or dword [esp], eax
        popf
        mov ebp, dword [byte edx+08h]
        mov eax, dword [byte edx+010h]
        mov edx, esi
        call dword [byte ebp+05Ch]
.1:
        mov eax, 1
        mov dword [byte edi+040h], 0
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; NetLinkConnected                               11DFB4  97 PC, low confidence
; Returns whether the network link is connected
;-----------------------------------------------------------------------------
NetLinkConnected:
        mov eax, dword [byte esp+04h]
        cmp dword [byte eax+040h], byte 0
        je short .1
        mov eax, dword [byte eax+028h]
        cmp dword [dword eax+0A0h], byte 0
        je short .1
        mov eax, 1
        ret
.1:
        xor eax, eax
        ret
        db 090h
;-----------------------------------------------------------------------------
; NetLinkRxCount                                 11DFD4  97 PC, low confidence
; Returns the bytes waiting on the network link
;-----------------------------------------------------------------------------
NetLinkRxCount:
        mov eax, dword [byte esp+04h]
        mov eax, dword [byte eax+028h]
        mov edx, dword [byte eax+08h]
        mov eax, dword [byte eax+010h]
        call dword [byte edx+04Ch]
        test eax, eax
        je short .1
        mov eax, dword [NetRxCount]
.1:
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; NetLinkTxFree                                  11DFF0  97 PC, low confidence
; Returns the free space on the network link
;-----------------------------------------------------------------------------
NetLinkTxFree:
        mov eax, dword [byte esp+04h]
        mov eax, dword [byte eax+028h]
        mov edx, dword [byte eax+08h]
        mov eax, dword [byte eax+010h]
        call dword [byte edx+050h]
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; NetBroadcast                                   11E004  97 PC, low confidence
; Broadcasts a network message
;-----------------------------------------------------------------------------
NetBroadcast:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 34h
        mov edx, dword [byte esp+048h]
        mov ecx, 6
        mov edi, esp
        db 0BEh                                 ; insn: mov esi,NetBroadcastMsgBlank
        dd NetBroadcastMsgBlank
        mov ebp, edx
        xor ebx, ebx
        rep movsd
        mov dword [byte esp+030h], ebx
        mov eax, dword [byte edx+028h]
        lea edi, [byte edx+02Ch]
        mov dword [byte esp+0Ch], eax
.1:
        push byte 14h
        lea eax, [byte esp+01Ch]
        push eax
        mov ecx, 0EA646174h
        push edi
        lea ebx, [byte esp+038h]
        mov dword [byte esp+038h], ecx
        call bcopy
        add esp, byte 0Ch
        mov eax, dword [byte ebp+028h]
        mov edx, dword [byte esp+050h]
        mov ecx, dword [byte esp+04Ch]
        mov esi, dword [byte eax+08h]
        push edx
        mov eax, dword [byte eax+010h]
        lea edx, [byte esp+01Ch]
        call dword [byte esi+058h]
        mov ebx, dword [byte esp+02Ch]
        mov esi, eax
        test ebx, ebx
        je short .4
        mov eax, dword [byte ebp+028h]
        cmp dword [dword eax+094h], byte 0
        jne short .2
        mov edx, esp
        mov dword [dword eax+094h], edx
.2:
        mov ecx, dword [byte esp+04Ch]
        mov ebx, dword [byte esp+02Ch]
        mov eax, dword [byte ebp+028h]
        push esi
        lea edx, [byte esp+01Ch]
        mov eax, dword [dword eax+094h]
        call NetHandleMessage
        mov eax, dword [byte ebp+028h]
        mov edx, esp
        cmp edx, dword [dword eax+094h]
        jne short .3
        mov dword [dword eax+094h], 0
.3:
        cmp dword [byte esp+02Ch], 0EA646174h
        jne short .7
        push byte 14h
        push edi
        lea eax, [byte esp+020h]
        push eax
        call bcopy
        mov eax, 1
        add esp, byte 0Ch
        mov dword [byte ebp+040h], 1
        jmp short .6
.4:
        mov eax, dword [byte ebp+028h]
        mov ecx, dword [dword eax+0A4h]
        test ecx, ecx
        jne short .5
        mov ebx, 0EA646174h
        mov esi, dword [byte eax+08h]
        xor edx, edx
        mov eax, dword [byte eax+010h]
        call dword [byte esi+05Ch]
.5:
        mov eax, 1
        xor esi, esi
.6:
        mov dword [byte esp+030h], eax
.7:
        cmp dword [byte esp+030h], byte 0
        je near .1
        mov eax, esi
        add esp, byte 34h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; NetHashName                                    11E11C  97 PC, low confidence
; Hashes a network name
;-----------------------------------------------------------------------------
NetHashName:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov esi, dword [byte esp+018h]
        mov edi, 0EA646174h
        mov edx, dword [byte esi+040h]
        mov dword [esp], esi
        test edx, edx
        jge short .1
        lea ebx, [byte edx-01h]
        mov dword [byte esi+040h], ebx
        cmp ebx, byte 0FFFFFFFCh
        jge short .1
        mov edi, 0EA6F706Eh
        push byte 0
        mov eax, dword [byte esi+028h]
        lea edx, [byte esi+02Ch]
        xor ecx, ecx
        mov ebp, dword [byte eax+08h]
        mov ebx, edi
        mov eax, dword [byte eax+010h]
        call dword [byte ebp+054h]
        test eax, eax
        je short .1
        mov dword [byte esi+040h], 0FFFFFFFFh
.1:
        mov eax, dword [esp]
        mov ebp, dword [byte esp+020h]
        mov edx, dword [esp]
        mov ecx, dword [byte esp+01Ch]
        mov eax, dword [byte eax+028h]
        mov ebx, edi
        push ebp
        mov esi, dword [byte eax+08h]
        add edx, byte 2Ch
        mov eax, dword [byte eax+010h]
        call dword [byte esi+054h]
        test eax, eax
        je short .2
        mov eax, ebp
.2:
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; IpxCloseSocketCall                             11E1A0  97 PC, low confidence
; IPX: closes a socket (real mode call)
;-----------------------------------------------------------------------------
IpxCloseSocketCall:
        push ebx
        push ecx
        push edx
        sub esp, byte 5Ch
        mov ebx, eax
        push byte 1Ch
        lea eax, [byte esp+038h]
        push eax
        call ZeroMem
        add esp, byte 8
        push byte 32h
        lea eax, [byte esp+04h]
        push eax
        call ZeroMem
        lea eax, [byte esp+058h]
        add esp, byte 8
        mov edx, 300h
        mov ecx, 1
        call segread_
        mov eax, dword [str_Punct_IpxHookCheck]
        mov dword [byte esp+034h], edx
        mov dword [byte esp+038h], eax
        mov eax, esp
        mov dword [byte esp+010h], ecx
        mov dword [byte esp+048h], eax
        xor eax, eax
        mov ax, word [ebx]
        lea ecx, [byte esp+050h]
        mov dword [byte esp+014h], eax
        mov ax, word [IpxCallSegment]
        lea edx, [byte esp+034h]
        mov word [byte esp+030h], ax
        mov ax, word [IpxCallOffset]
        lea ebx, [byte esp+034h]
        mov word [byte esp+02Eh], ax
        mov eax, 31h
        call int386x_
        mov eax, 1
        add esp, byte 5Ch
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; IpxGetAddressCall                              11E234  97 PC, low confidence
; IPX: gets the local address (real mode call)
;-----------------------------------------------------------------------------
IpxGetAddressCall:
        push ebx
        push ecx
        push edx
        sub esp, byte 5Ch
        mov ebx, eax
        push byte 1Ch
        lea eax, [byte esp+038h]
        push eax
        call ZeroMem
        add esp, byte 8
        push byte 32h
        lea eax, [byte esp+04h]
        push eax
        call ZeroMem
        lea eax, [byte esp+058h]
        add esp, byte 8
        mov edx, 300h
        mov ecx, 9
        call segread_
        mov eax, dword [str_Punct_IpxHookCheck]
        mov dword [byte esp+034h], edx
        mov dword [byte esp+010h], ecx
        mov dword [byte esp+038h], eax
        mov eax, esp
        lea ecx, [byte esp+050h]
        mov dword [byte esp+048h], eax
        mov eax, ebx
        lea edx, [byte esp+034h]
        sar eax, 4
        and ebx, byte 0Fh
        mov word [byte esp+022h], ax
        mov ax, word [IpxCallSegment]
        mov dword [byte esp+04h], ebx
        mov word [byte esp+030h], ax
        mov ax, word [IpxCallOffset]
        lea ebx, [byte esp+034h]
        mov word [byte esp+02Eh], ax
        mov eax, 31h
        call int386x_
        mov eax, 1
        add esp, byte 5Ch
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; IpxGetTargetCall                               11E2D0  97 PC, low confidence
; IPX: gets the local target (real mode call)
;-----------------------------------------------------------------------------
IpxGetTargetCall:
        push ebx
        push ecx
        push esi
        sub esp, byte 5Ch
        mov ebx, eax
        mov esi, edx
        push byte 1Ch
        lea eax, [byte esp+038h]
        push eax
        call ZeroMem
        add esp, byte 8
        push byte 32h
        lea eax, [byte esp+04h]
        push eax
        call ZeroMem
        add esp, byte 8
        lea eax, [byte esp+050h]
        mov edx, 300h
        call segread_
        mov eax, dword [str_Punct_IpxHookCheck]
        mov ecx, 2
        mov dword [byte esp+038h], eax
        mov eax, esp
        mov dword [byte esp+034h], edx
        mov dword [byte esp+048h], eax
        mov eax, ebx
        mov dword [byte esp+010h], ecx
        sar eax, 4
        lea ecx, [byte esp+050h]
        mov word [byte esp+022h], ax
        mov eax, ebx
        lea edx, [byte esp+034h]
        and eax, byte 0Fh
        and bl, 0F0h
        mov dword [byte esp+04h], eax
        mov ax, word [IpxCallSegment]
        sub esi, ebx
        mov word [byte esp+030h], ax
        mov ax, word [IpxCallOffset]
        lea ebx, [byte esp+034h]
        mov word [byte esp+02Eh], ax
        mov eax, 31h
        mov dword [esp], esi
        call int386x_
        mov eax, dword [byte esp+01Ch]
        and eax, 0FFh
        cmp eax, 0FAh
        setne al
        and eax, 0FFh
        add esp, byte 5Ch
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; IpxRelinquishCall                              11E388  97 PC, low confidence
; IPX: gives time to the driver (real mode call)
;-----------------------------------------------------------------------------
IpxRelinquishCall:
        push ebx
        push ecx
        push edx
        sub esp, byte 5Ch
        mov ebx, eax
        push byte 1Ch
        lea eax, [byte esp+038h]
        push eax
        call ZeroMem
        add esp, byte 8
        push byte 32h
        lea eax, [byte esp+04h]
        push eax
        call ZeroMem
        lea eax, [byte esp+058h]
        add esp, byte 8
        mov edx, 300h
        lea ecx, [byte esp+050h]
        call segread_
        mov eax, dword [str_Punct_IpxHookCheck]
        mov dword [byte esp+034h], edx
        mov dword [byte esp+01Ch], ebx
        mov ebx, 0FFFFh
        mov dword [byte esp+038h], eax
        mov eax, esp
        lea edx, [byte esp+034h]
        mov dword [byte esp+048h], eax
        mov ax, word [IpxCallSegment]
        mov dword [byte esp+010h], ebx
        mov word [byte esp+030h], ax
        mov ax, word [IpxCallOffset]
        lea ebx, [byte esp+034h]
        mov word [byte esp+02Eh], ax
        mov eax, 31h
        call int386x_
        add esp, byte 5Ch
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; IpxOpenSocketCall                              11E410  97 PC, low confidence
; IPX: opens a socket (real mode call)
;-----------------------------------------------------------------------------
IpxOpenSocketCall:
        push ebx
        push ecx
        push esi
        sub esp, byte 5Ch
        mov esi, eax
        mov ebx, edx
        push byte 1Ch
        lea eax, [byte esp+038h]
        push eax
        call ZeroMem
        add esp, byte 8
        push byte 32h
        lea eax, [byte esp+04h]
        push eax
        call ZeroMem
        add esp, byte 8
        lea eax, [byte esp+050h]
        mov edx, 300h
        call segread_
        xor ecx, ecx
        mov eax, dword [str_Punct_IpxHookCheck]
        mov dword [byte esp+034h], edx
        mov dword [byte esp+038h], eax
        mov eax, esp
        mov dword [byte esp+010h], ecx
        mov dword [byte esp+048h], eax
        test ebx, ebx
        je short .1
        mov eax, 0FFh
        jmp short .2
.1:
        xor eax, eax
.2:
        mov dword [byte esp+01Ch], eax
        xor eax, eax
        mov ax, word [esi]
        lea ecx, [byte esp+050h]
        mov dword [byte esp+014h], eax
        mov ax, word [IpxCallSegment]
        lea ebx, [byte esp+034h]
        mov word [byte esp+030h], ax
        mov ax, word [IpxCallOffset]
        lea edx, [byte esp+034h]
        mov word [byte esp+02Eh], ax
        mov eax, 31h
        call int386x_
        test byte [byte esp+01Ch], 0FFh
        je short .3
        mov eax, dword [byte esp+01Ch]
        and eax, 0FFh
        cmp eax, 0FFh
        jne short .4
.3:
        mov eax, dword [byte esp+014h]
        mov word [esi], ax
        mov eax, 1
        jmp short .5
.4:
        xor eax, eax
.5:
        add esp, byte 5Ch
        pop esi
        pop ecx
        pop ebx
        ret
        db 090h
        push ebx
        push ecx
        push esi
        mov ebx, eax
        mov esi, edx
        push byte 0
        push byte 4
        push eax
        call FillMem
        add esp, byte 0Ch
        push dword 0FFh
        push byte 6
        lea eax, [byte ebx+04h]
        push eax
        call FillMem
        add esp, byte 0Ch
        push byte 2
        push esi
        add ebx, byte 0Ah
        push ebx
        call StoreBigEndian
        add esp, byte 0Ch
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
        cmp edx, 8BEh
        je short .6
        cmp edx, 0FFFFh
        jne short .7
.6:
        cmp eax, byte 1
        jne short .7
        ret
        db 08Bh,0C0h
.7:
        xor eax, eax
        ret
        db 090h
;-----------------------------------------------------------------------------
; IpxSetupPacket                                 11E52C  97 PC, low confidence
; IPX: sets up a packet header
;-----------------------------------------------------------------------------
IpxSetupPacket:
        push ecx
        push esi
        push edi
        push ebp
        mov edi, eax
        mov ebp, edx
        mov esi, ebx
        mov eax, dword [IpxListening]
        add eax, 8Ch
        push eax
        call QueueTakeHead
        mov ebx, eax
        add esp, byte 4
        test eax, eax
        je near .1
        push byte 2
        push byte 60h
        add eax, byte 34h
        push eax
        mov byte [byte eax+03h], 0
        call StoreBigEndian
        add esp, byte 0Ch
        push byte 2
        push esi
        push IpxSocketNum
        call StoreBigEndian
        add esp, byte 0Ch
        push byte 6
        lea eax, [byte ebx+020h]
        push eax
        push ebp
        call bcopy
        add esp, byte 0Ch
        push byte 0Ch
        lea eax, [byte ebx+038h]
        push eax
        push edi
        call bcopy
        add esp, byte 0Ch
        push byte 42h
        lea eax, [byte ebx+050h]
        push eax
        push IpxSocketNum
        call bcopy
        add esp, byte 0Ch
        push byte 0Ch
        lea eax, [byte ebx+044h]
        push eax
        mov eax, dword [IpxListening]
        add eax, byte 8
        push eax
        call bcopy
        add esp, byte 0Ch
        mov eax, dword [IpxListening]
        push ebx
        add eax, byte 1Ch
        mov word [byte ebx+030h], 0
        push eax
        mov word [byte ebx+02Eh], 3
        call QueueTakeTail
        mov eax, 1
        add esp, byte 8
.1:
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; IpxResolveTarget                               11E5E8  97 PC, low confidence
; IPX: works out the immediate address of a target
;-----------------------------------------------------------------------------
IpxResolveTarget:
        push ebx
        push ecx
        push esi
        push edi
        sub esp, byte 14h
        mov esi, eax
        mov edi, edx
        mov ebx, 30h
        mov eax, IpxTargetAddr
        add edx, byte 2
        call strncmp_
        test eax, eax
        jne short .1
        mov ecx, 2
        lea eax, [byte edi+03Eh]
        mov eax, dword [eax]
        bswap eax
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        cmp eax, byte 10h
        je short .1
        push byte 0Ch
        lea eax, [byte esp+04h]
        push eax
        add edi, byte 32h
        push edi
        call bcopy
        add esp, byte 0Ch
        mov edx, esp
        mov eax, esi
        call IpxLookupTarget
        test eax, eax
        je short .1
        mov edi, IpxTargetAddr
        mov ebx, 0EA737276h
        sub ecx, ecx
        dec ecx
        xor eax, eax
        repne scasb
        not ecx
        dec ecx
        inc ecx
        mov edx, esp
        push ecx
        mov eax, esi
        mov ecx, IpxTargetAddr
        call IpxQueueSend
.1:
        add esp, byte 14h
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
IpxResolveTarget_8C:
        mov eax, dword [byte esp+04h]
        cmp byte [byte eax+0Ch], 0
        sete al
        and eax, 0FFh
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; IpxSendPacket                                  11E688  97 PC, low confidence
; IPX: sends a packet
;-----------------------------------------------------------------------------
IpxSendPacket:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 1Ch
        mov ebp, dword [byte esp+030h]
        mov ebx, dword [IpxPacketBuffer]
        mov esi, ebp
        xor edi, edi
        lea eax, [dword ebp+08Ch]
        add ebx, byte 60h
        mov dword [byte esp+04h], eax
        add ebp, byte 70h
.1:
        xor eax, eax
        mov al, byte [byte esi+07h]
        push ebp
        mov dword [byte esp+014h], eax
        call QueueCount
        add esp, byte 4
        cmp eax, dword [byte esp+010h]
        jae near .2
        mov ecx, dword [byte esp+04h]
        push ecx
        call QueueTakeHead
        add esp, byte 4
        mov dword [byte esp+0Ch], eax
        test eax, eax
        je near .2
        mov dword [byte eax+04h], 0
        mov byte [byte eax+0Ch], 1
        mov dx, word [IpxRealSegment]
        mov byte [byte eax+0Dh], 0
        mov word [byte eax+08h], dx
        mov dx, word [IpxBufferSegment]
        mov word [byte eax+0Ah], dx
        mov dl, byte [byte esi+04h]
        mov byte [byte eax+0Eh], dl
        mov dl, byte [byte esi+05h]
        mov byte [byte eax+0Fh], dl
        mov edx, dword [byte esp+0Ch]
        add edx, byte 32h
        xor dh, dh
        and dl, 0Fh
        mov word [byte eax+028h], dx
        lea edx, [byte eax+032h]
        sar edx, 4
        mov word [byte eax+02Ah], dx
        mov edx, dword [byte esp+0Ch]
        mov word [byte eax+026h], 1
        add edx, byte 4
        mov word [byte eax+02Ch], 1E4h
        xor dh, dh
        mov word [ebx], 4
        and dl, 0Fh
        mov word [byte ebx+02h], dx
        lea edx, [byte eax+04h]
        add ebx, byte 6
        push eax
        sar edx, 4
        push ebp
        inc edi
        mov word [byte ebx-02h], dx
        call QueueTakeTail
        add esp, byte 8
        jmp near .1
.2:
        lea eax, [byte esi+038h]
        mov dword [esp], eax
        lea ebp, [byte esi+01Ch]
.3:
        push ebp
        call QueueTakeHead
        add esp, byte 4
        mov edx, eax
        mov dword [byte esp+0Ch], eax
        test eax, eax
        je near .4
        mov dword [byte eax+04h], 0
        mov byte [byte edx+0Ch], 1
        mov ax, word [IpxBufferOffset]
        mov byte [byte edx+0Dh], 0
        mov word [byte edx+08h], ax
        mov ax, word [IpxBufferSegment]
        mov word [byte edx+0Ah], ax
        mov al, byte [byte esi+04h]
        mov byte [byte edx+0Eh], al
        mov al, byte [byte esi+05h]
        mov byte [byte edx+0Fh], al
        mov eax, dword [byte esp+0Ch]
        add eax, 32h
        xor ah, ah
        and al, 0Fh
        mov word [byte edx+028h], ax
        lea eax, [byte edx+032h]
        sar eax, 4
        mov ecx, 2
        mov word [byte edx+02Ah], ax
        lea eax, [byte edx+034h]
        mov word [byte edx+026h], 1
        mov eax, dword [eax]
        bswap eax
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        mov word [byte edx+02Ch], ax
        mov ax, word [byte edx+02Eh]
        mov word [ebx], ax
        mov eax, dword [byte esp+0Ch]
        add eax, 4
        xor ah, ah
        and al, 0Fh
        mov word [byte ebx+02h], ax
        lea eax, [byte edx+04h]
        sar eax, 4
        push edx
        mov word [byte ebx+04h], ax
        mov eax, dword [byte esp+04h]
        push eax
        inc edi
        add ebx, byte 6
        call QueueTakeTail
        add esp, byte 8
        jmp near .3
.4:
        mov eax, edi
        call IpxRelinquishCall
        mov eax, dword [IpxPacketBuffer]
        mov al, byte [byte eax+05Dh]
        mov ah, byte [IpxPacketFlags]
        or ah, al
        mov byte [IpxPacketFlags], ah
        je near .11
        lea ebp, [dword esi+08Ch]
        lea eax, [byte esi+054h]
        mov dword [byte esp+08h], eax
        lea eax, [byte esi+070h]
        mov dword [byte esp+018h], eax
.5:
        push byte 0
        db 068h                                 ; insn: push IpxResolveTarget_8C
        dd IpxResolveTarget_8C
        mov edx, dword [byte esp+020h]
        push edx
        call QueueAppend
        add esp, byte 0Ch
        mov edx, eax
        mov dword [byte esp+0Ch], eax
        test eax, eax
        je near .11
        cmp byte [byte eax+0Dh], 0
        jne near .10
        cmp byte [byte esi+06h], 0
        je near .9
        mov ecx, 2
        add eax, byte 4Eh
        mov eax, dword [eax]
        bswap eax
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        cmp eax, 452h
        jne near .9
        lea ebx, [byte edx+050h]
        mov ecx, 2
        mov eax, ebx
        mov eax, dword [eax]
        bswap eax
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        cmp eax, byte 2
        jne short .8
        mov ecx, 2
        lea eax, [byte edx+034h]
        mov eax, dword [eax]
        bswap eax
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        sub eax, byte 20h
        shr eax, 6
        xor edi, edi
        mov dword [byte esp+014h], eax
        test eax, eax
        jle short .8
        add ebx, byte 2
.6:
        mov ecx, 2
        mov eax, ebx
        mov eax, dword [eax]
        bswap eax
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        cmp eax, 8BEh
        jne short .7
        mov edx, ebx
        mov eax, esi
        call IpxResolveTarget
.7:
        mov edx, dword [byte esp+014h]
        inc edi
        add ebx, byte 40h
        cmp edi, edx
        jl short .6
.8:
        mov ebx, dword [byte esp+0Ch]
        push ebx
        push ebp
        call QueuePeek
        add esp, byte 8
        jmp near .5
.9:
        mov ebx, dword [byte esp+0Ch]
        push ebx
        mov ecx, dword [byte esp+0Ch]
        push ecx
        call QueueTakeTail
        add esp, byte 8
        jmp near .5
.10:
        push eax
        push ebp
        call QueuePeek
        add esp, byte 8
        jmp near .5
.11:
        mov eax, dword [IpxPacketBuffer]
        mov cl, byte [IpxPacketType]
        mov al, byte [byte eax+05Ch]
        or cl, al
        mov byte [IpxPacketType], cl
        je short .14
        lea ebx, [byte esi+01Ch]
        lea edi, [dword esi+08Ch]
        add esi, byte 38h
.12:
        push byte 0
        db 068h                                 ; insn: push IpxResolveTarget_8C
        dd IpxResolveTarget_8C
        push esi
        call QueueAppend
        add esp, byte 0Ch
        mov dword [byte esp+0Ch], eax
        test eax, eax
        je short .14
        cmp byte [byte eax+0Dh], 0
        je short .13
        mov dx, word [byte eax+030h]
        mov ecx, edx
        dec ecx
        mov word [byte eax+030h], cx
        test dx, dx
        je short .13
        push eax
        push ebx
        call QueuePeek
        add esp, byte 8
        jmp short .12
.13:
        mov ecx, dword [byte esp+0Ch]
        push ecx
        push edi
        call QueuePeek
        add esp, byte 8
        jmp short .12
.14:
        mov eax, 1
        add esp, byte 1Ch
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
;-----------------------------------------------------------------------------
; IpxPostListen                                  11E9EC  97 PC, low confidence
; IPX: posts a listen buffer
;-----------------------------------------------------------------------------
IpxPostListen:
        push ebx
        push esi
        push edi
        sub esp, byte 0Ch
        cmp dword [IpxListening], byte 0
        je near .7
        mov eax, dword [IpxListenEcb]
        cmp eax, dword [TimerTicks]
        jge short .1
        push byte 0
        push byte 4
        lea eax, [byte esp+08h]
        push eax
        call FillMem
        add esp, byte 0Ch
        push dword 0FFh
        lea eax, [byte esp+04h]
        push byte 6
        add eax, byte 4
        push eax
        call FillMem
        add esp, byte 0Ch
        push byte 2
        lea eax, [byte esp+04h]
        push dword 452h
        add eax, byte 0Ah
        push eax
        mov ebx, 2
        call StoreBigEndian
        add esp, byte 0Ch
        lea edx, [byte esp+04h]
        mov eax, esp
        call IpxSetupPacket
        test eax, eax
        je short .1
        mov edx, dword [str_D_UpdateFrameRate]
        mov eax, edx
        shl eax, 4
        sub eax, edx
        shl eax, 2
        mov edx, dword [TimerTicks]
        add eax, edx
        mov dword [IpxListenEcb], eax
.1:
        mov eax, dword [IpxListening]
        add eax, byte 54h
        push eax
        call QueueCount
        add esp, byte 4
        test eax, eax
        jbe near .7
        mov edi, 2
.2:
        mov eax, dword [IpxListening]
        add eax, byte 54h
        push eax
        call QueueTakeHead
        add esp, byte 4
        mov esi, eax
        test eax, eax
        je near .7
        lea edx, [byte eax+050h]
        mov ecx, edi
        mov eax, edx
        mov eax, dword [eax]
        bswap eax
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        mov ebx, eax
        mov ecx, edi
        lea eax, [byte edx+02h]
        mov eax, dword [eax]
        bswap eax
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        cmp eax, 8BEh
        je short .3
        cmp eax, 0FFFFh
        jne short .4
.3:
        cmp ebx, byte 1
        jne short .4
        mov eax, ebx
        jmp short .5
.4:
        xor eax, eax
.5:
        test eax, eax
        je short .6
        lea edx, [byte esi+020h]
        mov ebx, edi
        lea eax, [byte esi+044h]
        call IpxSetupPacket
.6:
        mov eax, dword [IpxListening]
        push esi
        add eax, 8Ch
        push eax
        call QueuePeek
        add esp, byte 8
        jmp near .2
.7:
        cli
        mov eax, dword [IpxPacketBuffer]
        mov dl, byte [byte eax+05Ch]
        mov byte [IpxPacketType], dl
        mov dl, byte [byte eax+05Dh]
        mov byte [byte eax+05Ch], 0
        mov byte [IpxPacketFlags], dl
        mov byte [byte eax+05Dh], 0
        sti
        cld
        push byte 0
        db 068h                                 ; insn: push IpxSendPacket
        dd IpxSendPacket
        push IpxRealRegs
        call QueuePostBuffer
        add esp, byte 0Ch
        xor eax, eax
        add esp, byte 0Ch
        pop edi
        pop esi
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; SetPairOneZero                                 11EB64  97 PC, low confidence
; Sets two words to one and zero
;-----------------------------------------------------------------------------
SetPairOneZero:
        mov dword [eax], 1
        mov dword [edx], 0
;-----------------------------------------------------------------------------
; IpxDetect                                      11EB70  97 PC, low confidence
; IPX: checks that the IPX driver is installed
;-----------------------------------------------------------------------------
IpxDetect:
        push ebx
        push ecx
        push edx
        push esi
        sub esp, byte 5Ch
        push byte 1Ch
        lea eax, [byte esp+038h]
        push eax
        call ZeroMem
        add esp, byte 8
        push byte 32h
        lea eax, [byte esp+04h]
        push eax
        mov ebx, 2Fh
        call ZeroMem
        lea eax, [byte esp+058h]
        add esp, byte 8
        mov edx, 300h
        mov ecx, 7A00h
        call segread_
        mov eax, esp
        mov dword [byte esp+034h], edx
        mov dword [byte esp+038h], ebx
        mov dword [byte esp+01Ch], ecx
        lea ecx, [byte esp+050h]
        lea ebx, [byte esp+034h]
        mov dword [byte esp+048h], eax
        xor edx, edx
        mov eax, 31h
        mov word [byte esp+030h], dx
        mov word [byte esp+02Eh], dx
        lea edx, [byte esp+034h]
        call int386x_
        mov esi, dword [IpxPacketBuffer]
        test esi, esi
        je short .1
        mov eax, dword [esp]
        mov word [byte esi+058h], ax
        mov eax, dword [byte esp+022h]
        mov word [byte esi+05Ah], ax
.1:
        mov eax, dword [byte esp+01Ch]
        and eax, 0FFh
        cmp eax, 0FFh
        sete al
        and eax, 0FFh
        add esp, byte 5Ch
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; IpxHookCheck                                   11EC18  97 PC, low confidence
; IPX: checks the real mode interrupt vector and sets up the buffers
;-----------------------------------------------------------------------------
IpxHookCheck:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 1Ch
        cmp dword [IpxPacketBuffer], byte 0
        jne near .10
        mov ebx, dword [IpxHookInstalled]
        test ebx, ebx
        je short .1
        mov ecx, dword [IpxHookBase]
        add ecx, 9E0h
        mov dword [IpxPacketBuffer], ebx
        mov dword [IpxHookBase], ecx
        jmp short .2
.1:
        mov eax, dword [IpxPresent]
        or ah, 2
        push eax
        push dword 9E0h
        push str_IPXINTF
        call AllocMemData
        add esp, byte 0Ch
        mov dword [IpxPacketBuffer], eax
        test eax, eax
        je near .11
.2:
        push dword 9E0h
        mov esi, dword [IpxPacketBuffer]
        push esi
        call ZeroMem
        add esp, byte 8
        push byte 0
        push byte 0
        push IpxRealRegs
        call QueueInit
        mov eax, dword [IpxPacketBuffer]
        add eax, 1EFh
        sar eax, 4
        mov edi, 5Fh
        mov word [IpxCallSegment], ax
        mov ax, word [IpxPacketBuffer]
        mov dx, word [IpxCallSegment]
        add eax, 9E0h
        shl edx, 4
        add esp, byte 0Ch
        sub eax, edx
        mov dword [str_Punct_IpxHookCheck], edi
        mov word [IpxCallOffset], ax
        xor ecx, ecx
.3:
        mov ebp, dword [str_Punct_IpxHookCheck]
        mov edx, 200h
        inc ebp
        mov ebx, esp
        mov dword [str_Punct_IpxHookCheck], ebp
        mov word [esp], dx
        mov al, byte [str_Punct_IpxHookCheck]
        mov edx, esp
        mov byte [byte esp+04h], al
        mov eax, 31h
        call int386_
        mov ebx, dword [byte esp+08h]
        cmp cx, bx
        jne short .4
        cmp bx, word [byte esp+0Ch]
        je short .5
.4:
        mov eax, 1
        jmp short .6
.5:
        mov eax, ecx
.6:
        mov edx, eax
        test eax, eax
        je short .7
        mov eax, dword [byte esp+08h]
        xor edx, edx
        mov dx, ax
        mov eax, dword [byte esp+0Ch]
        shl edx, 4
        and eax, 0FFFFh
        or eax, edx
        cmp byte [eax], 0CFh
        sete al
        xor edx, edx
        mov dl, al
.7:
        cmp dword [str_Punct_IpxHookCheck], byte 67h
        jge short .8
        test edx, edx
        jne short .3
.8:
        test edx, edx
        je short .9
        mov edx, 60h
        mov edi, 200h
        mov dword [str_Punct_IpxHookCheck], edx
        mov ebx, esp
        mov al, byte [str_Punct_IpxHookCheck]
        mov edx, esp
        mov byte [byte esp+04h], al
        mov eax, 31h
        mov word [esp], di
        call int386_
.9:
        push byte 8
        mov ebx, dword [IpxPacketBuffer]
        mov eax, dword [byte esp+0Ch]
        push ebx
        mov word [IpxSavedVecOffset], ax
        mov eax, dword [byte esp+014h]
        push IpxHookCodeA
        mov word [IpxSavedVecSegment], ax
        call bcopy
        add esp, byte 0Ch
        mov eax, dword [IpxPacketBuffer]
        push byte 8
        add eax, byte 8
        push eax
        push IpxHookCodeB
        call bcopy
        add esp, byte 0Ch
        mov eax, dword [IpxPacketBuffer]
        push byte 48h
        add eax, byte 10h
        push eax
        push IpxHookCodeC
        call bcopy
        mov eax, dword [IpxPacketBuffer]
        sar eax, 4
        mov dx, word [IpxPacketBuffer]
        mov word [IpxBufferSegment], ax
        shl eax, 4
        sub edx, eax
        mov word [IpxBufferOffset], dx
        mov dx, word [IpxPacketBuffer]
        add edx, byte 8
        add esp, byte 0Ch
        sub edx, eax
        mov word [esp], 201h
        mov al, byte [str_Punct_IpxHookCheck]
        mov byte [byte esp+04h], al
        mov ax, word [IpxBufferSegment]
        mov word [IpxRealSegment], dx
        mov word [byte esp+08h], ax
        mov ax, word [IpxPacketBuffer]
        mov edx, dword [byte esp+08h]
        add eax, 10h
        shl edx, 4
        mov ebx, esp
        sub eax, edx
        mov edx, esp
        mov word [byte esp+0Ch], ax
        mov eax, 31h
        call int386_
.10:
        call IpxDetect
        test eax, eax
        je short .11
        mov eax, 8628h
.11:
        add esp, byte 1Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; IpxRestoreVector                               11EE6C  97 PC, low confidence
; IPX: restores the real mode interrupt vector
;-----------------------------------------------------------------------------
IpxRestoreVector:
        push ebx
        push ecx
        push edx
        push edi
        sub esp, byte 1Ch
        cmp dword [IpxPacketBuffer], byte 0
        je near .5
        mov ebx, IpxRealRegs
.1:
        push ebx
        call QueueCount
        add esp, byte 4
        test eax, eax
        je short .2
        push ebx
        call QueueTakeHead
        add esp, byte 4
        call IpxShutdown
        jmp short .1
.2:
        push IpxRealRegs
        lea ebx, [byte esp+04h]
        call QueueNoOp
        mov al, byte [str_Punct_IpxHookCheck]
        add esp, byte 4
        mov edx, 201h
        mov byte [byte esp+04h], al
        mov ax, word [IpxSavedVecOffset]
        mov word [esp], dx
        mov word [byte esp+08h], ax
        mov ax, word [IpxSavedVecSegment]
        mov edx, esp
        mov word [byte esp+0Ch], ax
        mov eax, 31h
        call int386_
        cmp dword [IpxHookInstalled], byte 0
        je short .3
        sub dword [IpxHookBase], 9E0h
        jmp short .4
.3:
        mov ecx, dword [IpxPacketBuffer]
        push ecx
        call FreeMemBlock
        add esp, byte 4
.4:
        xor edi, edi
        mov dword [IpxPacketBuffer], edi
.5:
        mov eax, 1
        add esp, byte 1Ch
        pop edi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; IpxSetupLayer                                  11EF20  97 PC, low confidence
; IPX: sets up the IPX layer
;-----------------------------------------------------------------------------
IpxSetupLayer:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 0Ch
        mov dword [esp], eax
        mov ebx, edx
        mov edx, dword [IpxHookInstalled]
        test edx, edx
        je short .1
        mov ecx, dword [IpxHookBase]
        lea esi, [edx+ecx]
        lea edi, [dword ecx+08628h]
        mov dword [IpxHookBase], edi
        jmp short .2
.1:
        mov eax, dword [str_Punct_NetLeaveGame]
        or ah, 2
        push eax
        push dword 8628h
        push str_IPXSOCK
        call AllocMemData
        add esp, byte 0Ch
        mov esi, eax
        test eax, eax
        je near .17
.2:
        push dword 8628h
        push esi
        call ZeroMem
        add esp, byte 8
        push byte 2
        mov ebp, dword [byte esp+04h]
        push ebp
        lea edi, [byte esi+04h]
        push edi
        call StoreBigEndian
        add esp, byte 0Ch
        mov edx, ebx
        mov eax, edi
        call IpxOpenSocketCall
        test eax, eax
        jne short .5
        cmp dword [IpxHookInstalled], byte 0
        je short .3
        sub dword [IpxHookBase], 8628h
        jmp short .4
.3:
        push esi
        call FreeMemBlock
        add esp, byte 4
.4:
        xor eax, eax
        jmp near .17
.5:
        lea ebx, [byte esi+08h]
        mov eax, ebx
        call IpxGetAddressCall
        mov al, byte [byte esi+04h]
        push byte 0
        mov byte [byte ebx+0Ah], al
        push byte 0
        mov al, byte [byte esi+05h]
        lea ebp, [dword esi+08Ch]
        mov byte [byte ebx+0Bh], al
        push ebp
        mov byte [byte esi+07h], 20h
        call QueueInit
        add esp, byte 0Ch
        push byte 0
        push byte 0
        lea eax, [byte esi+01Ch]
        push eax
        call QueueInit
        add esp, byte 0Ch
        push byte 0
        push byte 0
        lea eax, [byte esi+038h]
        push eax
        call QueueInit
        add esp, byte 0Ch
        push byte 0
        push byte 0
        lea eax, [byte esi+070h]
        push eax
        call QueueInit
        add esp, byte 0Ch
        push byte 0
        lea eax, [byte esi+054h]
        push byte 0
        lea ebx, [dword esi+0A8h]
        push eax
        mov edi, ebx
        call QueueInit
        add ebx, 8580h
        add esp, byte 0Ch
.6:
        push edi
        push ebp
        call QueuePeek
        add edi, 216h
        add esp, byte 8
        cmp edi, ebx
        jne short .6
        push IpxRealRegs
        call QueueCount
        add esp, byte 4
        test eax, eax
        jne short .7
        push eax
        push byte 1
        db 068h                                 ; insn: push IpxPostListen
        dd IpxPostListen
        call AddIdleHandler
        add esp, byte 0Ch
.7:
        push esi
        push IpxRealRegs
        call QueuePeek
        add esp, byte 8
        cmp dword [esp], byte 0
        je short .11
        jmp near .16
.8:
        mov edi, dword [TimerTicks]
        push eax
        mov ebx, 0EA61636Bh
        mov edx, dword [byte esp+08h]
        mov eax, esi
        xor ecx, ecx
        add edi, byte 2
        call IpxQueueSend
        cmp edi, dword [TimerTicks]
        jle short .10
        xor ebx, ebx
.9:
        push ebp
        call QueueCount
        add esp, byte 4
        test eax, eax
        jne short .10
        push ebx
        push esi
        call IpxSendPacket
        add esp, byte 8
        cmp edi, dword [TimerTicks]
        jg short .9
.10:
        mov ebx, dword [byte esp+08h]
        dec ebx
        mov dword [byte esp+08h], ebx
        test ebx, ebx
        jg short .12
        jmp short .13
.11:
        lea ebp, [byte esi+054h]
        mov ecx, 0Ah
        lea eax, [byte esi+08h]
        mov dword [byte esp+08h], ecx
        mov dword [byte esp+04h], eax
.12:
        push ebp
        call QueueCount
        add esp, byte 4
        test eax, eax
        je short .8
.13:
        lea edi, [byte esi+054h]
        push edi
        call QueueCount
        add esp, byte 4
        test eax, eax
        jne short .14
        mov eax, esi
        call IpxShutdown
        xor esi, esi
        mov eax, esi
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.14:
        lea ebp, [dword esi+08Ch]
.15:
        push edi
        call QueueTakeHead
        add esp, byte 4
        test eax, eax
        je short .16
        push eax
        push ebp
        call QueuePeek
        add esp, byte 8
        jmp short .15
.16:
        mov eax, esi
.17:
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; IpxShutdown                                    11F154  97 PC, low confidence
; IPX: shuts down the IPX layer
;-----------------------------------------------------------------------------
IpxShutdown:
        push ebx
        push ecx
        push edx
        mov ebx, eax
        xor eax, eax
        call IpxRelinquishCall
        lea eax, [byte ebx+04h]
        call IpxCloseSocketCall
        push ebx
        push IpxRealRegs
        call QueueFreeAll
        add esp, byte 8
        push IpxRealRegs
        call QueueCount
        add esp, byte 4
        test eax, eax
        jne short .1
        db 068h                                 ; insn: push IpxPostListen
        dd IpxPostListen
        call RemoveIdleHandler
        add esp, byte 4
.1:
        lea eax, [dword ebx+08Ch]
        push eax
        call QueueNoOp
        add esp, byte 4
        lea eax, [byte ebx+01Ch]
        push eax
        call QueueNoOp
        add esp, byte 4
        lea eax, [byte ebx+038h]
        push eax
        call QueueNoOp
        add esp, byte 4
        lea eax, [byte ebx+070h]
        push eax
        call QueueNoOp
        add esp, byte 4
        lea eax, [byte ebx+054h]
        push eax
        call QueueNoOp
        mov edx, dword [IpxHookInstalled]
        add esp, byte 4
        test edx, edx
        je short .2
        sub dword [IpxHookBase], 8628h
        jmp short .3
.2:
        push ebx
        call FreeMemBlock
        add esp, byte 4
.3:
        mov eax, 1
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; IpxSocketNumber                                11F1FC  97 PC, low confidence
; IPX: returns the socket number in host order
;-----------------------------------------------------------------------------
IpxSocketNumber:
        push ecx
        mov ecx, 2
        add eax, byte 4
        mov eax, dword [eax]
        bswap eax
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        pop ecx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; IpxStart                                       11F218  97 PC, low confidence
; IPX: starts the IPX layer and opens the socket
;-----------------------------------------------------------------------------
IpxStart:
        push ebx
        push ecx
        push esi
        push edi
        mov ebx, eax
        mov esi, edx
        mov edx, dword [IpxListening]
        test edx, edx
        je short .1
        mov eax, 1
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.1:
        mov eax, 452h
        call IpxSetupLayer
        xor ecx, ecx
        mov dword [IpxListening], eax
        mov dword [IpxListenEcb], ecx
        test eax, eax
        je short .4
        mov edi, IpxLocalAddr
        mov byte [byte eax+07h], 30h
        push edi
.2:
        mov al, byte [esi]
        mov byte [edi], al
        cmp al, 0
        je short .3
        mov al, byte [byte esi+01h]
        add esi, byte 2
        mov byte [byte edi+01h], al
        add edi, byte 2
        cmp al, 0
        jne short .2
.3:
        pop edi
        push byte 2
        push byte 1
        push IpxSocket
        call StoreBigEndian
        add esp, byte 0Ch
        push byte 2
        push dword 8BEh
        push IpxSocketResult
        call StoreBigEndian
        add esp, byte 0Ch
        push byte 0Ch
        push IpxEcb
        add ebx, byte 8
        push ebx
        call bcopy
        mov eax, 1
        add esp, byte 0Ch
.4:
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; IpxStop                                        11F2B4  97 PC, low confidence
; IPX: stops the IPX layer
;-----------------------------------------------------------------------------
IpxStop:
        push ebx
        push ecx
        cmp dword [IpxListening], byte 0
        je short .1
        push byte 2
        push byte 10h
        push IpxSocket
        call StoreBigEndian
        add esp, byte 0Ch
        xor ebx, ebx
        push ebx
        mov dword [IpxListenEcb], ebx
        call RunIdleHandlers
        add esp, byte 4
        push byte 1
        call WaitTicks
        add esp, byte 4
        mov eax, dword [IpxListening]
        call IpxShutdown
        mov dword [IpxListening], ebx
.1:
        mov eax, 1
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; IpxBuildHeader                                 11F304  97 PC, low confidence
; IPX: builds a packet header
;-----------------------------------------------------------------------------
IpxBuildHeader:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        mov esi, eax
        mov ebp, edx
        add eax, 8Ch
        push eax
        call QueueTakeHead
        mov ebx, eax
        add esp, byte 4
        test eax, eax
        je near .1
        push byte 2
        lea edi, [byte eax+050h]
        push byte 22h
        add eax, byte 34h
        mov byte [byte esi+07h], 30h
        push eax
        mov byte [byte eax+03h], 0
        call StoreBigEndian
        add esp, byte 0Ch
        push byte 2
        push byte 1
        push edi
        call StoreBigEndian
        add esp, byte 0Ch
        push byte 2
        push dword 8BEh
        add edi, byte 2
        push edi
        call StoreBigEndian
        add esp, byte 0Ch
        push byte 0Ch
        lea eax, [byte ebx+044h]
        push eax
        lea eax, [byte esi+08h]
        push eax
        call bcopy
        add esp, byte 0Ch
        push dword 0FFh
        push byte 6
        lea eax, [byte ebx+020h]
        push eax
        call FillMem
        add esp, byte 0Ch
        push byte 0
        push byte 4
        lea edi, [byte ebx+038h]
        push edi
        call FillMem
        add esp, byte 0Ch
        push dword 0FFh
        push byte 6
        lea eax, [byte edi+04h]
        push eax
        call FillMem
        add esp, byte 0Ch
        push byte 2
        push dword 452h
        add edi, byte 0Ah
        push edi
        call StoreBigEndian
        add esp, byte 0Ch
        push ebx
        lea eax, [byte esi+01Ch]
        mov word [byte ebx+030h], 3
        push eax
        mov word [byte ebx+02Eh], 3
        mov ebx, 30h
        call QueueTakeTail
        add esp, byte 8
        mov eax, IpxTargetAddr
        mov edx, ebp
        call strncpy_
        mov eax, 1
        mov byte [byte esi+06h], 1
.1:
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; IpxClearName                                   11F3F4  97 PC, low confidence
; IPX: clears a node name
;-----------------------------------------------------------------------------
IpxClearName:
        mov byte [byte eax+07h], 20h
        mov byte [byte eax+06h], 0
        mov eax, 1
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; IpxSameNode                                    11F404  97 PC, low confidence
; IPX: returns whether two node addresses are equal
;-----------------------------------------------------------------------------
IpxSameNode:
        push ecx
        push esi
        push edi
        mov ecx, 8
        lea edi, [byte ebx+04h]
        lea esi, [byte edx+04h]
        xor eax, eax
        repe cmpsb
        je short .1
        sbb eax, eax
        sbb eax, byte 0FFFFFFFFh
.1:
        test eax, eax
        sete al
        and eax, 0FFh
        pop edi
        pop esi
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; IpxCopyAddress                                 11F42C  97 PC, low confidence
; IPX: copies an address
;-----------------------------------------------------------------------------
IpxCopyAddress:
        push esi
        push edi
        mov edi, edx
        lea esi, [byte eax+08h]
        mov eax, 1
        movsd
        movsd
        movsd
        movsd
        movsd
        pop edi
        pop esi
        ret
;-----------------------------------------------------------------------------
; IpxLookupTarget                                11F440  97 PC, low confidence
; IPX: looks up the immediate address of a node
;-----------------------------------------------------------------------------
IpxLookupTarget:
        push ebx
        push ecx
        push esi
        push edi
        mov esi, edx
        mov ebx, dword [IpxPacketBuffer]
        push byte 14h
        add ebx, 1E0h
        push ebx
        push edx
        call bcopy
        lea edx, [byte ebx+0Ch]
        add esp, byte 0Ch
        mov eax, ebx
        call IpxGetTargetCall
        push byte 14h
        push esi
        push ebx
        mov edi, eax
        call bcopy
        add esp, byte 0Ch
        mov eax, edi
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; IpxLockSend                                    11F480  97 PC, low confidence
; IPX: locks the send buffer
;-----------------------------------------------------------------------------
IpxLockSend:
        push ecx
        push edx
        add eax, 8Ch
        push eax
        call QueueCount
        add esp, byte 4
        pop edx
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; IpxLockListen                                  11F494  97 PC, low confidence
; IPX: locks the listen buffer
;-----------------------------------------------------------------------------
IpxLockListen:
        push ecx
        push edx
        add eax, byte 54h
        push eax
        call QueueCount
        add esp, byte 4
        pop edx
        pop ecx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; IpxQueueSend                                   11F4A8  97 PC, low confidence
; IPX: queues a packet to send
;-----------------------------------------------------------------------------
IpxQueueSend:
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov ebp, eax
        mov esi, edx
        mov edi, ebx
        mov dword [esp], ecx
        add eax, 8Ch
        push eax
        call QueueTakeHead
        add esp, byte 4
        mov edx, dword [byte esp+014h]
        mov ebx, eax
        cmp edx, 1C2h
        jle short .1
        mov dword [byte esp+014h], 1C2h
.1:
        test ebx, ebx
        je near .7
        mov eax, dword [byte esp+014h]
        push byte 2
        add eax, byte 22h
        push eax
        lea eax, [byte ebx+034h]
        push eax
        mov byte [byte ebx+037h], 0
        call StoreBigEndian
        add esp, byte 0Ch
        push byte 4
        push edi
        lea eax, [byte ebx+050h]
        push eax
        call StoreBigEndian
        add esp, byte 0Ch
        push byte 0Ch
        lea eax, [byte ebx+044h]
        push eax
        lea eax, [byte ebp+08h]
        push eax
        lea edi, [byte ebx+038h]
        call bcopy
        add esp, byte 0Ch
        test esi, esi
        je short .2
        push byte 0Ch
        push edi
        push esi
        call bcopy
        jmp short .3
.2:
        push esi
        push byte 4
        push edi
        call FillMem
        add esp, byte 0Ch
        push dword 0FFh
        push byte 6
        lea eax, [byte edi+04h]
        push eax
        call FillMem
        add esp, byte 0Ch
        push byte 2
        push dword 452h
        add edi, byte 0Ah
        push edi
        call StoreBigEndian
.3:
        add esp, byte 0Ch
        mov edi, dword [esp]
        test edi, edi
        je short .4
        mov eax, dword [byte esp+014h]
        test eax, eax
        je short .4
        push eax
        lea eax, [byte ebx+054h]
        push eax
        push edi
        call bcopy
        add esp, byte 0Ch
.4:
        lea eax, [byte ebx+020h]
        test esi, esi
        je short .5
        push byte 6
        push eax
        add esi, byte 0Ch
        push esi
        call bcopy
        jmp short .6
.5:
        push dword 0FFh
        push byte 6
        push eax
        call FillMem
.6:
        add esp, byte 0Ch
        push ebx
        add ebp, byte 1Ch
        mov word [byte ebx+030h], 3
        push ebp
        mov word [byte ebx+02Eh], 3
        call QueueTakeTail
        mov eax, 1
        add esp, byte 8
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        ret 4
.7:
        xor eax, eax
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        ret 4
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; IpxReceive                                     11F5D8  97 PC, low confidence
; IPX: takes a received packet
;-----------------------------------------------------------------------------
IpxReceive:
        push esi
        push edi
        push ebp
        sub esp, byte 3Ch
        mov dword [byte esp+034h], eax
        mov dword [byte esp+028h], edx
        mov dword [byte esp+018h], ebx
        mov dword [byte esp+014h], ecx
        mov eax, dword [ebx]
        mov dword [byte esp+024h], eax
        mov eax, dword [byte esp+034h]
        add eax, byte 54h
        xor edi, edi
        mov dword [byte esp+02Ch], eax
        mov eax, dword [byte esp+034h]
        mov dword [byte esp+038h], edi
        add eax, 8Ch
        mov dword [ebx], edi
        mov dword [byte esp+030h], eax
.1:
        mov eax, dword [byte esp+034h]
        mov ebx, dword [byte esp+038h]
        cmp ebx, dword [byte eax+05Ch]
        je near .9
        mov ecx, dword [byte esp+02Ch]
        push ecx
        call QueueTakeHead
        mov esi, eax
        add esp, byte 4
        mov ebp, eax
        test eax, eax
        je near .6
        cmp byte [byte eax+0Dh], 0
        jne near .6
        mov ecx, 4
        lea eax, [byte esi+050h]
        mov eax, dword [eax]
        bswap eax
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        mov ecx, 2
        mov ebx, eax
        mov dword [byte esp+020h], eax
        lea eax, [byte esi+034h]
        mov eax, dword [eax]
        bswap eax
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        push byte 0Ch
        mov dword [byte esp+020h], eax
        lea eax, [byte esp+04h]
        push eax
        lea eax, [byte esi+044h]
        push eax
        call bcopy
        add esp, byte 0Ch
        push byte 6
        lea eax, [byte esp+010h]
        push eax
        lea eax, [byte esi+020h]
        push eax
        call bcopy
        add esp, byte 0Ch
        mov eax, dword [byte esp+024h]
        test eax, eax
        je short .3
        cmp ebx, eax
        jne short .3
        mov ebx, esp
        mov edx, dword [byte esp+028h]
        mov eax, dword [byte esp+034h]
        call IpxSameNode
        test eax, eax
        jne short .3
        cmp dword [byte esp+038h], byte 0
        jne short .2
        mov dword [byte esp+038h], esi
.2:
        push ebp
        mov edx, dword [byte esp+030h]
        push edx
        call QueueTakeTail
        jmp short .8
.3:
        mov edi, dword [byte esp+028h]
        mov esi, esp
        mov ebx, dword [byte esp+018h]
        movsd
        movsd
        movsd
        movsd
        movsd
        mov eax, dword [byte esp+020h]
        mov edi, dword [byte esp+01Ch]
        mov dword [ebx], eax
        mov ebx, dword [byte esp+04Ch]
        sub edi, byte 22h
        cmp edi, ebx
        jle short .4
        mov edi, ebx
.4:
        test edi, edi
        jle short .5
        push edi
        mov ecx, dword [byte esp+018h]
        push ecx
        lea eax, [byte ebp+054h]
        push eax
        call bcopy
        add esp, byte 0Ch
        jmp short .7
.5:
        xor edi, edi
        jmp short .7
.6:
        test ebp, ebp
        je short .9
.7:
        push ebp
        mov esi, dword [byte esp+034h]
        push esi
        call QueuePeek
.8:
        add esp, byte 8
        test edi, edi
        je near .1
.9:
        test edi, edi
        jne short .11
        cmp dword [byte esp+038h], byte 0
        je short .11
        mov ebx, dword [byte esp+034h]
        mov esi, dword [byte esp+034h]
        xor eax, eax
        add esi, byte 54h
        mov al, byte [byte ebx+07h]
        push esi
        mov ebx, eax
        call QueueCount
        sar ebx, 1
        add esp, byte 4
        cmp eax, ebx
        jbe short .11
        mov ebx, dword [byte esp+034h]
        add ebx, 8Ch
.10:
        push esi
        call QueueTakeHead
        add esp, byte 4
        test eax, eax
        je short .11
        push eax
        push ebx
        call QueuePeek
        add esp, byte 8
        jmp short .10
.11:
        mov eax, edi
        add esp, byte 3Ch
        pop ebp
        pop edi
        pop esi
        ret 4
        db 090h
;-----------------------------------------------------------------------------
; IpxPeek                                        11F794  97 PC, low confidence
; IPX: peeks at a received packet
;-----------------------------------------------------------------------------
IpxPeek:
        push esi
        push edi
        push ebp
        sub esp, byte 10h
        mov edi, eax
        mov ebp, edx
        mov dword [byte esp+04h], ebx
        xor edx, edx
        mov ebx, dword [byte eax+05Ch]
        mov dword [esp], edx
        test ebx, ebx
        je near .8
        add eax, 8Ch
        mov dword [byte esp+0Ch], eax
        mov eax, edi
        add eax, byte 54h
        mov dword [byte esp+08h], eax
.1:
        mov esi, dword [byte esp+08h]
        push esi
        call QueueTakeHead
        mov edx, eax
        add esp, byte 4
        mov esi, eax
        test eax, eax
        je short .4
        cmp byte [byte eax+0Dh], 0
        jne short .4
        mov ecx, 4
        lea eax, [byte edx+050h]
        mov ebx, dword [byte esp+04h]
        mov eax, dword [eax]
        bswap eax
        neg ecx
        lea ecx, [nosplit ecx*8+020h]
        shr eax, cl
        cmp eax, ebx
        jne short .2
        test ebp, ebp
        je short .5
        lea ebx, [byte edx+044h]
        mov eax, edi
        mov edx, ebp
        call IpxSameNode
        test eax, eax
        jne short .5
.2:
        cmp dword [esp], byte 0
        jne short .3
        mov dword [esp], esi
.3:
        push esi
        mov esi, dword [byte esp+0Ch]
        push esi
        call QueueTakeTail
        jmp short .6
.4:
        test esi, esi
        je short .7
.5:
        push esi
        mov eax, dword [byte esp+010h]
        push eax
        call QueuePeek
.6:
        add esp, byte 8
.7:
        mov ecx, dword [esp]
        cmp ecx, dword [byte edi+05Ch]
        jne short .1
.8:
        mov eax, 1
        add esp, byte 10h
        pop ebp
        pop edi
        pop esi
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; IpxLinkStartup                                 11F850  97 PC, low confidence
; IPX: starts the IPX link driver
;-----------------------------------------------------------------------------
IpxLinkStartup:
        push ebx
        push ecx
        push edx
        mov ebx, eax
        mov edx, dword [IpxStartupState]
        test edx, edx
        jne short .5
        mov ecx, 1
        mov dword [IpxStartupState], ecx
        call IpxHookCheck
        test eax, eax
        je short .4
        xor eax, eax
        call IpxSetupLayer
        mov edx, eax
        test eax, eax
        je short .2
        mov eax, dword [NetSessionName]
        mov dword [nosplit eax*4+NetLocalName], NetProtocolName
        add eax, ecx
        mov dword [NetSessionName], eax
        test ebx, ebx
        je short .1
        mov dword [NetProtocolName], ebx
.1:
        mov eax, edx
        call IpxShutdown
        jmp short .3
.2:
        mov dword [IpxStartupState], eax
.3:
        call IpxRestoreVector
        jmp short .5
.4:
        mov dword [IpxStartupState], edx
.5:
        mov eax, dword [IpxStartupState]
        test eax, eax
        je short .6
        mov eax, 11630h
.6:
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; SetNetCallback                                 11F8D0  97 PC, low confidence
; Sets the network callback
;-----------------------------------------------------------------------------
SetNetCallback:
        mov dword [IpxHookInstalled], eax
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; AllocNetBuffer                                 11F8E0  97 PC, low confidence
; Allocates a network buffer
;-----------------------------------------------------------------------------
AllocNetBuffer:
        push ebx
        push ecx
        push edx
        push esi
        mov esi, eax
        test eax, eax
        jg short .1
        xor eax, eax
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.1:
        mov edx, dword [MessageBoxActive]
        push edx
        add eax, byte 0Ch
        push eax
        push str_Galloc
        call AllocMemBlock
        mov ebx, eax
        add esp, byte 0Ch
        test eax, eax
        je short .2
        push byte 4
        push eax
        push str_GMEM
        call bcopy
        add esp, byte 0Ch
        add ebx, byte 8
        push byte 4
        mov dword [byte ebx-04h], esi
        add esi, ebx
        push esi
        push str_GEND
        call bcopy
        mov ecx, dword [NetBufferPool]
        add esp, byte 0Ch
        inc ecx
        mov eax, ebx
        mov dword [NetBufferPool], ecx
.2:
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; FreeNetBuffer                                  11F94C  97 PC, low confidence
; Frees a network buffer
;-----------------------------------------------------------------------------
FreeNetBuffer:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov edx, eax
        mov ecx, 4
        mov edi, str_GMEM
        lea esi, [byte eax-08h]
        mov ebp, dword [byte eax-04h]
        xor eax, eax
        repe cmpsb
        je short .1
        sbb eax, eax
        sbb eax, byte 0FFFFFFFFh
.1:
        xor ebx, ebx
        test eax, eax
        jne short .3
        test ebp, ebp
        jle short .3
        cmp ebp, 2000000h
        jge short .3
        mov ecx, 4
        mov edi, str_GEND
        lea esi, [edx+ebp]
        xor eax, eax
        repe cmpsb
        je short .2
        sbb eax, eax
        sbb eax, byte 0FFFFFFFFh
.2:
        test eax, eax
        jne short .3
        mov ebx, 1
.3:
        lea esi, [byte edx-08h]
        test ebx, ebx
        jne short .5
        mov ecx, 4
        mov edi, str_GFRE
        xor eax, eax
        repe cmpsb
        je short .4
        sbb eax, eax
        sbb eax, byte 0FFFFFFFFh
.4:
        jmp short .6
.5:
        push byte 4
        push esi
        push str_GFRE
        call bcopy
        add esp, byte 0Ch
        push esi
        call FreeMemBlock
        mov edx, dword [NetBufferPool]
        dec edx
        add esp, byte 4
        mov dword [NetBufferPool], edx
.6:
        mov eax, ebx
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 00h
;-----------------------------------------------------------------------------
; ReadBigEndian                                  11F9F0  97 PC, low confidence
; Reads a big-endian number of the given size
;-----------------------------------------------------------------------------
ReadBigEndian:
        push ebx
        push ecx
        xor ebx, ebx
.1:
        dec edx
        cmp edx, byte 0FFFFFFFFh
        je short .2
        xor ecx, ecx
        shl ebx, 8
        mov cl, byte [eax]
        inc eax
        add ebx, ecx
        jmp short .1
.2:
        mov eax, ebx
        pop ecx
        pop ebx
        ret
        db 090h
        push ebx
        push ecx
        push esi
        push edi
        mov ebx, eax
        xor esi, esi
        xor eax, eax
.3:
        dec edx
        cmp edx, byte 0FFFFFFFFh
        je short .4
        mov cl, al
        movzx edi, byte [ebx]
        inc ebx
        shl edi, cl
        add eax, byte 8
        add esi, edi
        jmp short .3
.4:
        mov eax, esi
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; WriteBigEndian                                 11FA34  97 PC, low confidence
; Writes a big-endian number of the given size
;-----------------------------------------------------------------------------
WriteBigEndian:
        push ecx
        sub esp, byte 4
        mov ecx, 4
        sub ecx, ebx
        shl ecx, 3
        shl edx, cl
        test ebx, ebx
        je short .2
.1:
        mov ecx, edx
        shr ecx, 18h
        mov dword [esp], ecx
        inc eax
        mov cl, byte [esp]
        shl edx, 8
        mov byte [byte eax-01h], cl
        dec ebx
        jne short .1
.2:
        add esp, byte 4
        pop ecx
        ret
        db 08Bh,0C0h
        push ecx
        sub esp, byte 4
        test ebx, ebx
        je short .4
.3:
        mov dword [esp], edx
        inc eax
        mov cl, byte [esp]
        shr edx, 8
        mov byte [byte eax-01h], cl
        dec ebx
        jne short .3
.4:
        add esp, byte 4
        pop ecx
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; GetCurrentFont                                 11FA90  97 PC, low confidence
; Returns the current font
;-----------------------------------------------------------------------------
GetCurrentFont:
        mov eax, dword [LinkTextFont]
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; SetTextOrigin                                  11FA98  97 PC, low confidence
; Sets the text origin
;-----------------------------------------------------------------------------
SetTextOrigin:
        mov eax, dword [byte esp+04h]
        mov dword [TextOriginX], eax
        mov eax, dword [byte esp+08h]
        mov dword [TextOriginY], eax
        ret
        db 090h
