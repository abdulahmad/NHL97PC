; Packet link: checksums, packets, acks, polling and the link channel.
bits 32
%include "hockey.inc"
section s_37042 progbits alloc exec nowrite align=1
extern AddExitHandler, addtimer, AllocMemData, assfwatch_1EC, bcopy, FillMem, FreeMemBlock, LinkChannelA
extern LinkChannelAData, LinkChannelB, LinkChannelBData, PacketChecksum, PacketLinkMode, PacketLinkOpen, PacketSize, QueueCount
extern QueueFindPacket, QueueFreeAll, QueueInit, QueueInsert, QueueNoOp, QueuePeek, QueuePostBuffer, QueuePrepend
extern QueueRemoveEntry, QueueRepost, QueueTakeHead, RemoveTimerCallback, RunIdleHandlers, SeasonGameScreen_13F, SeasonGameScreen_14D, SeasonGameScreen_17B
extern SeasonGameScreen_182, SeasonGameScreen_1DA, SeasonGameScreen_1E3, SeasonGameScreen_1EC, SeasonGameScreen_1F3, SeasonGameScreen_238, SeasonGameScreen_2B1, SeasonGameScreen_2CF
extern SeasonGameScreen_3D3, SeasonGameScreen_3DF, SeasonGameScreen_3EB, str_Pktbuffer, WaitTicks
global PutChecksum, VerifyPacketChecksum, BuildPacketHeader, SendPacket, SendPacket_DE, SendAckPacket, AckPackets, MarkPacketAcked
global FreeLinkChannel, ParsePacket, ReceivePackets, LinkGetDevice, LinkCountdown, LinkResendIfDue, LinkPoll, LinkPoll_24C
global InitPacketLink, ShutdownPacketLink, OpenPacketLink, PacketLinkSend, ClosePacketLink, SeasonGameMenuJumpTable, SeasonOpponentJumpTable, SeasonOpponentTextJumpTable
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; PutChecksum                                     37044  97 PC, low confidence
; Packet link: computes a checksum with the given function and stores it
; big-endian at the end of a buffer
;-----------------------------------------------------------------------------
PutChecksum:
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov dword [esp], eax
        mov ebp, edx
        mov esi, ebx
        mov edi, ecx
        mov ebx, dword [byte esp+014h]
        test ebx, ebx
        je short .2
        push byte 0
        push ebx
        push esi
        call FillMem
        add esp, byte 0Ch
        push edi
        push ebp
        call dword [byte esp+08h]
        add esp, byte 8
        mov edx, eax
        lea eax, [ebx+esi]
        dec esi
.1:
        dec eax
        dec ebx
        cmp eax, esi
        je short .2
        mov byte [eax], dl
        shr edx, 8
        jmp short .1
.2:
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        ret 4
;-----------------------------------------------------------------------------
; VerifyPacketChecksum                            3708C  97 PC, low confidence
; Packet link: recomputes a received packet's checksum and compares it
;-----------------------------------------------------------------------------
VerifyPacketChecksum:
        push esi
        push edi
        push ebp
        sub esp, byte 0Ch
        mov dword [byte esp+08h], eax
        mov dword [byte esp+04h], edx
        mov edi, ebx
        mov ebx, ecx
        mov ebp, dword [byte eax+028h]
        test ebp, ebp
        je short .2
        push ebp
        lea eax, [byte esp+04h]
        push eax
        push edi
        call bcopy
        add esp, byte 0Ch
        mov eax, dword [byte esp+08h]
        mov ecx, ebx
        mov edx, dword [byte eax+028h]
        mov ebx, edi
        push edx
        mov eax, dword [dword eax+0C0h]
        mov edx, dword [byte esp+08h]
        mov esi, ebp
        call PutChecksum
        lea eax, [edi+ebp]
.1:
        dec esi
        dec eax
        cmp esi, byte 0FFFFFFFFh
        je short .2
        mov dl, byte [eax]
        cmp dl, byte [esp+esi]
        je short .1
        push ebp
        push edi
        lea eax, [byte esp+08h]
        push eax
        call bcopy
        add esp, byte 0Ch
        xor eax, eax
        jmp short .3
.2:
        mov eax, 1
.3:
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        ret
        db 08Dh,040h,00h
        push ebx
        push ecx
        push edx
        mov ebx, eax
        add eax, 88h
        push eax
        call QueueFindPacket
        add esp, byte 4
        cmp eax, byte 0FFFFFFFFh
        jne short .4
        mov eax, dword [dword ebx+084h]
.4:
        dec eax
        mov edx, dword [byte ebx+08h]
        mov edx, dword [byte edx+08h]
        and al, 7Fh
        mov dword [byte ebx+03Ch], edx
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; BuildPacketHeader                               37134  97 PC, low confidence
; Packet link: packet header (sequence number, 0FEh marker, kind) and payload
; copy, interrupts off around the counter
;-----------------------------------------------------------------------------
BuildPacketHeader:
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov esi, eax
        mov edi, ebx
        add eax, byte 10h
        mov ebx, dword [byte edx+028h]
        add ebx, eax
        pushf
        pop eax
        and eax, 200h
        cli
        mov dword [esp], ebx
        mov ebx, dword [byte edx+040h]
        lea ebp, [byte ebx+01h]
        mov dword [byte edx+040h], ebp
        mov dword [byte esi+04h], ebx
        pushf
        and dword [esp], 0FFFFFDFFh
        or dword [esp], eax
        popf
        mov dl, byte [byte esi+04h]
        and dl, 7Fh
        push ecx
        mov byte [byte esi+0Eh], dl
        mov edx, dword [byte esp+04h]
        mov dword [byte esi+08h], 0FFFFFFFFh
        push edx
        mov byte [byte esi+0Ch], 0FEh
        push edi
        mov byte [byte esi+0Dh], cl
        call bcopy
        add esp, byte 0Ch
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; SendPacket                                      37198  97 PC, low confidence
; Packet link: sends a queued packet when the device has room
;-----------------------------------------------------------------------------
SendPacket:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 0Ch
        mov edi, eax
        mov esi, edx
        xor eax, eax
        mov al, byte [byte edi+0Dh]
        mov ebx, dword [byte edx+028h]
        add eax, byte 4
        add ebx, eax
        mov eax, dword [byte edx+08h]
        mov dword [byte esp+08h], eax
        mov eax, dword [byte edx+04h]
        mov edx, dword [byte esp+08h]
        push edx
        xor ebp, ebp
        call dword [byte eax+0Ch]
        add esp, byte 4
        cmp eax, ebx
        jb near .2
        mov ebx, esi
        lea eax, [dword esi+088h]
        push eax
        call QueueFindPacket
        add esp, byte 4
        cmp eax, byte 0FFFFFFFFh
        jne short .1
        mov eax, dword [dword esi+084h]
.1:
        dec eax
        mov ecx, dword [byte ebx+08h]
        mov ecx, dword [byte ecx+08h]
        and al, 7Fh
        mov dword [byte ebx+03Ch], ecx
        and eax, 0FFh
        xor ebx, ebx
        mov ecx, dword [byte esi+028h]
        mov bl, byte [byte edi+0Dh]
        mov byte [byte edi+0Fh], al
        add ebx, byte 4
        xor eax, eax
        add ecx, ebx
        mov al, byte [byte edi+0Dh]
        mov dword [esp], ecx
        mov ebx, dword [byte esi+028h]
        add eax, byte 4
        push ebx
        lea ecx, [ebx+eax]
        lea ebx, [byte edi+010h]
        lea eax, [byte edi+0Ch]
        mov dword [byte esp+08h], eax
        mov edx, dword [byte esp+08h]
        mov eax, dword [dword esi+0C0h]
        call PutChecksum
        mov ecx, dword [esp]
        push ecx
        mov eax, dword [byte esi+04h]
        mov esi, dword [byte esp+08h]
        push esi
        mov edx, dword [byte esp+010h]
        push edx
        call dword [byte eax+018h]
        add esp, byte 0Ch
        cmp eax, dword [esp]
        jne short .2
        mov ebp, 1
.2:
        test ebp, ebp
        je short .3
        mov eax, dword [byte esp+08h]
        mov eax, dword [byte eax+010h]
        mov dword [byte edi+08h], eax
        jmp short .4
.3:
        mov dword [byte edi+08h], 1
.4:
        mov eax, ebp
        add esp, byte 0Ch
        pop ebp
SendPacket_DE:
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; SendAckPacket                                   3727C  97 PC, low confidence
; Packet link: sends an acknowledgement packet
;-----------------------------------------------------------------------------
SendAckPacket:
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 8
        mov edi, eax
        mov esi, edx
        mov dword [byte esp+04h], ebx
        mov ebp, dword [byte edx+028h]
        mov dword [byte eax+08h], 1
        mov eax, dword [byte edx+04h]
        mov edx, dword [byte edx+08h]
        push edx
        xor ebx, ebx
        add ebp, byte 4
        call dword [byte eax+0Ch]
        add esp, byte 4
        cmp eax, ebp
        jb near .2
        mov ebx, esi
        lea eax, [dword esi+088h]
        push eax
        call QueueFindPacket
        add esp, byte 4
        cmp eax, byte 0FFFFFFFFh
        jne short .1
        mov eax, dword [dword esi+084h]
.1:
        dec eax
        mov edx, dword [byte ebx+08h]
        mov edx, dword [byte edx+08h]
        and al, 7Fh
        mov dword [byte ebx+03Ch], edx
        mov byte [byte edi+0Ch], 0FEh
        and eax, 0FFh
        mov byte [byte edi+0Dh], 0
        mov ah, byte [byte esp+04h]
        mov byte [byte edi+0Eh], ah
        mov byte [byte edi+0Fh], al
        mov ebx, dword [byte esi+028h]
        push ebx
        lea ebx, [byte edi+010h]
        lea eax, [byte edi+0Ch]
        mov dword [byte esp+04h], eax
        mov ecx, ebp
        mov edx, dword [byte esp+04h]
        mov eax, dword [dword esi+0C0h]
        call PutChecksum
        push ebp
        mov ecx, dword [byte esp+04h]
        push ecx
        mov edx, dword [byte esi+08h]
        mov eax, dword [byte esi+04h]
        push edx
        call dword [byte eax+018h]
        add esp, byte 0Ch
        cmp eax, ebp
        sete al
        and eax, 0FFh
        mov ebx, eax
        je short .2
        cmp dword [byte esp+04h], byte 7Fh
        ja short .2
        mov eax, dword [byte esi+08h]
        mov eax, dword [byte eax+0Ch]
        mov dword [byte edi+08h], eax
.2:
        mov eax, ebx
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        push ebx
        push ecx
        test eax, eax
        je short .3
        mov ebx, dword [byte eax+08h]
        lea ecx, [byte ebx-01h]
        mov dword [byte eax+08h], ecx
        test ebx, ebx
        jg short .3
        mov ebx, dword [byte eax+04h]
        and ebx, byte 7Fh
        mov eax, dword [byte edx+018h]
        call SendAckPacket
        pop ecx
        pop ebx
        ret
.3:
        mov eax, 1
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; AckPackets                                      37374  97 PC, low confidence
; Packet link: moves the acknowledged window and frees acknowledged packets
;-----------------------------------------------------------------------------
AckPackets:
        push ebx
        push ecx
        push esi
        push edi
        mov esi, eax
        mov ebx, dword [byte eax+044h]
        xor eax, eax
        mov edi, ebx
        mov al, dl
        and di, byte 0FF80h
        or eax, edi
        cmp eax, ebx
        jae short .1
        add eax, 80h
.1:
        cmp eax, dword [byte esi+040h]
        jae short .2
        cmp eax, dword [byte esi+044h]
        jbe short .2
        mov dword [byte esi+044h], eax
.2:
        lea edi, [byte esi+048h]
        lea ebx, [byte esi+064h]
.3:
        push ebx
        call QueueFindPacket
        mov ecx, dword [byte esi+044h]
        add esp, byte 4
        cmp eax, ecx
        ja near SendPacket_DE
        push ebx
        call QueueTakeHead
        add esp, byte 4
        test eax, eax
        je near SendPacket_DE
        push eax
        push edi
        call QueuePeek
        add esp, byte 8
        jmp short .3
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; MarkPacketAcked                                 373D8  97 PC, low confidence
; Packet link: marks one sent packet acknowledged
;-----------------------------------------------------------------------------
MarkPacketAcked:
        push ebx
        push ecx
        sub esp, byte 4
        mov ebx, eax
        mov byte [esp], dl
        add eax, byte 64h
        push eax
        call QueueFindPacket
        mov edx, eax
        add esp, byte 4
        xor eax, eax
        mov ecx, edx
        mov al, byte [esp]
        and cl, 80h
        or eax, ecx
        cmp eax, edx
        jae short .1
        add eax, 80h
.1:
        push eax
        add ebx, byte 64h
        push ebx
        call QueueRemoveEntry
        add esp, byte 8
        test eax, eax
        je short .2
        mov dword [byte eax+08h], 0
.2:
        add esp, byte 4
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; FreeLinkChannel                                 37424  97 PC, low confidence
; Packet link: removes a channel from the open list and closes its device
;-----------------------------------------------------------------------------
FreeLinkChannel:
        push ebx
        push ecx
        push edx
        mov ebx, eax
        push eax
        push LinkChannelB
        call QueueFreeAll
        add esp, byte 8
        test eax, eax
        je short .1
        mov eax, dword [byte ebx+08h]
        mov dword [eax], 0
        mov edx, dword [byte ebx+08h]
        mov eax, dword [byte ebx+04h]
        push edx
        call dword [byte eax+04h]
        add esp, byte 4
        mov eax, dword [byte ebx+08h]
        push eax
        call dword [byte eax+018h]
        add esp, byte 4
        push ebx
        push LinkChannelA
        call QueuePeek
        add esp, byte 8
.1:
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ParsePacket                                     37470  97 PC, low confidence
; Packet link: finds a 0FEh-framed packet in received bytes, checks it and
; handles its kind
;-----------------------------------------------------------------------------
ParsePacket:
        push esi
        push edi
        push ebp
        sub esp, byte 0Ch
        mov edi, eax
        mov dword [esp], edx
        mov ebp, ebx
        mov eax, dword [byte eax+04h]
        xor esi, esi
        mov dl, byte [byte eax+024h]
        mov dword [byte esp+04h], esi
        test dl, 4
        jne short .2
        mov eax, ebx
        lea edx, [ebx+ecx]
.1:
        cmp eax, edx
        jae short .2
        cmp byte [eax], 0FEh
        je short .2
        inc esi
        inc eax
        jmp short .1
.2:
        lea edx, [esi+ebp]
        cmp byte [edx], 0FEh
        je short .3
        mov eax, ecx
        jmp near .12
.3:
        lea ebp, [byte esi+04h]
        add ebp, dword [byte edi+028h]
        cmp ebp, ecx
        ja near .11
        xor eax, eax
        mov ebx, dword [byte edi+02Ch]
        mov al, byte [byte edx+01h]
        mov dword [byte esp+08h], edx
        cmp eax, ebx
        ja near .10
        add ebp, eax
        cmp ebp, ecx
        ja near .11
        lea ebx, [byte edx+04h]
        sub ebp, esi
        mov eax, edi
        mov ecx, ebp
        call VerifyPacketChecksum
        test eax, eax
        je near .9
        mov eax, dword [byte edi+08h]
        cmp dword [eax], byte 0
        je short .4
        mov edx, dword [PacketSize]
        mov dword [eax], edx
.4:
        inc dword [byte edi+010h]
        mov eax, dword [byte esp+08h]
        mov ch, byte [byte eax+03h]
        add esi, ebp
        cmp ch, 7Fh
        ja short .5
        xor edx, edx
        mov eax, edi
        mov dl, ch
        call AckPackets
.5:
        mov eax, dword [byte esp+08h]
        mov dl, byte [byte eax+01h]
        mov dword [byte esp+04h], ebp
        test dl, dl
        je short .7
        cmp byte [byte eax+02h], 7Fh
        ja short .7
        mov ebx, dword [byte esp+08h]
        xor eax, eax
        mov edx, dword [dword edi+080h]
        mov al, byte [byte ebx+02h]
        mov ebx, edx
        and bl, 80h
        or eax, ebx
        cmp eax, edx
        jae short .6
        add eax, 80h
.6:
        push eax
        lea eax, [dword edi+088h]
        push eax
        call QueuePrepend
        mov ebx, eax
        add esp, byte 8
        mov byte [byte edi+0Fh], 0
        test eax, eax
        je short .11
        push ebp
        add eax, byte 0Ch
        push eax
        mov edx, dword [byte esp+010h]
        push edx
        call bcopy
        add esp, byte 0Ch
        push ebx
        lea eax, [dword edi+0A4h]
        push eax
        call QueueInsert
        add esp, byte 8
        mov eax, dword [esp]
        inc dword [eax]
        jmp short .11
.7:
        mov eax, dword [byte esp+08h]
        mov bl, byte [byte eax+02h]
        cmp bl, 7Fh
        ja short .8
        xor edx, edx
        mov eax, edi
        mov dl, bl
        call MarkPacketAcked
        jmp short .11
.8:
        cmp bl, 0FFh
        jne short .11
        mov eax, edi
        call FreeLinkChannel
        jmp short .11
.9:
        add esi, byte 3
        jmp short .11
.10:
        cmp al, 0FEh
        setne al
        and eax, 0FFh
        inc eax
        add esi, eax
.11:
        mov ecx, dword [byte esp+04h]
        add edi, byte 34h
        cmp esi, ecx
        seta al
        and eax, 0FFh
        mov ebp, dword [edi]
        add ebp, eax
        mov eax, esi
        mov dword [edi], ebp
.12:
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ReceivePackets                                  375F0  97 PC, low confidence
; Packet link: reads the device's bytes and parses the packets
;-----------------------------------------------------------------------------
ReceivePackets:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 0Ch
        mov edi, eax
        xor edx, edx
        mov dword [esp], edx
        mov eax, dword [byte eax+08h]
        mov ebp, dword [byte edi+04h]
        mov dword [byte esp+08h], eax
        test byte [byte ebp+024h], 4
        je short .1
        mov dword [byte edi+024h], edx
.1:
        mov ebx, dword [byte edi+024h]
        cmp ebx, dword [byte edi+020h]
        jae short .2
        mov ecx, dword [byte esp+08h]
        push ecx
        call dword [byte ebp+010h]
        add esp, byte 4
        test eax, eax
        je short .2
        mov eax, dword [byte edi+020h]
        mov edx, dword [byte edi+024h]
        sub eax, edx
        push eax
        mov eax, dword [byte edi+01Ch]
        add eax, edx
        push eax
        mov ecx, dword [byte esp+010h]
        push ecx
        call dword [byte ebp+014h]
        mov edx, dword [byte edi+024h]
        add edx, eax
        add esp, byte 0Ch
        mov dword [byte edi+024h], edx
.2:
        mov ebx, dword [byte edi+024h]
        test ebx, ebx
        je near .7
        xor ecx, ecx
        mov esi, ebx
        mov dword [byte esp+04h], ecx
.3:
        mov eax, dword [byte esp+04h]
        mov edx, esp
        mov ebx, dword [byte edi+01Ch]
        mov ecx, esi
        add ebx, eax
        mov eax, edi
        call ParsePacket
        mov dl, byte [byte ebp+024h]
        mov ebx, eax
        test dl, 4
        je short .5
        mov ecx, dword [byte esp+08h]
        push ecx
        call dword [byte ebp+010h]
        add esp, byte 4
        test eax, eax
        je short .4
        mov esi, dword [byte edi+020h]
        push esi
        mov eax, dword [byte edi+01Ch]
        push eax
        mov edx, dword [byte esp+010h]
        push edx
        call dword [byte ebp+014h]
        add esp, byte 0Ch
        mov esi, eax
        jmp short .6
.4:
        xor esi, esi
        jmp short .6
.5:
        test eax, eax
        je short .6
        mov edx, dword [byte esp+04h]
        add edx, eax
        sub esi, eax
        mov dword [byte esp+04h], edx
.6:
        test ebx, ebx
        je short .7
        mov eax, dword [byte esp+08h]
        cmp dword [eax], byte 0
        jne short .3
.7:
        test byte [byte ebp+024h], 4
        jne short .8
        mov ecx, dword [byte esp+04h]
        test ecx, ecx
        je short .8
        push esi
        mov ebp, dword [byte edi+01Ch]
        push ebp
        lea eax, [ecx+ebp]
        push eax
        call bcopy
        add esp, byte 0Ch
        mov dword [byte edi+024h], esi
.8:
        cmp dword [esp], byte 0
        setne al
        and eax, 0FFh
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; LinkGetDevice                                   376FC  97 PC, low confidence
; Packet link: returns a channel's device (+4)
;-----------------------------------------------------------------------------
LinkGetDevice:
        mov eax, dword [byte esp+04h]
        mov eax, dword [byte eax+04h]
        ret
;-----------------------------------------------------------------------------
; LinkCountdown                                   37704  97 PC, low confidence
; Packet link: counts a channel's resend counter down, true at zero
;-----------------------------------------------------------------------------
LinkCountdown:
        push ebx
        mov eax, dword [byte esp+08h]
        mov edx, dword [byte eax+08h]
        test edx, edx
        jg short .1
        mov eax, 1
        pop ebx
        ret
.1:
        lea ebx, [byte edx-01h]
        mov dword [byte eax+08h], ebx
        test ebx, ebx
        setle al
        and eax, 0FFh
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; LinkResendIfDue                                 3772C  97 PC, low confidence
; Packet link: resends when the counter has run out
;-----------------------------------------------------------------------------
LinkResendIfDue:
        mov eax, dword [byte esp+04h]
        mov edx, dword [byte esp+08h]
        cmp dword [byte eax+08h], byte 0
        jle near SendPacket
        mov eax, 1
        ret
;-----------------------------------------------------------------------------
; LinkPoll                                        37744  97 PC, low confidence
; Packet link timer task: per channel resends, receives and acknowledges
;-----------------------------------------------------------------------------
LinkPoll:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 10h
        mov eax, dword [byte esp+024h]
        mov edx, dword [byte esp+028h]
        mov esi, eax
        mov ebx, dword [byte eax+04h]
        mov dword [esp], edx
        mov dword [byte esp+04h], ebx
        mov bl, byte [byte eax+0Ch]
        mov ebp, dword [byte eax+08h]
        test bl, bl
        je short .1
        mov eax, 1
        jmp near .21
.1:
        mov byte [byte eax+0Ch], 1
        test edx, edx
        je short .4
        cmp dword [byte ebp+00h], byte 0
        je short .4
        dec dword [byte ebp+00h]
        cmp dword [byte ebp+00h], byte 0
        jne short .2
        push ebp
        call dword [byte ebp+01Ch]
        add esp, byte 4
        mov dword [byte ebp+00h], eax
.2:
        cmp dword [byte ebp+00h], byte 0
        je short .3
        mov eax, dword [byte esp+04h]
        push ebp
        call dword [byte eax+08h]
        add esp, byte 4
        test eax, eax
        jne short .4
.3:
        mov eax, esi
        call FreeLinkChannel
.4:
        cmp dword [byte ebp+00h], byte 0
        je near .13
        cmp dword [esp], byte 0
        je short .5
        mov ebx, dword [byte esi+038h]
        dec ebx
        mov dword [byte esi+038h], ebx
        test ebx, ebx
        jg near .13
.5:
        mov eax, dword [byte ebp+04h]
        mov dword [byte esi+038h], eax
        lea eax, [dword esi+088h]
        mov edi, 1
        mov dword [byte esp+08h], eax
        lea eax, [dword esi+0A4h]
        mov dword [byte esi+034h], 0
        mov dword [byte esp+0Ch], eax
.6:
        mov eax, dword [dword esi+080h]
        push eax
        mov edx, dword [byte esp+010h]
        push edx
        call QueuePrepend
        add esp, byte 8
        mov ebx, eax
        test eax, eax
        je near .10
.7:
        test edi, edi
        je near .10
        xor eax, eax
        mov al, byte [byte ebx+0Dh]
        mov ecx, dword [byte esi+028h]
        push eax
        lea eax, [byte ebx+010h]
        add eax, ecx
        push eax
        push ebp
        call dword [byte ebp+020h]
        add esp, byte 0Ch
        test eax, eax
        je short .8
        pushf
        pop eax
        and eax, 200h
        cli
        mov edx, dword [dword esi+084h]
        lea ecx, [byte edx+01h]
        mov dword [dword esi+084h], ecx
        mov dword [byte ebx+04h], edx
        inc dword [dword esi+080h]
        pushf
        and dword [esp], 0FFFFFDFFh
        or dword [esp], eax
        popf
        push ebx
        mov dword [byte ebx+08h], 0
        mov ebx, dword [byte esp+0Ch]
        push ebx
        call QueueInsert
        add esp, byte 8
        mov ecx, dword [dword esi+080h]
        push ecx
        mov eax, dword [byte esp+010h]
        push eax
        call QueuePrepend
        add esp, byte 8
        mov ebx, eax
        jmp short .9
.8:
        push ebx
        mov edi, dword [byte esp+010h]
        push edi
        call QueueInsert
        add esp, byte 8
        xor edi, edi
.9:
        test ebx, ebx
        jne near .7
.10:
        mov eax, dword [byte esp+04h]
        push ebp
        call dword [byte eax+010h]
        add esp, byte 4
        test eax, eax
        je short .11
        mov eax, esi
        call ReceivePackets
        and edi, eax
        jmp short .12
.11:
        xor edi, edi
.12:
        je short .13
        cmp dword [byte ebp+00h], byte 0
        jne near .6
.13:
        cmp dword [byte ebp+00h], byte 0
        je near .20
        cmp byte [byte esi+0Fh], 0
        jne short .16
        lea eax, [dword esi+0A4h]
        push eax
        call QueueFindPacket
        add esp, byte 4
        cmp eax, byte 0FFFFFFFFh
        je short .14
        cmp eax, dword [dword esi+080h]
        je short .14
        mov eax, 1
        jmp short .15
.14:
        xor eax, eax
.15:
        mov byte [byte esi+0Fh], 1
        jmp short .17
.16:
        xor eax, eax
.17:
        cmp dword [byte esi+034h], byte 0
        jne short .18
        test eax, eax
        je short .19
.18:
        mov eax, dword [dword esi+090h]
        test eax, eax
        je short .19
        mov edx, dword [byte eax+08h]
        lea ebx, [byte edx-01h]
        mov dword [byte eax+08h], ebx
        test edx, edx
        jg short .19
        mov ebx, dword [byte eax+04h]
        mov edx, esi
        and ebx, byte 7Fh
        mov eax, dword [byte esi+018h]
        call SendAckPacket
.19:
        cmp dword [esp], byte 0
        je short .20
        push esi
        push LinkCountdown
        lea ebx, [byte esi+064h]
        push ebx
        call QueueRepost
        add esp, byte 0Ch
        push esi
        push LinkResendIfDue
        push ebx
        call QueuePostBuffer
        mov eax, dword [byte esi+03Ch]
        lea edx, [byte eax-01h]
        add esp, byte 0Ch
        mov dword [byte esi+03Ch], edx
        test eax, eax
        jg short .20
        mov ebx, 0FBh
        mov edx, esi
        mov eax, dword [byte esi+018h]
        call SendAckPacket
.20:
        mov eax, 1
        mov byte [byte esi+0Ch], 0
.21:
        add esp, byte 10h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
LinkPoll_24C:
        push ecx
        push edx
        push byte 1
        push LinkPoll
        push LinkChannelB
        call QueuePostBuffer
        add esp, byte 0Ch
        pop edx
        pop ecx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; InitPacketLink                                  379AC  97 PC, low confidence
; Packet link: once, sets up the channel lists, the timer task (addtimer) and
; the exit handler
;-----------------------------------------------------------------------------
InitPacketLink:
        push ebx
        mov edx, dword [PacketLinkOpen]
        test edx, edx
        jne short .1
        push edx
        push edx
        push LinkChannelB
        call QueueInit
        add esp, byte 0Ch
        push byte 0
        push byte 0
        push LinkChannelA
        call QueueInit
        add esp, byte 0Ch
        push LinkPoll_24C
        call addtimer
        add esp, byte 4
        push ShutdownPacketLink
        mov ebx, 1
        call AddExitHandler
        add esp, byte 4
        mov dword [PacketLinkOpen], ebx
.1:
        pop ebx
        ret
        db 08Bh,0C0h
        push ebx
        mov edx, dword [byte esp+0Ch]
        push edx
        mov ebx, dword [byte esp+0Ch]
        push ebx
        push LinkChannelB
        call QueuePostBuffer
        add esp, byte 0Ch
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; ShutdownPacketLink                              37A1C  97 PC, low confidence
; Packet link: closes every channel and removes the timer task
;-----------------------------------------------------------------------------
ShutdownPacketLink:
        push ebx
        push ecx
        push edx
        push esi
        cmp dword [PacketLinkOpen], byte 0
        je near .4
.1:
        push LinkChannelB
        call QueueCount
        add esp, byte 4
        test eax, eax
        jbe short .2
        mov eax, dword [LinkChannelBData]
        mov ebx, dword [byte eax+08h]
        push ebx
        call ClosePacketLink
        add esp, byte 4
        jmp short .1
.2:
        push LinkChannelA
        call QueueCount
        add esp, byte 4
        test eax, eax
        jbe short .3
        mov eax, dword [LinkChannelAData]
        mov esi, dword [byte eax+08h]
        push esi
        call ClosePacketLink
        add esp, byte 4
        jmp short .2
.3:
        push LinkPoll_24C
        call RemoveTimerCallback
        add esp, byte 4
        push LinkChannelB
        call QueueNoOp
        add esp, byte 4
        push LinkChannelA
        call QueueNoOp
        add esp, byte 4
        push byte 0
        call RunIdleHandlers
        xor ecx, ecx
        add esp, byte 4
        mov dword [PacketLinkOpen], ecx
.4:
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; OpenPacketLink                                  37AB4  97 PC, low confidence
; Packet link: opens a channel ("pktbuffer" block, window 2-7, packet size >=
; 6)
;-----------------------------------------------------------------------------
OpenPacketLink:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, 0E4h
        mov esi, dword [dword esp+0F8h]
        mov edi, dword [dword esp+0108h]
        mov ecx, dword [dword esp+010Ch]
        xor edx, edx
        mov dword [dword esp+0CCh], edx
        mov dword [dword esp+0DCh], edx
        test esi, esi
        je short .1
        mov eax, dword [byte esi+018h]
        jmp short .2
.1:
        xor eax, eax
.2:
        mov dword [dword esp+0C8h], eax
        cmp edi, byte 6
        jae short .3
        mov edi, 6
.3:
        cmp ecx, byte 2
        jae short .4
        mov ecx, 2
        jmp short .5
.4:
        cmp ecx, byte 7
        jbe short .5
        mov ecx, 7
.5:
        mov eax, dword [dword esp+0FCh]
        mov ebp, dword [byte eax+020h]
        cmp edi, ebp
        jae short .6
        mov edi, ebp
.6:
        mov ebx, 1
        shl ebx, cl
        mov edx, ebx
        mov eax, ebx
        sar edx, 1Fh
        LD sub, eax, edx
        sar eax, 1
        lea ebp, [byte eax-01h]
        mov eax, dword [dword esp+0FCh]
        mov dword [byte esp+02Ch], edi
        mov dword [byte esp+030h], ebx
        mov dl, byte [byte eax+024h]
        mov dword [dword esp+0E0h], ebp
        test dl, 1
        je short .7
        xor eax, eax
        mov dword [dword esp+0C0h], eax
        mov dword [byte esp+028h], eax
        jmp short .9
.7:
        cmp dword [dword esp+0104h], byte 0
        je short .8
        mov edi, PacketChecksum
        mov ecx, 2
        mov dword [dword esp+0C0h], edi
        mov dword [byte esp+028h], ecx
        jmp short .9
.8:
        mov ebx, PacketChecksum
        mov edx, 2
        mov dword [dword esp+0C0h], ebx
        mov dword [byte esp+028h], edx
.9:
        mov eax, dword [byte esp+028h]
        add eax, 0FEh
        mov dword [dword esp+0D0h], eax
        mov eax, dword [dword esp+0FCh]
        test byte [byte eax+024h], 4
        jne short .10
        mov ebx, dword [dword esp+0D0h]
        add ebx, ebx
        mov dword [dword esp+0D0h], ebx
.10:
        mov eax, dword [byte esp+02Ch]
        mov ecx, dword [byte esp+028h]
        add eax, byte 10h
        mov edi, dword [dword esp+0E0h]
        add eax, ecx
        lea edx, [byte ebp+01h]
        add eax, byte 3
        add edx, edi
        and al, 0FCh
        imul eax, edx
        mov edx, dword [dword esp+0D0h]
        add eax, 0C4h
        add eax, edx
        test esi, esi
        je near .31
        mov ebx, dword [byte esi+024h]
        test ebx, ebx
        jne short .11
        mov ecx, dword [dword esp+0100h]
        push ecx
        push eax
        push str_Pktbuffer
        mov edi, 1
        call AllocMemData
        add esp, byte 0Ch
        mov ebx, eax
        mov dword [dword esp+0CCh], edi
.11:
        test ebx, ebx
        je near .30
        mov dword [byte esi+018h], assfwatch_1EC
        lea edi, [dword ebx+0C4h]
        mov eax, dword [byte esi+014h]
        mov dword [byte esi+024h], ebx
        test eax, eax
        jne short .12
        mov dword [byte esi+014h], assfwatch_1EC
.12:
        cmp dword [byte esi+01Ch], byte 0
        jne short .13
        mov dword [byte esi+01Ch], assfwatch_1EC
.13:
        cmp dword [byte esi+020h], byte 0
        jne short .14
        mov dword [byte esi+020h], assfwatch_1EC
.14:
        cmp dword [byte esi+04h], byte 0
        jne short .15
        mov dword [byte esi+04h], 1
.15:
        cmp dword [byte esi+08h], byte 0
        jne short .16
        mov dword [byte esi+08h], 6
.16:
        cmp dword [byte esi+0Ch], byte 0
        jne short .17
        mov dword [byte esi+0Ch], 18h
.17:
        cmp dword [byte esi+010h], byte 0
        jne short .18
        mov dword [byte esi+010h], 18h
.18:
        mov eax, dword [byte esi+08h]
        mov dword [byte esp+03Ch], eax
        push dword 0C4h
        mov eax, dword [byte esi+04h]
        push ebx
        mov dword [byte esp+040h], eax
        lea eax, [byte esp+08h]
        push eax
        call bcopy
        add esp, byte 0Ch
        mov dword [ebx], 0
        mov al, byte [dword esp+0CCh]
        mov byte [byte ebx+0Dh], al
        mov eax, dword [PacketLinkMode]
        lea edx, [byte eax+01h]
        mov dword [PacketLinkMode], edx
        mov dword [byte ebx+014h], 0
        mov byte [byte ebx+0Ch], 0
        mov byte [byte ebx+0Eh], al
        mov dword [byte ebx+08h], esi
        mov eax, dword [dword esp+0FCh]
        push byte 0
        mov dword [byte ebx+04h], eax
        push byte 0
        mov dword [byte ebx+010h], 0
        lea eax, [byte ebx+048h]
        mov dword [byte ebx+040h], 1
        push eax
        mov dword [byte ebx+044h], 0
        mov dword [dword esp+0D0h], eax
        call QueueInit
        add esp, byte 0Ch
        push ebx
        push LinkGetDevice
        lea eax, [byte ebx+064h]
        push eax
        call QueueInit
        add esp, byte 0Ch
        push ebx
        push LinkGetDevice
        lea eax, [dword ebx+088h]
        mov dword [dword ebx+080h], 1
        push eax
        mov dword [dword ebx+084h], 1
        call QueueInit
        add esp, byte 0Ch
        push ebx
        push LinkGetDevice
        lea eax, [dword ebx+0A4h]
        push eax
        call QueueInit
        add esp, byte 0Ch
        mov eax, dword [dword esp+0C4h]
        mov dword [dword esp+0D4h], eax
.19:
        mov ecx, dword [dword esp+0E0h]
        dec ecx
        mov dword [dword esp+0E0h], ecx
        cmp ecx, byte 0FFFFFFFFh
        je short .20
        mov eax, edi
        mov edx, dword [byte ebx+02Ch]
        mov ecx, dword [byte ebx+028h]
        add edx, byte 10h
        mov dword [eax], 0
        push eax
        mov dword [byte eax+04h], 0
        add edx, ecx
        mov dword [byte eax+08h], 0
        add edx, byte 3
        mov eax, dword [dword esp+0D8h]
        and dl, 0FCh
        push eax
        add edi, edx
        call QueuePeek
        add esp, byte 8
        jmp short .19
.20:
        lea eax, [dword ebx+088h]
        mov dword [dword esp+0D8h], eax
.21:
        dec ebp
        cmp ebp, byte 0FFFFFFFFh
        je short .22
        mov edx, dword [byte ebx+02Ch]
        mov ecx, dword [byte ebx+028h]
        add edx, byte 10h
        add edx, ecx
        add edx, byte 3
        mov eax, edi
        and dl, 0FCh
        mov dword [eax], 0
        add edi, edx
        mov edx, dword [dword ebx+084h]
        lea ecx, [byte edx+01h]
        mov dword [dword ebx+084h], ecx
        mov dword [byte eax+08h], 0
        push eax
        mov dword [byte eax+04h], edx
        mov eax, dword [dword esp+0DCh]
        push eax
        call QueueInsert
        add esp, byte 8
        jmp short .21
.22:
        mov eax, dword [byte ebx+02Ch]
        mov edx, dword [byte ebx+028h]
        add eax, byte 10h
        add eax, edx
        add eax, byte 3
        mov dword [byte ebx+024h], 0
        and al, 0FCh
        mov dword [byte ebx+018h], edi
        add edi, eax
        mov eax, dword [dword esp+0D0h]
        push esi
        mov dword [byte ebx+020h], eax
        mov eax, dword [dword esp+0100h]
        mov dword [byte ebx+01Ch], edi
        call dword [eax]
        add esp, byte 4
        test eax, eax
        je near .27
        push ebx
        push LinkChannelB
        mov dword [esi], 3B9ACA00h
        call QueuePeek
        add esp, byte 8
        xor edi, edi
.23:
        push edi
        call RunIdleHandlers
        add esp, byte 4
        push esi
        call dword [byte esi+014h]
        add esp, byte 4
        mov dword [dword esp+0DCh], eax
        cmp edi, dword [esi]
        je short .24
        mov dword [esi], 3B9ACA00h
.24:
        cmp edi, dword [esi]
        je short .25
        mov ebp, dword [byte ebx+010h]
        cmp edi, ebp
        jne short .25
        cmp ebp, dword [dword esp+0DCh]
        je short .23
.25:
        cmp dword [esi], byte 0
        je short .26
        cmp dword [dword esp+0DCh], byte 0
        je short .27
.26:
        push esi
        mov dword [esi], 0
        mov eax, dword [dword esp+0100h]
        call dword [byte eax+04h]
        add esp, byte 4
.27:
        cmp dword [esi], byte 0
        je short .28
        cmp dword [dword esp+0DCh], byte 0
        jne short .28
        mov eax, dword [PacketSize]
        mov dword [esi], eax
        mov edx, dword [dword esp+0C8h]
        test edx, edx
        je short .30
        mov dword [byte esi+018h], edx
        jmp short .30
.28:
        push ebx
        push LinkChannelB
        call QueueFreeAll
        add esp, byte 8
        cmp dword [dword esp+0CCh], byte 0
        je short .29
        push ebx
        call FreeMemBlock
        add esp, byte 4
        mov dword [byte esi+024h], 0
.29:
        xor ebx, ebx
.30:
        push byte 0
        call RunIdleHandlers
        add esp, byte 4
        test ebx, ebx
        setne al
        and eax, 0FFh
.31:
        add esp, 0E4h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; PacketLinkSend                                  37F4C  97 PC, low confidence
; Packet link: queues and sends a block on a channel (LinkSendBlock,
; WaitForOtherComputer)
;-----------------------------------------------------------------------------
PacketLinkSend:
        push ebx
        push esi
        push edi
        mov edi, dword [byte esp+010h]
        test edi, edi
        je short .1
        cmp dword [edi], byte 0
        jne short .2
.1:
        xor eax, eax
        pop edi
        pop esi
        pop ebx
        ret
.2:
        mov edi, dword [byte edi+024h]
        lea eax, [byte edi+048h]
        push eax
        call QueueTakeHead
        mov esi, eax
        add esp, byte 4
        test eax, eax
        je short .3
        mov ecx, dword [byte esp+018h]
        mov ebx, dword [byte esp+014h]
        mov edx, edi
        call BuildPacketHeader
        mov edx, edi
        mov eax, esi
        call SendPacket
        push esi
        add edi, byte 64h
        push edi
        call QueueInsert
        mov eax, 1
        add esp, byte 8
.3:
        pop edi
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
        mov eax, dword [byte esp+04h]
        test eax, eax
        je short .4
        cmp dword [eax], byte 0
        jne short .5
.4:
        xor eax, eax
        ret
.5:
        push byte 0
        mov eax, dword [byte eax+024h]
        push eax
        call LinkPoll
        add esp, byte 8
        ret
        db 090h
;-----------------------------------------------------------------------------
; ClosePacketLink                                 37FC8  97 PC, low confidence
; Packet link: flushes and closes a channel
;-----------------------------------------------------------------------------
ClosePacketLink:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov ebp, dword [byte esp+018h]
        test ebp, ebp
        je near .7
        je near .7
        mov edx, dword [byte ebp+024h]
        test edx, edx
        je near .7
        push edx
        mov eax, dword [byte edx+04h]
        push LinkChannelB
        mov edi, edx
        mov dword [byte esp+08h], eax
        call QueueFreeAll
        add esp, byte 8
        test eax, eax
        je near .5
        cmp dword [byte ebp+00h], byte 0
        je short .4
        mov esi, 4
        mov dword [byte ebp+00h], 0
.1:
        dec esi
        cmp esi, byte 0FFFFFFFFh
        je short .3
        mov eax, dword [esp]
        push ebp
        call dword [byte eax+08h]
        add esp, byte 4
        test eax, eax
        je short .3
        mov ebx, 0FFh
        mov edx, edi
        mov eax, dword [byte edi+018h]
        call SendAckPacket
        test eax, eax
        je short .2
        xor esi, esi
        jmp short .1
.2:
        push byte 1
        call WaitTicks
        add esp, byte 4
        jmp short .1
.3:
        push byte 2
        call WaitTicks
        add esp, byte 4
        mov eax, dword [esp]
        push ebp
        call dword [byte eax+04h]
        add esp, byte 4
.4:
        push edi
        push LinkChannelA
        call QueuePeek
        add esp, byte 8
.5:
        push edi
        push LinkChannelA
        call QueueFreeAll
        add esp, byte 8
        test eax, eax
        je short .7
        lea eax, [byte edi+048h]
        push eax
        call QueueNoOp
        add esp, byte 4
        lea eax, [byte edi+064h]
        push eax
        call QueueNoOp
        add esp, byte 4
        lea eax, [dword edi+088h]
        push eax
        call QueueNoOp
        add esp, byte 4
        lea eax, [dword edi+0A4h]
        push eax
        call QueueNoOp
        mov ah, byte [byte edi+0Dh]
        add esp, byte 4
        test ah, ah
        je short .6
        push edi
        call FreeMemBlock
        add esp, byte 4
        mov dword [byte ebp+024h], 0
.6:
        mov eax, 1
        jmp short .8
.7:
        xor eax, eax
.8:
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
SeasonGameMenuJumpTable:                        ; jump table for the switch cases of SeasonGameScreen
        dd SeasonGameScreen_13F
        dd SeasonGameScreen_14D
        dd SeasonGameScreen_1EC
        dd SeasonGameScreen_1F3
        dd SeasonGameScreen_238
        dd SeasonGameScreen_2B1
        dd SeasonGameScreen_2CF
SeasonOpponentJumpTable:                        ; jump table for the switch cases of SeasonGameScreen
        dd SeasonGameScreen_17B
        dd SeasonGameScreen_182
        dd SeasonGameScreen_1DA
        dd SeasonGameScreen_182
        dd SeasonGameScreen_1DA
        dd SeasonGameScreen_1E3
SeasonOpponentTextJumpTable:                    ; jump table for the switch cases of SeasonGameScreen
        dd SeasonGameScreen_3D3
        dd SeasonGameScreen_3DF
        dd SeasonGameScreen_3D3
        dd SeasonGameScreen_3DF
        dd SeasonGameScreen_3EB
