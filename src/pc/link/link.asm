; Serial link: packets, timers, handshake and syncing menus and games.
bits 32
%include "hockey.inc"
section s_E329B progbits alloc exec nowrite align=1
extern __CHK, AllocMemBlock, bcopy, BlitShape2, CloseNetConnection, CloseNetSession, ConvertArtKeepPos, CreateBitmap
extern DrawTextAt, FillRect, FillRectColor, FillRectCorners, FreeBitmap, FreeMemBlock, GetLangText, GripDriverPtr
extern GripPortWord, HideLinkBox, HostNetGame, HotKeyFlags, InitNetSession, InitPacketLink, InputRecordCount, InputRecordHead
extern InputRecordRing, InputRecordStamp, InputRecordTaken, IpxCloseSocket, IpxInit, IsKeyDown, JoinNetworkGame, KbdGetKey
extern LeaveNetGame, LinkAbortPad, LinkBlockDone, LinkFrameDelay, LinkGameActive, LinkHandle, LinkHandshakeDone, LinkInputAck
extern LinkInputChanged, LinkInputHigh, LinkInputPacket, LinkInputResend, LinkInputSent, LinkInputState, LinkInputTickCount, LinkInputWordPad
extern LinkLocalInput, LinkPacketBuffer, LinkPacketQueues, LinkPlayerReady, LinkQueueCounters, LinkRecvBytes, LinkRecvErrors, LinkRecvOffset
extern LinkRecvPackets, LinkRecvSize, LinkRemoteFlags, LinkRemoteInput, LinkRemoteSequence, LinkSendBuffer, LinkSentBytes, LinkSentErrors
extern LinkSentPackets, LinkSequence, LinkServiceTick, LinkTextFont, LinkTimeout, LinkTimerActive, LinkWaitCount, LinkWaitTimer
extern MakeColor, MeasureText, MenuScreenBitmap, mousex, mousey, NetActive, NetConnected, NetDriverHandle
extern OpenNetSession, PacketLinkSend, PacketSize, PresentFuncInput, PresentScreen, RunIdleHandlers, ServiceBackgroundAudio, SetScreenTarget
extern SetTextColor, ShowLinkMessage, ShowLinkWait, ShowMessageBox, ShutdownNetSession, ShutdownPacketLink, SlotWords, str_Disconnecting
extern str_Pktlayer, str_Punct_ModemSettingsScreen, str_WaitingForOtherComputer, str_X_WaitForOtherComputer, strlen_, tickcount, ViewScreenHeight, ViewScreenWidth
extern WaitTicks, ZeroMem
global InitLinkSettingsJumpTable, InitLinkSettings, InitLinkSettings_D6, InitLinkSettings_E8, InitLinkSettings_FF, InitLinkSettings_10D, InitLinkSettings_11D, ClearLinkAbort
global ServiceIdle, ServiceIdle_34, QueueLinkPacket, SendLinkPacket, ResendLinkPacket, LinkTimerOn, LinkTimerOff, ResetLinkStats
global SyncLinkGame, NetInit, NetShutdown, StartNetworkLink, NetDisconnect, LinkHandshake, LinkSyncMenu, LinkSyncScreen
global LinkSyncGame, ClearLinkInputs, LinkInputTick, LinkSendBlock, LinkReceiveBlock, WaitForOtherComputer
        db 090h
InitLinkSettingsJumpTable:                      ; jump table for the switch cases of InitLinkSettings
        dd InitLinkSettings_E8
        dd InitLinkSettings_D6
        dd InitLinkSettings_FF
        dd InitLinkSettings_10D
        dd InitLinkSettings_10D
        dd InitLinkSettings_11D
;-----------------------------------------------------------------------------
; InitLinkSettings                                E32B4  97 PC, low confidence
; Sets up the link settings
;-----------------------------------------------------------------------------
InitLinkSettings:
        push dword 6Ch
        call __CHK
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 48h
        mov edi, eax
        push byte 48h
        lea eax, [byte esp+04h]
        push eax
        mov esi, 2
        xor ebx, ebx
        call ZeroMem
        add esp, byte 8
        xor edx, edx
        jmp short .3
.1:
        mov eax, dword [GripDriverPtr]
        test byte [ebx+eax], 1
        je short .2
        inc esi
.2:
        inc edx
        add ebx, byte 38h
.3:
        xor eax, eax
        mov ax, word [GripPortWord]
        cmp edx, eax
        jl short .1
        mov edx, edi
        xor ebx, ebx
        xor ebp, ebp
.4:
        cmp ebp, dword [LinkGameActive]
        je near .7
        call ClearLinkAbort
        test eax, eax
        je short .5
        cmp ebx, byte 3
        jle short .5
        mov ch, byte [edx]
        test ch, 7
        setne al
        and eax, 0FFh
        je short .5
        mov al, ch
        and al, 7
        cmp al, 1
        setne al
        and eax, 0FFh
        jne short .6
.5:
        call ClearLinkAbort
        test eax, eax
        jne short .7
        cmp ebx, byte 4
        jge short .7
        test byte [edx], 7
        setne al
        and eax, 0FFh
        je short .7
        mov al, byte [edx]
        and al, 7
        cmp al, 1
        setne al
        and eax, 0FFh
        je short .7
.6:
        mov al, byte [edx]
        and al, 0F8h
        or al, 1
        mov byte [edx], al
.7:
        mov al, byte [edx]
        and al, 7
        cmp al, 5
        ja near InitLinkSettings_E8
        and eax, 0FFh
        jmp dword [nosplit cs:eax*4+InitLinkSettingsJumpTable]
InitLinkSettings_D6:
        cmp ebp, dword [LinkGameActive]
        jne near InitLinkSettings_E8
.8:
        mov al, byte [edx]
        and al, 0F8h
        mov byte [edx], al
InitLinkSettings_E8:
        inc ebx
        inc edx
        cmp ebx, byte 8
        jl near InitLinkSettings.4
        mov eax, esi
        add esp, byte 48h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
InitLinkSettings_FF:
        cmp ebp, dword [esp]
        jne short InitLinkSettings_D6.8
        mov dword [esp], 1
        jmp short InitLinkSettings_E8
InitLinkSettings_10D:
        cmp ebp, dword [byte esp+04h]
        jne short InitLinkSettings_D6.8
        mov dword [byte esp+04h], 1
        jmp short InitLinkSettings_E8
InitLinkSettings_11D:
        mov al, byte [edx]
        and al, 78h
        xor ecx, ecx
        and eax, 0FFh
        mov cx, word [GripPortWord]
        sar eax, 3
        cmp eax, ecx
        jge short InitLinkSettings_D6.8
        imul ecx, eax, byte 38h
        mov edi, dword [GripDriverPtr]
        test byte [ecx+edi], 1
        je short InitLinkSettings_D6.8
        shl eax, 2
        cmp ebp, dword [byte esp+eax+08h]
        jne short InitLinkSettings_D6.8
        mov dword [byte esp+eax+08h], 1
        jmp short InitLinkSettings_E8
        db 00h,00h,00h,00h
;-----------------------------------------------------------------------------
; ClearLinkAbort                                  E3410  97 PC, low confidence
; Clears the link abort flag
;-----------------------------------------------------------------------------
ClearLinkAbort:
        mov eax, dword [LinkAbortPad]
        sar eax, 10h
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ServiceIdle                                     E341C  97 PC, low confidence
; Services audio and keys while waiting
;-----------------------------------------------------------------------------
ServiceIdle:
        push ecx
        push edx
        mov eax, dword [tickcount]
        cmp eax, dword [LinkServiceTick]
        je short .1
        push byte 0
        call RunIdleHandlers
        add esp, byte 4
        push byte 0
        push byte 0
        call ServiceBackgroundAudio
        add esp, byte 8
        mov eax, dword [tickcount]
        mov dword [LinkServiceTick], eax
.1:
        pop edx
        pop ecx
        ret
        db 08Bh,0C0h
ServiceIdle_34:
        mov eax, dword [tickcount]
        cmp eax, dword [LinkServiceTick]
        je short .2
        push byte 0
        call RunIdleHandlers
        add esp, byte 4
        push byte 0
        push byte 0
        call ServiceBackgroundAudio
        add esp, byte 8
        mov eax, dword [tickcount]
        mov dword [LinkServiceTick], eax
.2:
        push byte 1
        call IsKeyDown
        add esp, byte 4
        ret
        push ecx
        push edx
        push dword 14Ah
        push LinkPacketQueues
        call ZeroMem
        add esp, byte 8
        pop edx
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; QueueLinkPacket                                 E34A0  97 PC, low confidence
; Queues a link packet
;-----------------------------------------------------------------------------
QueueLinkPacket:
        push ebx
        push ecx
        push esi
        mov esi, eax
        mov ecx, edx
        mov ebx, eax
        shl ebx, 5
        add ebx, eax
        add ebx, ebx
        mov edx, dword [dword ebx+LinkPacketQueues+3Ch]
        sar edx, 10h
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        mov edx, LinkPacketQueues
        add eax, eax
        add edx, ebx
        push byte 6
        add eax, edx
        push eax
        push ecx
        call bcopy
        mov edx, dword [dword ebx+LinkPacketQueues+3Ch]
        sar edx, 10h
        inc edx
        mov ecx, 0Ah
        mov eax, edx
        sar edx, 1Fh
        idiv ecx
        add esp, byte 0Ch
        mov ax, word [dword ebx+LinkPacketQueues+3Ch]
        mov word [dword ebx+LinkPacketQueues+3Eh], dx
        cmp ax, dx
        jne short .1
        mov edx, dword [dword ebx+LinkPacketQueues+3Ah]
        sar edx, 10h
        inc edx
        mov eax, edx
        sar edx, 1Fh
        idiv ecx
        mov word [dword ebx+LinkPacketQueues+3Ch], dx
.1:
        mov ebx, esi
        shl ebx, 5
        add ebx, esi
        inc word [nosplit ebx*2+LinkQueueCounters]
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; SendLinkPacket                                  E3530  97 PC, low confidence
; Sends a link packet
;-----------------------------------------------------------------------------
SendLinkPacket:
        push ebx
        push ecx
        push esi
        mov esi, eax
        shl eax, 5
        lea ebx, [esi+eax]
        add ebx, ebx
        mov ax, word [dword ebx+LinkPacketQueues+3Ch]
        cmp ax, word [dword ebx+LinkPacketQueues+3Eh]
        je short .2
        test edx, edx
        je short .1
        push byte 6
        push edx
        mov edx, dword [dword ebx+LinkPacketQueues+3Ah]
        sar edx, 10h
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        lea edx, [eax+eax]
        mov eax, LinkPacketQueues
        add eax, ebx
        add eax, edx
        push eax
        call bcopy
        add esp, byte 0Ch
.1:
        mov ebx, esi
        shl ebx, 5
        add ebx, esi
        add ebx, ebx
        mov edx, dword [dword ebx+LinkPacketQueues+3Ah]
        sar edx, 10h
        inc edx
        mov esi, 0Ah
        mov eax, edx
        sar edx, 1Fh
        idiv esi
        mov si, word [dword ebx+LinkPacketQueues+40h]
        mov word [dword ebx+LinkPacketQueues+3Ch], dx
        dec esi
        mov word [dword ebx+LinkPacketQueues+40h], si
.2:
        pop esi
        pop ecx
        pop ebx
        ret
        push ebx
        push edx
        xor edx, edx
        mov bx, word [LinkSequence]
        mov dl, byte [byte eax+05h]
        cmp dx, bx
        je short .3
        mov eax, dword [byte eax+01h]
        mov dword [LinkRemoteSequence], eax
.3:
        pop edx
        pop ebx
        ret
        db 08Bh,0C0h
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        xor ebx, ebx
        mov edx, dword [LinkRecvOffset]
        mov bl, byte [byte eax+01h]
        mov ecx, dword [LinkRecvSize]
        add edx, ebx
        cmp edx, ecx
        jg short .4
        push ebx
        mov esi, dword [LinkSendBuffer]
        push esi
        add eax, byte 2
        push eax
        call bcopy
        mov edi, dword [LinkSendBuffer]
        mov ebp, dword [LinkRecvOffset]
        add esp, byte 0Ch
        add edi, ebx
        add ebp, ebx
        mov dword [LinkSendBuffer], edi
        mov dword [LinkRecvOffset], ebp
.4:
        mov edx, dword [LinkRecvSize]
        cmp edx, dword [LinkRecvOffset]
        jne short .5
        mov dword [LinkBlockDone], 1
.5:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ResendLinkPacket                                E3640  97 PC, low confidence
; Resends a link packet
;-----------------------------------------------------------------------------
ResendLinkPacket:
        push ebx
        push esi
        push edi
        push ebp
        mov edx, dword [byte esp+018h]
        xor eax, eax
        mov al, byte [edx]
        sar eax, 5
        cmp eax, byte 2
        jg short .1
        call QueueLinkPacket
        jmp near .4
.1:
        cmp eax, byte 3
        jb near .4
        jbe short .3
        cmp eax, byte 4
        jne near .4
        xor ebx, ebx
        mov eax, dword [LinkRecvOffset]
        mov bl, byte [byte edx+01h]
        mov ecx, dword [LinkRecvSize]
        add eax, ebx
        cmp eax, ecx
        jg short .2
        push ebx
        mov esi, dword [LinkSendBuffer]
        push esi
        add edx, byte 2
        push edx
        call bcopy
        mov edi, dword [LinkSendBuffer]
        mov ebp, dword [LinkRecvOffset]
        add esp, byte 0Ch
        add edi, ebx
        add ebp, ebx
        mov dword [LinkSendBuffer], edi
        mov dword [LinkRecvOffset], ebp
.2:
        mov edx, dword [LinkRecvSize]
        cmp edx, dword [LinkRecvOffset]
        jne short .4
        mov dword [LinkBlockDone], 1
        mov eax, 1
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.3:
        xor eax, eax
        mov bx, word [LinkSequence]
        mov al, byte [byte edx+05h]
        cmp ax, bx
        je short .4
        mov eax, dword [byte edx+01h]
        mov dword [LinkRemoteSequence], eax
.4:
        mov eax, 1
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; LinkTimerOn                                     E3700  97 PC, low confidence
; Starts the link timer
;-----------------------------------------------------------------------------
LinkTimerOn:
        push dword 4
        call __CHK
        test eax, eax
        je short .3
        cmp dword [LinkTimerActive], byte 0
        jne short .3
        cmp dword [MenuScreenBitmap], byte 8
        je short .1
        call ShowLinkMessage
        jmp short .2
.1:
        call ShowLinkWait
.2:
        mov dword [LinkTimerActive], 1
.3:
        ret
        db 090h
;-----------------------------------------------------------------------------
; LinkTimerOff                                    E3738  97 PC, low confidence
; Stops the link timer
;-----------------------------------------------------------------------------
LinkTimerOff:
        push dword 8
        call __CHK
        push ebx
        cmp dword [LinkTimerActive], byte 0
        je short .1
        xor ebx, ebx
        call HideLinkBox
        mov dword [LinkTimerActive], ebx
.1:
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; ResetLinkStats                                  E375C  97 PC, low confidence
; Clears the link counters
;-----------------------------------------------------------------------------
ResetLinkStats:
        push dword 4
        call __CHK
        cmp eax, byte 2
        jne short .1
        mov dword [LinkSentErrors], ebx
        mov dword [LinkSentPackets], ecx
        mov dword [LinkSentBytes], edx
        ret
.1:
        cmp eax, byte 1
        jne short .2
        mov dword [LinkRecvErrors], ebx
        mov dword [LinkRecvPackets], ecx
        mov dword [LinkRecvBytes], edx
.2:
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; SyncLinkGame                                    E3798  97 PC, low confidence
; Synchronises the game with the other computer
;-----------------------------------------------------------------------------
SyncLinkGame:
        push dword 28h
        call __CHK
        push esi
        push edi
        push ebp
        sub esp, byte 0Ch
        mov esi, eax
        mov ebp, edx
        mov edi, ecx
        xor edx, edx
        mov dword [eax], edx
        mov ecx, dword [NetActive]
        mov dword [byte esp+08h], edx
        test ecx, ecx
        jne short .1
        xor eax, eax
        jmp near .13
.1:
        mov eax, dword [LinkGameActive]
        test eax, eax
        je near .13
        mov eax, dword [tickcount]
        cmp eax, dword [LinkTimeout]
        jle near .11
        cmp word [LinkPacketQueues+148h], byte 1
        jge near .10
        call PresentScreen
        mov dword [esi], 1
        xor ah, ah
        mov byte [esp], ah
        mov eax, dword [byte ebp+00h]
        shl eax, 0Bh
        mov dword [byte esp+01h], eax
        mov eax, dword [ebx]
        mov ecx, dword [byte esp+01h]
        add eax, eax
        or ecx, eax
        mov dword [byte esp+01h], ecx
        cmp dword [edi], byte 0
        je short .2
        or byte [byte esp+01h], 1
.2:
        mov eax, dword [tickcount]
        mov edx, dword [LinkFrameDelay]
        shl edx, 2
        add eax, edx
        mov dword [LinkPacketBuffer], eax
        xor esi, esi
.3:
        push byte 6
        lea eax, [byte esp+04h]
        push eax
        mov eax, dword [LinkHandle]
        push eax
        call PacketLinkSend
        add esp, byte 0Ch
        test eax, eax
        jne near .9
        mov eax, dword [tickcount]
        cmp eax, dword [LinkPacketBuffer]
        jle near .8
        mov ecx, dword [LinkTimerActive]
        cmp esi, ecx
        jne near .8
        cmp dword [MenuScreenBitmap], byte 8
        je short .5
        mov eax, 237h
        call GetLangText
        test eax, eax
        je short .8
        cmp ecx, dword [LinkTimerActive]
        jne short .8
        cmp dword [MenuScreenBitmap], byte 8
        je short .4
        call ShowLinkMessage
        jmp short .7
.4:
        call ShowLinkWait
        jmp short .7
.5:
        mov eax, 76h
        call GetLangText
        test eax, eax
        je short .8
        cmp ecx, dword [LinkTimerActive]
        jne short .8
        cmp dword [MenuScreenBitmap], byte 8
        je short .6
        call ShowLinkMessage
        jmp short .7
.6:
        call ShowLinkWait
.7:
        mov dword [LinkTimerActive], 1
.8:
        mov eax, dword [tickcount]
        cmp eax, dword [LinkServiceTick]
        je near .3
        push esi
        call RunIdleHandlers
        add esp, byte 4
        push esi
        push esi
        call ServiceBackgroundAudio
        add esp, byte 8
        mov eax, dword [tickcount]
        mov dword [LinkServiceTick], eax
        jmp near .3
.9:
        mov edx, esp
        mov eax, 4
        call QueueLinkPacket
        mov edx, dword [LinkTimerActive]
        test edx, edx
        je short .10
        je short .10
        xor esi, esi
        call HideLinkBox
        mov dword [LinkTimerActive], esi
.10:
        mov eax, dword [tickcount]
        mov edx, dword [LinkFrameDelay]
        add eax, edx
        mov dword [LinkTimeout], eax
.11:
        mov cx, word [LinkPacketQueues+3Eh]
        mov ax, word [LinkPacketQueues+3Ch]
        cmp ax, cx
        setne al
        and eax, 0FFh
        je near .12
        mov si, word [LinkPacketQueues+146h]
        mov ax, word [LinkPacketQueues+144h]
        cmp ax, si
        setne al
        and eax, 0FFh
        je short .12
        mov edx, esp
        xor eax, eax
        call SendLinkPacket
        mov eax, dword [byte esp+01h]
        and eax, 1FF800h
        sar eax, 0Bh
        mov dword [LinkRecvBytes], eax
        mov eax, dword [byte esp+01h]
        and eax, 7FEh
        sar eax, 1
        mov dword [LinkRecvErrors], eax
        mov eax, dword [byte esp+01h]
        and eax, byte 1
        mov edx, esp
        mov dword [LinkRecvPackets], eax
        mov eax, 4
        call SendLinkPacket
        mov eax, dword [byte esp+01h]
        and eax, 1FF800h
        sar eax, 0Bh
        mov dword [LinkSentBytes], eax
        mov eax, dword [byte esp+01h]
        and eax, 7FEh
        sar eax, 1
        mov dword [LinkSentErrors], eax
        mov eax, dword [byte esp+01h]
        mov ecx, 1
        and eax, byte 1
        mov dword [byte esp+08h], ecx
        mov dword [LinkSentPackets], eax
.12:
        mov eax, dword [LinkSentBytes]
        mov dword [byte ebp+00h], eax
        mov eax, dword [LinkSentErrors]
        mov dword [ebx], eax
        mov eax, dword [LinkSentPackets]
        mov dword [edi], eax
        mov edx, dword [byte esp+01Ch]
        mov eax, dword [LinkRecvBytes]
        mov dword [edx], eax
        mov edx, dword [byte esp+020h]
        mov eax, dword [LinkRecvErrors]
        mov dword [edx], eax
        mov edx, dword [byte esp+024h]
        mov eax, dword [LinkRecvPackets]
        mov dword [edx], eax
        mov eax, dword [byte esp+08h]
.13:
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        ret 0Ch
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; NetInit                                         E3A44  97 PC, low confidence
; From main_: once, starts IPX (IpxInit) and the serial layer, allocates the
; "pktlayer" buffer and marks the network ready (NetActive)
;-----------------------------------------------------------------------------
NetInit:
        push dword 1Ch
        call __CHK
        push ebx
        push ecx
        push edx
        cmp dword [NetActive], byte 0
        je short .1
        xor eax, eax
        pop edx
        pop ecx
        pop ebx
        ret
.1:
        call IpxInit
        mov edx, eax
        mov ebx, eax
        call InitNetSession
        cmp edx, eax
        jge short .2
        mov ebx, eax
.2:
        push byte 20h
        push ebx
        push str_Pktlayer
        call AllocMemBlock
        add esp, byte 0Ch
        push dword 14Ah
        mov ebx, 0BB8h
        push LinkPacketQueues
        mov dword [NetDriverHandle], eax
        mov dword [PacketSize], ebx
        call ZeroMem
        mov ecx, 1
        add esp, byte 8
        mov dword [NetActive], ecx
        mov eax, ecx
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; NetShutdown                                     E3AB8  97 PC, low confidence
; From main_: closes the IPX socket and the serial layer, frees "pktlayer"
;-----------------------------------------------------------------------------
NetShutdown:
        push dword 14h
        call __CHK
        push ebx
        push ecx
        push edx
        cmp dword [NetActive], byte 0
        je short .1
        call IpxCloseSocket
        call ShutdownNetSession
        mov ebx, dword [NetDriverHandle]
        push ebx
        call FreeMemBlock
        xor ecx, ecx
        add esp, byte 4
        mov dword [NetDriverHandle], ecx
        mov dword [NetActive], ecx
.1:
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; StartNetworkLink                                E3AFC  97 PC, low confidence
; Starts a network link game
;-----------------------------------------------------------------------------
StartNetworkLink:
        push dword 128h
        call __CHK
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, 100h
        mov esi, eax
        cmp dword [NetActive], byte 0
        jne short .1
        xor eax, eax
        jmp near .15
.1:
        mov ebx, dword [LinkGameActive]
        test ebx, ebx
        je short .2
        xor eax, eax
        add esp, 100h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.2:
        push dword 14Ah
        push LinkPacketQueues
        call ZeroMem
        add esp, byte 8
        call InitPacketLink
        test byte [dword esi+08Dh], 1
        je near .4
        mov ebx, 1
        mov dword [NetConnected], ebx
        mov eax, dword [byte esi+074h]
        and eax, ebx
        mov word [LinkSequence], ax
        mov eax, dword [byte esi+076h]
        lea edx, [byte esi+07Ah]
        sar eax, 10h
        call HostNetGame
        test eax, eax
        je short .3
        mov ebx, ResendLinkPacket
        mov ecx, dword [NetDriverHandle]
        mov edx, ServiceIdle_34
        push ecx
        lea eax, [byte esi+074h]
        mov ecx, LinkHandle
        call JoinNetworkGame
        test eax, eax
        jne near .12
        call LeaveNetGame
        call ShutdownPacketLink
        xor eax, eax
        add esp, 100h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.3:
        call ShutdownPacketLink
        push byte 0
        mov ecx, ebx
        mov eax, 238h
        mov edx, ecx
        xor ebx, ebx
        call GetLangText
        call ShowMessageBox
        xor eax, eax
        add esp, 100h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.4:
        mov dword [NetConnected], ebx
        mov eax, dword [esi]
        and eax, byte 1
        push dword 0FAh
        mov word [LinkSequence], ax
        lea eax, [byte esp+04h]
        push eax
        call ZeroMem
        add esp, byte 8
        mov al, byte [esp]
        and al, 1Fh
        or al, 80h
        push byte 2
        mov byte [byte esp+04h], al
        lea eax, [byte esp+06h]
        push eax
        mov dl, 2
        push LinkSequence
        mov ebp, 2
        mov byte [byte esp+0Dh], dl
        call bcopy
        mov edx, 0FFFFFFFFh
        lea eax, [dword esp+0108h]
        mov ecx, LinkHandle
        add esp, byte 0Ch
        mov dword [LinkRecvOffset], ebx
        mov dword [LinkRecvSize], ebp
        mov dword [LinkBlockDone], ebx
        mov dword [LinkSendBuffer], eax
        mov eax, 239h
        mov dword [dword esp+0FCh], edx
        call GetLangText
        call ShowLinkMessage
        mov edx, dword [NetDriverHandle]
        mov ebx, ResendLinkPacket
        push edx
        mov eax, esi
        mov edx, ServiceIdle_34
        call OpenNetSession
        test eax, eax
        jne short .5
        call ShutdownPacketLink
        call HideLinkBox
        push byte 0
        mov eax, 23Ah
        mov ecx, 1
        xor ebx, ebx
        mov edx, ecx
        call GetLangText
        call ShowMessageBox
        xor eax, eax
        add esp, 100h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.5:
        cmp word [byte esi+0Ah], byte 0
        je near .11
        xor esi, esi
.6:
        push byte 4
        lea eax, [byte esp+04h]
        push eax
        mov edi, dword [LinkHandle]
        push edi
        call PacketLinkSend
        add esp, byte 0Ch
        test eax, eax
        jne short .8
        mov eax, dword [tickcount]
        cmp eax, dword [LinkServiceTick]
        je short .7
        push esi
        call RunIdleHandlers
        add esp, byte 4
        push esi
        push esi
        call ServiceBackgroundAudio
        add esp, byte 8
        mov eax, dword [tickcount]
        mov dword [LinkServiceTick], eax
.7:
        push byte 1
        call WaitTicks
        add esp, byte 4
        jmp short .6
.8:
        xor esi, esi
.9:
        cmp esi, dword [LinkBlockDone]
        jne short .10
        mov eax, dword [tickcount]
        cmp eax, dword [LinkServiceTick]
        je short .9
        push esi
        call RunIdleHandlers
        add esp, byte 4
        push esi
        push esi
        call ServiceBackgroundAudio
        add esp, byte 8
        mov eax, dword [tickcount]
        mov dword [LinkServiceTick], eax
        jmp short .9
.10:
        mov eax, dword [dword esp+0FCh]
        cmp ax, word [LinkSequence]
        jne short .11
        call HideLinkBox
        push byte 0
        mov eax, 23Bh
        mov ecx, 1
        xor ebx, ebx
        mov edx, ecx
        call GetLangText
        call ShowMessageBox
        call CloseNetSession
        call ShutdownPacketLink
        xor eax, eax
        add esp, 100h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.11:
        call HideLinkBox
.12:
        xor ebx, ebx
        mov ecx, 1
        mov dword [LinkHandshakeDone], ebx
        mov dword [LinkGameActive], ecx
        call dword [PresentFuncInput]
        mov eax, dword [mousex]
        mov si, word [LinkSequence]
        mov dword [LinkSentPackets], ebx
        mov dword [LinkSentBytes], eax
        mov eax, dword [mousey]
        mov dword [LinkRecvPackets], ebx
        mov dword [LinkSentErrors], eax
        test si, si
        je short .13
        mov edx, 4
        mov eax, LinkSentBytes
        call LinkSendBlock
        mov edx, 4
        mov eax, LinkSentErrors
        xor ebx, ebx
        call LinkSendBlock
        mov edx, 4
        mov eax, LinkRecvBytes
        xor ebx, ebx
        call LinkReceiveBlock
        mov edx, 4
        mov eax, LinkRecvErrors
        xor ebx, ebx
        call LinkReceiveBlock
        jmp short .14
.13:
        mov edx, 4
        mov eax, LinkRecvBytes
        call LinkReceiveBlock
        mov edx, 4
        mov eax, LinkRecvErrors
        xor ebx, ebx
        call LinkReceiveBlock
        mov edx, 4
        mov eax, LinkSentBytes
        xor ebx, ebx
        call LinkSendBlock
        mov edx, 4
        mov eax, LinkSentErrors
        xor ebx, ebx
        call LinkSendBlock
.14:
        mov eax, 1
.15:
        add esp, 100h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; NetDisconnect                                   E3E8C  97 PC, low confidence
; Ends a network session with the "Disconnecting" message (IPX or serial),
; then clears the connected flag (LinkGameActive)
;-----------------------------------------------------------------------------
NetDisconnect:
        push dword 14h
        call __CHK
        push ecx
        push edx
        push esi
        cmp dword [NetActive], byte 0
        je short .3
        cmp dword [LinkGameActive], byte 0
        je short .3
        mov eax, str_Disconnecting
        call ShowLinkMessage
        cmp dword [NetConnected], byte 0
        je short .1
        call CloseNetConnection
        call LeaveNetGame
        jmp short .2
.1:
        call CloseNetSession
.2:
        push byte 0
        call RunIdleHandlers
        add esp, byte 4
        push byte 2
        call WaitTicks
        add esp, byte 4
        push byte 0
        call RunIdleHandlers
        add esp, byte 4
        xor esi, esi
        call HideLinkBox
        call ShutdownPacketLink
        mov dword [LinkGameActive], esi
.3:
        pop esi
        pop edx
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; LinkHandshake                                   E3F04  97 PC, low confidence
; Handshake with the other computer
;-----------------------------------------------------------------------------
LinkHandshake:
        push dword 2Ch
        call __CHK
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 8
        mov ebx, edx
        cmp dword [NetActive], byte 0
        je near .24
        cmp dword [LinkGameActive], byte 0
        je near .24
        test eax, eax
        jne short .3
        test ebx, ebx
        je short .3
        cmp dword [LinkTimerActive], byte 0
        jne short .3
        cmp dword [MenuScreenBitmap], byte 8
        je short .1
        mov eax, ebx
        call ShowLinkMessage
        jmp short .2
.1:
        mov eax, ebx
        call ShowLinkWait
.2:
        mov dword [LinkTimerActive], 1
.3:
        mov al, byte [esp]
        and al, 1Fh
        or al, 60h
        mov byte [esp], al
        mov eax, dword [LinkHandshakeDone]
        inc eax
        mov dword [LinkHandshakeDone], eax
        mov dword [byte esp+01h], eax
        mov al, byte [LinkSequence]
        mov byte [byte esp+05h], al
        mov eax, dword [tickcount]
        add eax, byte 19h
        mov dx, word [LinkSequence]
        mov dword [LinkPacketBuffer], eax
        test dx, dx
        je near .13
        xor esi, esi
.4:
        push byte 6
        lea eax, [byte esp+04h]
        push eax
        mov edx, dword [LinkHandle]
        push edx
        call PacketLinkSend
        add esp, byte 0Ch
        test eax, eax
        jne near .8
        push byte 1
        call WaitTicks
        add esp, byte 4
        mov eax, dword [tickcount]
        cmp eax, dword [LinkServiceTick]
        je short .5
        push esi
        call RunIdleHandlers
        add esp, byte 4
        push esi
        push esi
        call ServiceBackgroundAudio
        add esp, byte 8
        mov eax, dword [tickcount]
        mov dword [LinkServiceTick], eax
.5:
        mov eax, dword [tickcount]
        cmp eax, dword [LinkPacketBuffer]
        jle short .4
        test ebx, ebx
        je short .4
        mov ebp, dword [LinkTimerActive]
        cmp esi, ebp
        jne short .4
        test ebx, ebx
        je short .4
        cmp ebp, ebp
        jne short .4
        cmp dword [MenuScreenBitmap], byte 8
        je short .6
        mov eax, ebx
        call ShowLinkMessage
        jmp short .7
.6:
        mov eax, ebx
        call ShowLinkWait
.7:
        mov dword [LinkTimerActive], 1
        jmp near .4
.8:
        xor esi, esi
.9:
        mov edi, dword [LinkHandshakeDone]
        cmp edi, dword [LinkRemoteSequence]
        je near .23
        mov eax, dword [tickcount]
        cmp eax, dword [LinkServiceTick]
        je short .10
        push esi
        call RunIdleHandlers
        add esp, byte 4
        push esi
        push esi
        call ServiceBackgroundAudio
        add esp, byte 8
        mov eax, dword [tickcount]
        mov dword [LinkServiceTick], eax
.10:
        mov eax, dword [tickcount]
        cmp eax, dword [LinkPacketBuffer]
        jle short .9
        test ebx, ebx
        je short .9
        mov ecx, dword [LinkTimerActive]
        cmp esi, ecx
        jne short .9
        test ebx, ebx
        je short .9
        cmp ecx, ecx
        jne short .9
        cmp dword [MenuScreenBitmap], byte 8
        je short .11
        mov eax, ebx
        call ShowLinkMessage
        jmp short .12
.11:
        mov eax, ebx
        call ShowLinkWait
.12:
        mov dword [LinkTimerActive], 1
        jmp near .9
.13:
        xor esi, esi
.14:
        mov edx, dword [LinkHandshakeDone]
        cmp edx, dword [LinkRemoteSequence]
        je near .18
        mov eax, dword [tickcount]
        cmp eax, dword [LinkServiceTick]
        je short .15
        push esi
        call RunIdleHandlers
        add esp, byte 4
        push esi
        push esi
        call ServiceBackgroundAudio
        add esp, byte 8
        mov eax, dword [tickcount]
        mov dword [LinkServiceTick], eax
.15:
        mov eax, dword [tickcount]
        cmp eax, dword [LinkPacketBuffer]
        jle short .14
        test ebx, ebx
        je short .14
        mov ebp, dword [LinkTimerActive]
        cmp esi, ebp
        jne short .14
        test ebx, ebx
        je short .14
        cmp ebp, ebp
        jne short .14
        cmp dword [MenuScreenBitmap], byte 8
        je short .16
        mov eax, ebx
        call ShowLinkMessage
        jmp short .17
.16:
        mov eax, ebx
        call ShowLinkWait
.17:
        mov dword [LinkTimerActive], 1
        jmp near .14
.18:
        xor esi, esi
.19:
        push byte 6
        lea eax, [byte esp+04h]
        push eax
        mov edi, dword [LinkHandle]
        push edi
        call PacketLinkSend
        add esp, byte 0Ch
        test eax, eax
        jne near .23
        push byte 1
        call WaitTicks
        add esp, byte 4
        mov eax, dword [tickcount]
        cmp eax, dword [LinkServiceTick]
        je short .20
        push esi
        call RunIdleHandlers
        add esp, byte 4
        push esi
        push esi
        call ServiceBackgroundAudio
        add esp, byte 8
        mov eax, dword [tickcount]
        mov dword [LinkServiceTick], eax
.20:
        mov eax, dword [tickcount]
        cmp eax, dword [LinkPacketBuffer]
        jle short .19
        test ebx, ebx
        je short .19
        mov ecx, dword [LinkTimerActive]
        cmp esi, ecx
        jne short .19
        test ebx, ebx
        je short .19
        cmp ecx, ecx
        jne short .19
        cmp dword [MenuScreenBitmap], byte 8
        je short .21
        mov eax, ebx
        call ShowLinkMessage
        jmp short .22
.21:
        mov eax, ebx
        call ShowLinkWait
.22:
        mov dword [LinkTimerActive], 1
        jmp near .19
.23:
        mov edx, dword [LinkTimerActive]
        test edx, edx
        je short .24
        je short .24
        xor ecx, ecx
        call HideLinkBox
        mov dword [LinkTimerActive], ecx
.24:
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; LinkSyncMenu                                    E4218  97 PC, low confidence
; Synchronises a menu with the other computer
;-----------------------------------------------------------------------------
LinkSyncMenu:
        push dword 8
        call __CHK
        push edx
        xor edx, edx
        xor eax, eax
        call LinkHandshake
        pop edx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; LinkSyncScreen                                  E4230  97 PC, low confidence
; Synchronises a screen with the other computer
;-----------------------------------------------------------------------------
LinkSyncScreen:
        push dword 8
        call __CHK
        push edx
        mov edx, eax
        xor eax, eax
        call LinkHandshake
        pop edx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; LinkSyncGame                                    E4248  97 PC, low confidence
; Synchronises the start of a game with the other computer
;-----------------------------------------------------------------------------
LinkSyncGame:
        push dword 8
        call __CHK
        push edx
        mov edx, eax
        mov eax, 1
        call LinkHandshake
        pop edx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ClearLinkInputs                                 E4264  97 PC, low confidence
; Clears the link input buffers
;-----------------------------------------------------------------------------
ClearLinkInputs:
        push ecx
        push edx
        push byte 42h
        push LinkPacketQueues+42h
        call ZeroMem
        add esp, byte 8
        push byte 42h
        push LinkPacketQueues+0C6h
        call ZeroMem
        add esp, byte 8
        pop edx
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; LinkInputTick                                   E4288  97 PC, low confidence
; Sends and receives the link inputs each tick
;-----------------------------------------------------------------------------
LinkInputTick:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov edx, 1
        mov ebx, dword [NetActive]
        mov dword [LinkInputChanged], edx
        test ebx, ebx
        jne short .1
        xor eax, eax
        jmp near .11
.1:
        cmp dword [LinkGameActive], byte 0
        jne short .2
        xor eax, eax
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.2:
        cmp word [LinkPacketQueues+106h], byte 4
        jge near .6
        test eax, eax
        jne near .6
        mov ebx, 2000h
        mov edi, 8
        mov dword [LinkInputTickCount], eax
        mov dword [LinkInputSent], eax
        mov dword [LinkInputAck], eax
        mov dword [LinkInputState], eax
        xor edx, edx
        mov word [LinkLocalInput], bx
.3:
        mov ecx, dword [LinkInputTickCount]
        add ecx, ecx
        mov ax, word [dword ecx+SlotWords]
        xor al, al
        and ah, 7
        and eax, 0FFFFh
        sar eax, 8
        test eax, eax
        je short .4
        cmp eax, byte 1
        setne al
        and eax, 0FFh
        je short .4
        mov ax, word [dword ecx+SlotWords]
        xor ah, ah
        and al, 7Fh
        mov ebx, dword [LinkInputState]
        and eax, 0FFFFh
        mov cl, dl
        mov dword [LinkInputAck], eax
        add edx, byte 7
        shl eax, cl
        mov ecx, dword [LinkInputSent]
        or ebx, eax
        inc ecx
        mov dword [LinkInputState], ebx
        mov dword [LinkInputSent], ecx
        cmp ecx, byte 4
        jne short .4
        mov dword [LinkInputTickCount], edi
.4:
        mov ebp, dword [LinkInputTickCount]
        inc ebp
        mov dword [LinkInputTickCount], ebp
        cmp ebp, byte 8
        jl near .3
        xor eax, eax
        mov ax, word [HotKeyFlags]
        mov edx, eax
        mov ebx, dword [LinkInputState]
        shl edx, 1Ch
        or ebx, edx
        mov edx, eax
        mov eax, dword [LinkRemoteInput]
        sar edx, 4
        sar eax, 10h
        or eax, edx
        mov word [LinkLocalInput], ax
        mov eax, dword [LinkRemoteInput]
        push byte 6
        sar eax, 10h
        mov ecx, dword [LinkHandle]
        mov edx, eax
        push LinkLocalInput
        sar edx, 8
        shl eax, 8
        and edx, 0FFh
        push ecx
        or eax, edx
        mov dword [LinkInputState], ebx
        mov word [LinkLocalInput], ax
        call PacketLinkSend
        add esp, byte 0Ch
        test eax, eax
        je short .5
        mov edx, LinkLocalInput
        mov eax, 3
        call QueueLinkPacket
        jmp short .6
.5:
        mov dword [LinkInputChanged], eax
.6:
        mov cx, word [LinkPacketQueues+104h]
        mov ax, word [LinkPacketQueues+102h]
        cmp ax, cx
        setne al
        and eax, 0FFh
        je near .10
        mov si, word [LinkPacketQueues+80h]
        mov ax, word [LinkPacketQueues+7Eh]
        cmp ax, si
        setne al
        and eax, 0FFh
        je near .10
        cmp dword [InputRecordCount], byte 5
        jge near .10
        mov ebp, dword [InputRecordTaken]
        test ebp, ebp
        jne near .10
        mov dword [InputRecordTaken], 1
        mov edx, LinkLocalInput
        mov eax, 3
        call SendLinkPacket
        mov eax, dword [LinkRemoteInput]
        sar eax, 10h
        mov edx, eax
        sar edx, 8
        shl eax, 8
        and edx, 0FFh
        or eax, edx
        mov edx, LinkInputPacket
        mov word [LinkLocalInput], ax
        mov eax, 1
        call SendLinkPacket
        mov eax, dword [LinkInputWordPad]
        sar eax, 10h
        mov edx, eax
        sar edx, 8
        shl eax, 8
        and edx, 0FFh
        or eax, edx
        mov edx, dword [InputRecordHead]
        mov word [LinkInputPacket], ax
        lea eax, [nosplit edx*4+00h]
        add eax, edx
        mov edx, InputRecordRing
        shl eax, 2
        add edx, eax
        mov eax, dword [LinkInputState]
        sar eax, 1Ch
        mov dword [LinkRemoteFlags], edx
        movsx edx, ax
        mov eax, dword [LinkRemoteInput]
        sar eax, 10h
        shl eax, 4
        or eax, edx
        mov edx, dword [LinkInputHigh]
        sar edx, 1Ch
        movsx ecx, dx
        mov edx, dword [LinkInputWordPad]
        sar edx, 10h
        shl edx, 4
        or edx, ecx
        or eax, edx
        mov edx, dword [LinkRemoteFlags]
        mov word [byte edx+010h], ax
        mov dword [LinkInputSent], ebp
        mov dword [LinkInputResend], ebp
        mov dword [LinkInputTickCount], ebp
.7:
        mov eax, dword [LinkInputTickCount]
        mov cx, word [nosplit eax*2+SlotWords]
        mov edx, dword [LinkRemoteFlags]
        and cl, 80h
        mov word [edx+eax*2], cx
        mov ecx, dword [LinkInputTickCount]
        add ecx, ecx
        mov ax, word [dword ecx+SlotWords]
        xor al, al
        and ah, 7
        and eax, 0FFFFh
        sar eax, 8
        test eax, eax
        je near .9
        cmp eax, byte 1
        jne short .8
        mov eax, dword [LinkRemoteFlags]
        mov edx, dword [LinkInputResend]
        add eax, ecx
        imul ecx, edx, byte 7
        mov edx, dword [LinkInputHigh]
        sar edx, cl
        mov bx, word [eax]
        and edx, byte 7Fh
        or ebx, edx
        mov word [eax], bx
        mov ebx, dword [LinkInputResend]
        cmp ebx, byte 3
        jge short .9
        lea ecx, [byte ebx+01h]
        mov dword [LinkInputResend], ecx
        jmp short .9
.8:
        mov eax, dword [LinkRemoteFlags]
        mov esi, dword [LinkInputSent]
        add eax, ecx
        imul ecx, esi, byte 7
        mov edx, dword [LinkInputState]
        sar edx, cl
        mov di, word [eax]
        and edx, byte 7Fh
        or edi, edx
        mov word [eax], di
        mov edi, dword [LinkInputSent]
        cmp edi, byte 3
        jge short .9
        lea ebp, [byte edi+01h]
        mov dword [LinkInputSent], ebp
.9:
        mov esi, dword [LinkInputTickCount]
        inc esi
        mov dword [LinkInputTickCount], esi
        cmp esi, byte 8
        jl near .7
        mov eax, dword [LinkRemoteFlags]
        mov dx, word [LinkFrameDelay]
        mov word [byte eax+012h], dx
        mov edx, dword [InputRecordHead]
        inc edx
        mov ecx, 5
        mov eax, edx
        sar edx, 1Fh
        idiv ecx
        inc dword [InputRecordCount]
        mov dword [InputRecordHead], edx
        rdtsc
        mov dword [InputRecordStamp], eax
        xor eax, eax
        mov dword [InputRecordTaken], eax
.10:
        mov eax, dword [LinkInputChanged]
.11:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; LinkSendBlock                                   E4638  96 PC, low confidence
; (data, length): sends a block to the other side as a type 3 header and type
; 4 messages of 4 bytes, idling while the link is busy
;-----------------------------------------------------------------------------
LinkSendBlock:
        push dword 128h
        call __CHK
        push ecx
        push esi
        push edi
        push ebp
        sub esp, 108h
        mov edi, eax
        mov dword [dword esp+0FCh], edx
        mov dword [dword esp+0104h], ebx
        cmp dword [NetActive], byte 0
        je near .12
        cmp dword [LinkGameActive], byte 0
        je near .12
        xor edx, edx
        xor eax, eax
        mov esi, dword [dword esp+0FCh]
        call LinkHandshake
        xor ebp, ebp
        test esi, esi
        jle near .9
.1:
        mov eax, dword [tickcount]
        cmp eax, ebp
        jle short .4
        mov eax, dword [tickcount]
        cmp eax, dword [LinkServiceTick]
        je short .2
        push byte 0
        call RunIdleHandlers
        add esp, byte 4
        push byte 0
        push byte 0
        call ServiceBackgroundAudio
        add esp, byte 8
        mov eax, dword [tickcount]
        mov dword [LinkServiceTick], eax
.2:
        cmp dword [dword esp+0104h], byte 0
        je short .3
        mov eax, dword [dword esp+0FCh]
        sub eax, esi
        call dword [dword esp+0104h]
.3:
        mov eax, dword [tickcount]
        lea ebp, [byte eax+02h]
.4:
        mov eax, dword [str_Punct_ModemSettingsScreen]
        sub eax, byte 2
        cmp esi, eax
        jle short .5
        mov dword [dword esp+0100h], eax
        jmp short .6
.5:
        mov dword [dword esp+0100h], esi
.6:
        push dword 0FAh
        lea eax, [byte esp+04h]
        push eax
        call ZeroMem
        add esp, byte 8
        mov al, byte [esp]
        and al, 1Fh
        or al, 80h
        mov ecx, dword [dword esp+0100h]
        mov byte [esp], al
        mov al, byte [dword esp+0100h]
        push ecx
        mov byte [byte esp+05h], al
        lea eax, [byte esp+06h]
        push eax
        push edi
        call bcopy
        add esp, byte 0Ch
        mov eax, dword [dword esp+0100h]
        add edi, eax
        lea ebx, [byte eax+02h]
.7:
        push ebx
        lea eax, [byte esp+04h]
        push eax
        mov ecx, dword [LinkHandle]
        push ecx
        call PacketLinkSend
        add esp, byte 0Ch
        test eax, eax
        jne short .8
        push byte 1
        call WaitTicks
        add esp, byte 4
        mov eax, dword [tickcount]
        cmp eax, dword [LinkServiceTick]
        je short .7
        push byte 0
        call RunIdleHandlers
        add esp, byte 4
        push byte 0
        push byte 0
        call ServiceBackgroundAudio
        add esp, byte 8
        mov eax, dword [tickcount]
        mov dword [LinkServiceTick], eax
        jmp short .7
.8:
        sub esi, dword [dword esp+0100h]
        test esi, esi
        jg near .1
.9:
        push dword 0FAh
        lea eax, [byte esp+04h]
        push eax
        call ZeroMem
        add esp, byte 8
        mov al, byte [esp]
        and al, 1Fh
        or al, 80h
        mov byte [esp], al
        xor ah, ah
        mov byte [byte esp+01h], ah
        xor esi, esi
.10:
        push byte 2
        lea eax, [byte esp+04h]
        push eax
        mov edx, dword [LinkHandle]
        push edx
        call PacketLinkSend
        add esp, byte 0Ch
        test eax, eax
        jne short .11
        push byte 1
        call WaitTicks
        add esp, byte 4
        mov eax, dword [tickcount]
        cmp eax, dword [LinkServiceTick]
        je short .10
        push esi
        call RunIdleHandlers
        add esp, byte 4
        push esi
        push esi
        call ServiceBackgroundAudio
        add esp, byte 8
        mov eax, dword [tickcount]
        mov dword [LinkServiceTick], eax
        jmp short .10
.11:
        xor edx, edx
        xor eax, eax
        call LinkHandshake
.12:
        add esp, 108h
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; LinkReceiveBlock                                E4838  96 PC, low confidence
; (dest, length): waits (idling) for the next block from the other side and
; copies it out
;-----------------------------------------------------------------------------
LinkReceiveBlock:
        push dword 1Ch
        call __CHK
        push ecx
        push esi
        push edi
        sub esp, byte 4
        mov esi, eax
        mov edi, edx
        mov dword [esp], ebx
        mov edx, dword [NetActive]
        xor ebx, ebx
        test edx, edx
        je near .6
        cmp dword [LinkGameActive], byte 0
        je near .6
        push edi
        push eax
        call ZeroMem
        add esp, byte 8
        mov dword [LinkSendBuffer], esi
        mov dword [LinkRecvOffset], ebx
        mov dword [LinkRecvSize], edi
        xor edx, edx
        xor eax, eax
        mov dword [LinkBlockDone], ebx
        call LinkHandshake
        cmp dword [LinkBlockDone], byte 0
        jne short .5
.1:
        mov eax, dword [tickcount]
        cmp eax, ebx
        jle short .4
        mov eax, dword [tickcount]
        cmp eax, dword [LinkServiceTick]
        je short .2
        push byte 0
        call RunIdleHandlers
        add esp, byte 4
        push byte 0
        push byte 0
        call ServiceBackgroundAudio
        add esp, byte 8
        mov eax, dword [tickcount]
        mov dword [LinkServiceTick], eax
.2:
        cmp dword [esp], byte 0
        je short .3
        mov eax, dword [LinkRecvOffset]
        call dword [esp]
.3:
        mov eax, dword [tickcount]
        lea ebx, [byte eax+02h]
.4:
        cmp dword [LinkBlockDone], byte 0
        je short .1
.5:
        xor edx, edx
        xor eax, eax
        call LinkHandshake
.6:
        add esp, byte 4
        pop edi
        pop esi
        pop ecx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; WaitForOtherComputer                            E4908  97 PC, low confidence
; The "Waiting for other computer" box: shows it and syncs with the other
; side
;-----------------------------------------------------------------------------
WaitForOtherComputer:
        push dword 1D0h
        call __CHK
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, 1A0h
        xor edx, edx
        mov ebx, dword [NetActive]
        mov dword [dword esp+017Ch], edx
        test ebx, ebx
        je near .50
        cmp dword [LinkGameActive], byte 0
        je near .50
        mov esi, dword [ViewScreenWidth]
        mov eax, dword [ViewScreenWidth]
        sar esi, 3
        sub eax, esi
        mov esi, eax
        mov eax, dword [ViewScreenHeight]
        mov edx, dword [ViewScreenHeight]
        sar eax, 3
        mov ebp, dword [ViewScreenWidth]
        sub edx, eax
        sar ebp, 7
        mov dword [dword esp+0168h], edx
        mov eax, dword [ViewScreenHeight]
        mov edi, dword [dword esp+0168h]
        sar eax, 4
        mov edx, esi
        mov dword [dword esp+0170h], eax
        lea eax, [nosplit ebp*2+00h]
        sar edi, 1
        sub edx, eax
        sub edi, dword [LinkTextFont]
        mov ecx, dword [LinkTextFont]
        sub edi, byte 7
        mov dword [dword esp+0194h], edx
        mov edx, edi
        mov eax, edi
        sar edx, 1Fh
        idiv ecx
        imul eax, ecx
        inc eax
        mov edx, ecx
        mov dword [dword esp+0150h], eax
        mov ecx, eax
        sub edi, eax
        mov eax, dword [dword esp+0168h]
        add edi, edi
        sub eax, edi
        mov dword [dword esp+0168h], eax
        mov eax, dword [dword esp+0194h]
        mov dword [dword esp+0150h], eax
        mov dword [dword esp+0154h], eax
        mov eax, dword [dword esp+0170h]
        add eax, byte 5
        add edx, eax
        mov edi, ecx
        mov dword [dword esp+015Ch], edx
        lea eax, [edx+edi]
        mov edx, dword [LinkTextFont]
        add eax, byte 5
        mov ebx, dword [ViewScreenWidth]
        add eax, edx
        sar ebx, 4
        add eax, byte 2
        add ebp, ebx
        mov dword [dword esp+0174h], eax
        xor ah, ah
        mov ecx, dword [MenuScreenBitmap]
        mov byte [esp], ah
        mov byte [dword esp+0A0h], ah
        mov byte [dword esp+019Dh], ah
        mov byte [dword esp+019Ch], ah
        cmp ecx, byte 8
        je short .1
        push byte 0
        mov edx, dword [dword esp+016Ch]
        push edx
        push esi
        call CreateBitmap
        mov dword [dword esp+016Ch], eax
        add esp, byte 0Ch
        mov dword [dword esp+016Ch], eax
        mov eax, dword [byte eax+02Ch]
        mov word [byte eax+0Ch], bx
        mov eax, dword [dword esp+0160h]
        mov eax, dword [byte eax+02Ch]
        mov edx, dword [dword esp+0170h]
        mov word [byte eax+0Eh], dx
        call SetScreenTarget
        mov eax, dword [dword esp+0160h]
        mov ecx, dword [byte eax+02Ch]
        push ecx
        call ConvertArtKeepPos
        add esp, byte 4
        call PresentScreen
        jmp short .2
.1:
        xor eax, eax
        mov dword [dword esp+016Ch], eax
.2:
        call SetScreenTarget
        push dword 0FF000000h
        call MakeColor
        add esp, byte 4
        push eax
        mov eax, dword [dword esp+016Ch]
        push eax
        push esi
        mov edx, dword [dword esp+017Ch]
        push edx
        push ebx
        call FillRect
        add esp, byte 14h
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        mov ecx, dword [dword esp+0168h]
        push eax
        mov eax, dword [dword esp+0174h]
        add eax, ecx
        dec eax
        push eax
        lea eax, [ebx+esi]
        mov dword [dword esp+0168h], eax
        dec eax
        push eax
        mov eax, dword [dword esp+017Ch]
        push eax
        push ebx
        call FillRectCorners
        add esp, byte 14h
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        push eax
        mov eax, dword [dword esp+0160h]
        sub eax, byte 2
        push eax
        mov edx, dword [dword esp+0168h]
        push edx
        push eax
        push ebx
        call FillRectColor
        add esp, byte 14h
        mov eax, dword [dword esp+0170h]
        mov ecx, dword [MenuScreenBitmap]
        add eax, byte 2
        cmp ecx, byte 8
        je short .3
        push eax
        mov eax, 23Ch
        call GetLangText
        push eax
        call MeasureText
        mov edx, dword [ViewScreenWidth]
        sar eax, 1
        sar edx, 1
        add esp, byte 4
        sub edx, eax
        push edx
        mov eax, 23Ch
        jmp short .4
.3:
        push eax
        mov eax, 77h
        call GetLangText
        push eax
        call MeasureText
        mov edx, dword [ViewScreenWidth]
        sar eax, 1
        sar edx, 1
        add esp, byte 4
        sub edx, eax
        push edx
        mov eax, 77h
.4:
        call GetLangText
        push eax
        call DrawTextAt
        add esp, byte 0Ch
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        push eax
        mov eax, dword [dword esp+0160h]
        add eax, edi
        inc eax
        push eax
        lea edx, [ebx+esi]
        push edx
        push eax
        push ebx
        call FillRectColor
        add esp, byte 14h
        mov eax, dword [dword esp+0174h]
        mov edx, dword [LinkTextFont]
        sub eax, byte 4
        mov ecx, dword [MenuScreenBitmap]
        sub eax, edx
        cmp ecx, byte 8
        je short .5
        push eax
        mov eax, 23Ch
        call GetLangText
        push eax
        call MeasureText
        mov edx, dword [ViewScreenWidth]
        sar eax, 1
        sar edx, 1
        add esp, byte 4
        sub edx, eax
        push edx
        mov eax, 0F7h
        jmp short .6
.5:
        push eax
        mov eax, 75h
        call GetLangText
        push eax
        call MeasureText
        mov edx, dword [ViewScreenWidth]
        sar eax, 1
        sar edx, 1
        add esp, byte 4
        sub edx, eax
        push edx
        mov eax, 75h
.6:
        call GetLangText
        push eax
        call DrawTextAt
        add esp, byte 0Ch
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        push eax
        mov eax, dword [dword esp+0178h]
        sub eax, byte 2
        push eax
        add esi, ebx
        push esi
        push eax
        push ebx
        call FillRectColor
        add esp, byte 14h
        call PresentScreen
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        call SetTextColor
        xor edx, edx
        xor eax, eax
        call LinkHandshake
        push byte 42h
        xor edx, edx
        push LinkPacketQueues+84h
        mov word [LinkWaitCount], dx
        mov word [LinkWaitTimer], dx
        call ZeroMem
        add esp, byte 8
        xor ebx, ebx
.7:
        push byte 1
        call IsKeyDown
        add esp, byte 4
        test eax, eax
        jne short .8
        call KbdGetKey
        cmp eax, byte 1Bh
        jne short .9
.8:
        mov eax, dword [tickcount]
        cmp eax, dword [LinkServiceTick]
        je short .7
        push ebx
        call RunIdleHandlers
        add esp, byte 4
        push ebx
        push ebx
        call ServiceBackgroundAudio
        add esp, byte 8
        mov eax, dword [tickcount]
        mov dword [LinkServiceTick], eax
        jmp short .7
.9:
        xor edx, edx
        xor eax, eax
        call LinkHandshake
        mov eax, dword [LinkAbortPad]
        sar eax, 10h
        test eax, eax
        je short .10
        mov edx, 4
        lea eax, [dword esp+0150h]
        xor ebx, ebx
        call LinkSendBlock
        mov edx, 4
        lea eax, [dword esp+0154h]
        xor ebx, ebx
        call LinkReceiveBlock
        jmp short .11
.10:
        mov edx, 4
        lea eax, [dword esp+0154h]
        xor ebx, ebx
        call LinkReceiveBlock
        mov edx, 4
        lea eax, [dword esp+0150h]
        xor ebx, ebx
        call LinkSendBlock
.11:
        xor edx, edx
        xor eax, eax
        call LinkHandshake
        mov eax, dword [dword esp+0154h]
        cmp eax, dword [dword esp+0150h]
        jge short .12
        mov dword [dword esp+0150h], eax
.12:
        mov eax, dword [dword esp+015Ch]
        mov dword [dword esp+0180h], eax
        call SetScreenTarget
        push dword 0FFAA0000h
        mov esi, dword [dword esp+0178h]
        mov dword [dword esp+0188h], ebp
        call MakeColor
        add esp, byte 4
        push eax
        mov eax, dword [LinkTextFont]
        sub eax, byte 2
        push eax
        push str_X_WaitForOtherComputer
        call MeasureText
        add esp, byte 4
        sub eax, byte 2
        push eax
        mov eax, dword [dword esp+0168h]
        inc eax
        push eax
        mov ebx, ebp
        lea eax, [byte ebp+01h]
        push eax
        mov dword [dword esp+0174h], eax
        call FillRect
        add esp, byte 14h
        push dword 0FF00AA00h
        call MakeColor
        add esp, byte 4
        push eax
        mov eax, dword [LinkTextFont]
        sub eax, byte 2
        push eax
        push str_X_WaitForOtherComputer
        call MeasureText
        add esp, byte 4
        sub eax, byte 2
        push eax
        lea eax, [byte esi+01h]
        push eax
        mov edx, dword [dword esp+0170h]
        push edx
        call FillRect
        add esp, byte 14h
        call PresentScreen
        mov eax, dword [tickcount]
        cmp eax, dword [LinkServiceTick]
        je short .13
        push byte 0
        call RunIdleHandlers
        add esp, byte 4
        push byte 0
        push byte 0
        call ServiceBackgroundAudio
        add esp, byte 8
        mov eax, dword [tickcount]
        mov dword [LinkServiceTick], eax
.13:
        mov eax, dword [tickcount]
        dec eax
        mov dword [dword esp+0178h], eax
        mov eax, dword [dword esp+0174h]
        add eax, edi
        mov dword [dword esp+0190h], eax
        mov eax, dword [dword esp+015Ch]
        add eax, edi
        mov dword [dword esp+0158h], eax
.14:
        call KbdGetKey
        mov dword [dword esp+0188h], eax
        test eax, eax
        je near .23
        cmp eax, byte 1Bh
        je near .23
        cmp eax, byte 1Fh
        jle short .15
        cmp eax, byte 7Eh
        jl short .16
.15:
        mov ecx, dword [dword esp+0188h]
        cmp ecx, byte 0Dh
        je short .16
        cmp ecx, byte 8
        jne near .24
.16:
        mov edi, dword [LinkPacketQueues+148h]
        sar edi, 10h
        lea edx, [byte edi+01h]
        mov ecx, 14h
        mov eax, edx
        sar edx, 1Fh
        idiv ecx
        mov eax, dword [LinkWaitCount]
        sar eax, 10h
        cmp edx, eax
        je near .24
        mov al, byte [dword esp+0188h]
        mov word [LinkWaitCount], dx
        mov byte [dword edi+LinkPlayerReady], al
        call SetScreenTarget
        push dword 0FF000000h
        call MakeColor
        add esp, byte 4
        push eax
        mov eax, dword [LinkTextFont]
        sub eax, byte 2
        push eax
        push str_X_WaitForOtherComputer
        call MeasureText
        add esp, byte 4
        sub eax, byte 2
        push eax
        mov eax, dword [dword esp+018Ch]
        inc eax
        push eax
        mov eax, dword [dword esp+0194h]
        inc eax
        push eax
        call FillRect
        add esp, byte 14h
        cmp dword [dword esp+0188h], byte 0Dh
        je near .18
        mov eax, esp
        mov edx, dword [dword esp+0188h]
        call strlen_
        mov dword [LinkInputTickCount], eax
        cmp edx, byte 8
        je short .17
        lea edx, [byte eax+01h]
        mov dword [LinkInputTickCount], edx
        mov dl, byte [dword esp+0188h]
        mov ecx, dword [dword esp+0180h]
        mov byte [esp+eax], dl
        mov edi, dword [dword esp+0184h]
        mov eax, dword [LinkInputTickCount]
        xor dl, dl
        push ecx
        mov byte [byte esp+eax+04h], dl
        mov al, byte [dword esp+018Ch]
        push edi
        mov byte [dword esp+01A4h], al
        lea eax, [dword esp+01A4h]
        push eax
        call DrawTextAt
        add esp, byte 0Ch
        lea eax, [dword esp+019Ch]
        push eax
        call MeasureText
        add esp, byte 4
        lea edx, [edi+eax]
        mov dword [dword esp+0184h], edx
        jmp near .18
.17:
        test eax, eax
        jle short .18
        dec eax
        mov dword [LinkInputTickCount], eax
        mov al, byte [esp+eax]
        mov byte [dword esp+019Ch], al
        lea eax, [dword esp+019Ch]
        push eax
        call MeasureText
        add esp, byte 4
        mov ecx, dword [dword esp+0184h]
        sub ecx, eax
        push dword 0FF000000h
        mov dword [dword esp+0188h], ecx
        call MakeColor
        add esp, byte 4
        push eax
        mov edi, dword [LinkTextFont]
        push edi
        lea eax, [dword esp+01A4h]
        push eax
        call MeasureText
        add esp, byte 4
        push eax
        mov eax, dword [dword esp+018Ch]
        push eax
        mov edx, dword [dword esp+0194h]
        push edx
        call FillRect
        mov eax, dword [LinkInputTickCount]
        add esp, byte 14h
        xor ch, ch
        mov byte [esp+eax], ch
.18:
        cmp dword [dword esp+0188h], byte 0Dh
        je short .19
        push str_X_WaitForOtherComputer
        call MeasureText
        add esp, byte 4
        mov edi, dword [dword esp+0184h]
        mov edx, dword [dword esp+0150h]
        add eax, edi
        add edx, ebp
        cmp eax, edx
        jle near .22
.19:
        xor dh, dh
        mov eax, dword [LinkTextFont]
        mov byte [esp], dh
        mov edx, dword [dword esp+0180h]
        mov ecx, dword [LinkTextFont]
        add edx, eax
        mov eax, dword [dword esp+0158h]
        mov dword [dword esp+0184h], ebp
        sub eax, ecx
        mov dword [dword esp+0180h], edx
        cmp eax, edx
        jg short .20
        mov eax, dword [dword esp+015Ch]
        mov dword [dword esp+0180h], eax
.20:
        push dword 0FF000000h
        call MakeColor
        add esp, byte 4
        push eax
        mov eax, dword [LinkTextFont]
        push eax
        mov edx, dword [dword esp+019Ch]
        push edx
        mov ecx, dword [dword esp+018Ch]
        push ecx
        mov edi, dword [dword esp+0194h]
        push edi
        call FillRect
        add esp, byte 14h
        mov eax, dword [LinkTextFont]
        mov edi, dword [dword esp+0180h]
        mov edx, dword [LinkTextFont]
        add edi, eax
        mov eax, dword [dword esp+0158h]
        sub eax, edx
        cmp edi, eax
        jl short .21
        mov edi, dword [dword esp+015Ch]
.21:
        push dword 0FF000000h
        call MakeColor
        add esp, byte 4
        push eax
        mov ecx, dword [LinkTextFont]
        push ecx
        mov eax, dword [dword esp+019Ch]
        push eax
        push edi
        mov edx, dword [dword esp+0194h]
        push edx
        call FillRect
        add esp, byte 14h
.22:
        push dword 0FFAA0000h
        call MakeColor
        add esp, byte 4
        push eax
        mov eax, dword [LinkTextFont]
        sub eax, byte 2
        push eax
        push str_X_WaitForOtherComputer
        call MeasureText
        add esp, byte 4
        sub eax, byte 2
        push eax
        mov eax, dword [dword esp+018Ch]
        inc eax
        push eax
        mov eax, dword [dword esp+0194h]
        inc eax
        push eax
        call FillRect
        add esp, byte 14h
        call PresentScreen
        jmp short .24
.23:
        cmp dword [dword esp+0188h], byte 1Bh
        jne short .24
        xor edx, edx
        mov eax, 1
        mov dword [dword esp+0188h], edx
        mov dword [dword esp+017Ch], eax
.24:
        cmp dword [dword esp+017Ch], byte 0
        je short .26
        cmp dword [dword esp+0188h], byte 1Bh
        je short .26
        mov edi, dword [LinkPacketQueues+148h]
        mov ecx, 14h
        sar edi, 10h
        xor eax, eax
        lea edx, [byte edi+01h]
        mov dword [dword esp+017Ch], eax
        mov eax, edx
        sar edx, 1Fh
        idiv ecx
        mov eax, dword [LinkWaitCount]
        sar eax, 10h
        cmp edx, eax
        je short .25
        mov cl, 1Bh
        mov word [LinkWaitCount], dx
        mov byte [dword edi+LinkPlayerReady], cl
.25:
        mov dword [dword esp+0188h], 1Bh
.26:
        mov ecx, dword [dword esp+0178h]
        mov eax, dword [tickcount]
        cmp eax, ecx
        jle near .37
        mov cx, word [LinkWaitCount]
        mov ax, word [LinkWaitTimer]
        cmp ax, cx
        je near .37
        xor edi, edi
        mov dword [dword esp+0198h], edi
        cmp ax, cx
        je short .28
        mov edi, 14h
.27:
        cmp dword [dword esp+0198h], byte 4
        jge short .28
        mov eax, dword [LinkWaitCount]
        sar eax, 10h
        mov edx, dword [dword esp+0198h]
        mov al, byte [dword eax+LinkPlayerReady]
        mov byte [dword esp+edx+014Ah], al
        mov edx, dword [LinkWaitCount]
        sar edx, 10h
        inc edx
        mov eax, edx
        sar edx, 1Fh
        idiv edi
        mov eax, dword [dword esp+0198h]
        inc eax
        mov word [LinkWaitTimer], dx
        mov dword [dword esp+0198h], eax
        mov eax, edx
        cmp ax, word [LinkWaitCount]
        jne short .27
.28:
        mov al, byte [dword esp+0198h]
        mov byte [dword esp+0149h], al
        mov al, byte [dword esp+0148h]
        and al, 1Fh
        or al, 40h
        mov byte [dword esp+0148h], al
        mov eax, dword [tickcount]
        mov edx, dword [LinkFrameDelay]
        shl edx, 2
        add eax, edx
        mov dword [LinkPacketBuffer], eax
        xor edi, edi
.29:
        push byte 6
        lea eax, [dword esp+014Ch]
        push eax
        mov ecx, dword [LinkHandle]
        push ecx
        call PacketLinkSend
        add esp, byte 0Ch
        test eax, eax
        jne near .35
        push byte 1
        call WaitTicks
        mov ecx, dword [MenuScreenBitmap]
        add esp, byte 4
        cmp ecx, byte 8
        je short .31
        mov eax, 237h
        call GetLangText
        test eax, eax
        je short .34
        cmp edi, dword [LinkTimerActive]
        jne short .34
        cmp dword [MenuScreenBitmap], byte 8
        je short .30
        call ShowLinkMessage
        jmp short .33
.30:
        call ShowLinkWait
        jmp short .33
.31:
        cmp edi, str_WaitingForOtherComputer
        je short .34
        cmp edi, dword [LinkTimerActive]
        jne short .34
        cmp ecx, ecx
        je short .32
        mov eax, str_WaitingForOtherComputer
        call ShowLinkMessage
        jmp short .33
.32:
        mov eax, str_WaitingForOtherComputer
        call ShowLinkWait
.33:
        mov dword [LinkTimerActive], 1
.34:
        mov eax, dword [tickcount]
        cmp eax, dword [LinkServiceTick]
        je near .29
        push edi
        call RunIdleHandlers
        add esp, byte 4
        push edi
        push edi
        call ServiceBackgroundAudio
        add esp, byte 8
        mov eax, dword [tickcount]
        mov dword [LinkServiceTick], eax
        jmp near .29
.35:
        mov edi, dword [LinkTimerActive]
        test edi, edi
        je short .36
        je short .36
        xor edx, edx
        call HideLinkBox
        mov dword [LinkTimerActive], edx
.36:
        mov eax, dword [tickcount]
        mov edx, dword [LinkFrameDelay]
        add edx, eax
        mov dword [dword esp+0178h], edx
.37:
        mov cx, word [LinkPacketQueues+0C2h]
        cmp cx, word [LinkPacketQueues+0C0h]
        je near .47
        mov eax, dword [LinkPacketQueues+0C0h]
        xor ecx, ecx
        sar eax, 10h
        mov dword [dword esp+0164h], ecx
        mov dword [dword esp+018Ch], eax
.38:
        mov eax, dword [LinkPacketQueues+0BEh]
        mov edi, dword [dword esp+018Ch]
        sar eax, 10h
        cmp eax, edi
        je near .47
        cmp dword [dword esp+0164h], byte 1Bh
        je near .47
        lea edx, [dword esp+0140h]
        mov eax, 2
        call SendLinkPacket
        xor edx, edx
        mov dword [dword esp+0198h], edx
.39:
        xor eax, eax
        mov ecx, dword [dword esp+0198h]
        mov al, byte [dword esp+0141h]
        cmp eax, ecx
        jle short .38
        cmp dword [dword esp+0164h], byte 1Bh
        je short .38
        xor eax, eax
        mov al, byte [dword esp+ecx+0142h]
        mov dword [dword esp+0164h], eax
        cmp eax, byte 1Bh
        je near .46
        call SetScreenTarget
        push dword 0FF000000h
        call MakeColor
        add esp, byte 4
        push eax
        mov eax, dword [LinkTextFont]
        sub eax, byte 2
        push eax
        push str_X_WaitForOtherComputer
        call MeasureText
        add esp, byte 4
        sub eax, byte 2
        push eax
        lea eax, [byte esi+01h]
        push eax
        lea eax, [byte ebx+01h]
        push eax
        call FillRect
        add esp, byte 14h
        mov edx, dword [dword esp+0164h]
        cmp edx, byte 0Dh
        je near .41
        lea eax, [dword esp+0A0h]
        call strlen_
        mov dword [LinkInputTickCount], eax
        cmp edx, byte 8
        je short .40
        lea edx, [byte eax+01h]
        mov dword [LinkInputTickCount], edx
        mov dl, byte [dword esp+0164h]
        mov byte [dword esp+eax+0A0h], dl
        mov eax, dword [LinkInputTickCount]
        xor dl, dl
        push esi
        mov byte [dword esp+eax+0A4h], dl
        mov al, byte [dword esp+0168h]
        push ebx
        mov byte [dword esp+01A4h], al
        lea eax, [dword esp+01A4h]
        push eax
        call DrawTextAt
        add esp, byte 0Ch
        lea eax, [dword esp+019Ch]
        push eax
        call MeasureText
        add esp, byte 4
        add ebx, eax
        jmp short .41
.40:
        test eax, eax
        jle short .41
        dec eax
        mov dword [LinkInputTickCount], eax
        mov al, byte [dword esp+eax+0A0h]
        mov byte [dword esp+019Ch], al
        lea eax, [dword esp+019Ch]
        push eax
        call MeasureText
        add esp, byte 4
        push dword 0FF000000h
        sub ebx, eax
        call MakeColor
        add esp, byte 4
        push eax
        mov edi, dword [LinkTextFont]
        push edi
        lea eax, [dword esp+01A4h]
        push eax
        call MeasureText
        add esp, byte 4
        push eax
        push esi
        push ebx
        call FillRect
        mov eax, dword [LinkInputTickCount]
        add esp, byte 14h
        xor ch, ch
        mov byte [dword esp+eax+0A0h], ch
.41:
        cmp dword [dword esp+0164h], byte 0Dh
        je short .42
        push str_X_WaitForOtherComputer
        call MeasureText
        add esp, byte 4
        lea edi, [ebx+eax]
        mov eax, dword [dword esp+0154h]
        add eax, ebp
        cmp edi, eax
        jle near .45
.42:
        xor dh, dh
        mov byte [dword esp+0A0h], dh
        mov edx, dword [LinkTextFont]
        mov eax, dword [dword esp+0190h]
        add esi, edx
        sub eax, edx
        mov ebx, ebp
        cmp esi, eax
        jl short .43
        mov esi, dword [dword esp+0174h]
.43:
        push dword 0FF000000h
        call MakeColor
        add esp, byte 4
        push eax
        mov edi, dword [LinkTextFont]
        push edi
        mov eax, dword [dword esp+019Ch]
        push eax
        push esi
        push ebx
        call FillRect
        mov edi, dword [LinkTextFont]
        add esp, byte 14h
        mov edx, dword [LinkTextFont]
        mov eax, dword [dword esp+0190h]
        add edi, esi
        sub eax, edx
        cmp edi, eax
        jl short .44
        mov edi, dword [dword esp+0174h]
.44:
        push dword 0FF000000h
        call MakeColor
        add esp, byte 4
        push eax
        mov ecx, dword [LinkTextFont]
        push ecx
        mov eax, dword [dword esp+019Ch]
        push eax
        push edi
        push ebx
        call FillRect
        add esp, byte 14h
.45:
        push dword 0FF00AA00h
        call MakeColor
        add esp, byte 4
        push eax
        mov eax, dword [LinkTextFont]
        sub eax, byte 2
        push eax
        push str_X_WaitForOtherComputer
        call MeasureText
        add esp, byte 4
        sub eax, byte 2
        push eax
        lea eax, [byte esi+01h]
        push eax
        lea eax, [byte ebx+01h]
        push eax
        call FillRect
        add esp, byte 14h
        call PresentScreen
.46:
        inc dword [dword esp+0198h]
        jmp near .39
.47:
        mov eax, dword [tickcount]
        cmp eax, dword [LinkServiceTick]
        je short .48
        push byte 0
        call RunIdleHandlers
        add esp, byte 4
        push byte 0
        push byte 0
        call ServiceBackgroundAudio
        add esp, byte 8
        mov eax, dword [tickcount]
        mov dword [LinkServiceTick], eax
.48:
        cmp dword [dword esp+0188h], byte 1Bh
        je short .49
        cmp dword [dword esp+0164h], byte 1Bh
        jne near .14
.49:
        xor edx, edx
        xor eax, eax
        call LinkHandshake
        cmp dword [dword esp+016Ch], byte 0
        je short .50
        call SetScreenTarget
        mov eax, dword [dword esp+016Ch]
        mov ebx, dword [byte eax+02Ch]
        push ebx
        call BlitShape2
        add esp, byte 4
        call PresentScreen
        mov ecx, dword [dword esp+016Ch]
        push ecx
        call FreeBitmap
        add esp, byte 4
.50:
        add esp, 1A0h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
