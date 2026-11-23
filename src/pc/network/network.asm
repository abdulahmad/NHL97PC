; Network games: IPX sessions, hosting, finding and joining games.
bits 32
%include "hockey.inc"
section s_E5729 progbits alloc exec nowrite align=1
extern AllocMemBlock, bcopy, BlitArt, BlitShape, ClosePacketLink, ConvertArtNew, ConvertArtXY, CreateBitmap
extern DetectWindows, DrawArt, DrawEditBox, DrawFrameBox, DrawShadedLogo, DrawTextAligned, FillRect, FindShape
extern FreeBitmap, FreeMemBlock, FrontShapeFile, GameSettings, GetLangText, HideLinkBox, InitMenuItems, IpxBuffer
extern IpxDriverNames, IpxLinkStartup, IpxPresent, IpxSocketHandle, IpxSocketOpen, LinkTextFont, MakeColor, memcpy_
extern memset_, MenuScreenBitmap, ModemPortBasePad, ModemPortBases, ModemPortChoice, ModemPortCount, ModemPortIrqs, NetAnnounce
extern NetButtonShape, NetCloseSession, NetCopyName, NetDisconnectPeer, NetFoundCount, NetFoundCountPad, NetFrameShape, NetGameBitmaps
extern NetGameCount, NetGameCountPad, NetGameList, NetGameName, NetHostName, NetHostSessionName, NetHostShape, NetJoinedGame
extern NetJoinedInfo, NetJoinedOk, NetJoinGame, NetJoinPending, NetJoinRequest, NetJoinShape, NetJoinSocket, NetLeaveGame
extern NetListArt, NetListBitmap, NetListChoice, NetListFirst, NetListGames, NetListLayer, NetListRows, NetListTick
extern NetListTop, NetOpenSession, NetPlayerBitmaps, NetPlayerNameLength, NetPlayerNameSet, NetScreenItems, NetScrollDownShape, NetScrollUpShape
extern NetSessionActive, NetSessionPort, NetSessionState, NetSocket, NetTitleShape, OpenModemPacketLink, OpenNetPacketLink, OpenSerialPacketLink
extern PresentScreen, RunMenu, SecondsToSamples, ServiceIdle, SetDrawTarget, SetNetCallback, SetRegionRect, SetScreenTarget
extern SetTextColor, SetTickDeadline, ShowLinkMessage, ShowMessageBox, sprintf_, StaticBuffer, str_08x, str_DBOT
extern str_DTOP, str_GAMEADDR, str_GenericHayesCompatible, str_IPXMEM, str_KWKJSK122691, str_LC003, str_LC0D3, str_LX003
extern str_LX0D3, str_NETWORK, str_NHL97, str_PICKS2, str_Punct_ModemSettingsScreen, str_REGS2, str_SERVLIST, strcat_
extern strcmp_, strcpy_, stricmp_, strncpy_, tickcount, ViewScreenHeight, ViewScreenWidth, WaitSoundTime
extern WaitTickDeadline, ZeroMem
global InitNetSession, DefaultModemName, OpenNetSession, CloseNetSession, ShutdownNetSession, SetNetPlayerName, IpxInit, LoadServerList
global IpxCloseSocket, HostNetGame, LeaveNetGame, AddFoundGame, FindNetworkGames, DrawNetGameList, ChooseNetGame, ChooseNetworkGameScreenJumpTable
global ChooseNetworkGameScreen, ChooseNetworkGameScreen_A51, ChooseNetworkGameScreen_A99, ChooseNetworkGameScreen_AE5, ChooseNetworkGameScreen_B21, ChooseNetworkGameScreen_BA2, CopyJoinedGameInfo, JoinNetworkGame
global CloseNetConnection
%if VERSION = 11
        add byte [eax], al
        db 0
%else
        db 00h,00h,00h,00h,00h,00h,00h
%endif
;-----------------------------------------------------------------------------
; InitNetSession                                  E5730  97 PC, low confidence
; Sets up the network session
;-----------------------------------------------------------------------------
InitNetSession:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        cmp word [NetSessionActive], byte 0
        je short .1
        xor eax, eax
        jmp near .3
.1:
        push byte 58h
        mov ebx, 0Ah
        push NetSessionState
        mov edi, 3
        mov ebp, 1
        call ZeroMem
        mov eax, dword [ModemPortChoice]
        add esp, byte 8
        mov dword [NetSessionState+34h], ebx
        mov dword [NetSessionState+40h], edi
        xor edx, edx
        push byte 4
        mov dword [NetSessionState+48h], ebp
        mov dword [NetSessionState+2Ch], edx
        push dword 0FAh
        sar eax, 10h
        push edx
        mov dword [NetSessionState+38h], edx
        mov eax, dword [nosplit eax*2+ModemPortBasePad]
        push byte 20h
        sar eax, 10h
        push edx
        mov dword [NetSessionState+3Ch], edx
        mov dword [NetSessionState+30h], eax
        call OpenSerialPacketLink
        add esp, byte 14h
        push byte 4
        push dword 0FAh
        push byte 0
        push byte 20h
        push byte 0
        mov ebx, eax
        mov esi, eax
        call OpenModemPacketLink
        add esp, byte 14h
        cmp ebx, eax
        jge short .2
        mov esi, eax
.2:
        mov ebx, 1
        mov eax, esi
        mov word [NetSessionActive], bx
.3:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; DefaultModemName                                E57EC  97 PC, low confidence
; (len out): "Generic Hayes-Compatible" (length 17h) when a modem is set up,
; else 0; from ModemSettingsScreen
;-----------------------------------------------------------------------------
DefaultModemName:
        cmp word [NetSessionActive], byte 0
        jne short .1
        xor eax, eax
        ret
.1:
        mov dword [eax], 17h
        mov eax, str_GenericHayesCompatible
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; OpenNetSession                                  E5808  97 PC, low confidence
; Opens the network session
;-----------------------------------------------------------------------------
OpenNetSession:
        push esi
        push edi
        push ebp
        mov esi, eax
        mov ebp, edx
        mov edi, ebx
        mov ebx, ecx
        cmp word [NetSessionActive], byte 0
        jne short .1
        xor eax, eax
        jmp near .11
.1:
        mov cx, word [byte eax+04h]
        test cx, cx
        jl short .2
        cmp cx, byte 3
        jle short .3
.2:
        xor eax, eax
        pop ebp
        pop edi
        pop esi
        ret 4
.3:
        mov eax, dword [byte eax+02h]
        sar eax, 10h
        mov dword [NetSessionState+2Ch], eax
        mov dx, word [ModemPortCount]
        mov ax, word [byte esi+06h]
        cmp ax, dx
        je short .4
        cmp ax, word [ModemPortBases]
        je short .4
        cmp ax, word [ModemPortIrqs]
        je short .4
        cmp ax, word [ModemPortChoice]
        je short .4
        xor eax, eax
        pop ebp
        pop edi
        pop esi
        ret 4
.4:
        mov ecx, dword [byte esi+04h]
        mov eax, 1
        sar ecx, 10h
        shl eax, cl
        mov dword [NetSessionState+30h], eax
        cmp word [byte esi+08h], byte 9
        jge short .5
        xor eax, eax
        pop ebp
        pop edi
        pop esi
        ret 4
.5:
        mov eax, dword [byte esi+06h]
        sar eax, 10h
        mov dword [NetSessionState+34h], eax
        mov eax, dword [byte esi+0Ah]
        sar eax, 10h
        mov dword [NetSessionState+48h], eax
        cmp word [byte esi+0Ah], byte 0
        je short .6
        xor eax, eax
        mov dword [NetSessionState+50h], eax
        mov dword [NetSessionState+54h], eax
        mov dword [NetSessionState+4Ch], eax
        jmp short .8
.6:
        lea eax, [byte esi+024h]
        mov dword [NetSessionState+4Ch], eax
        test byte [esi], 1
        je short .7
        xor edx, edx
        mov dword [NetSessionState+54h], edx
        mov dword [NetSessionState+50h], edx
        jmp short .8
.7:
        lea eax, [byte esi+04Ch]
        mov dword [NetSessionState+50h], eax
        lea eax, [byte esi+010h]
        mov dword [NetSessionState+54h], eax
.8:
        push byte 28h
        push NetSessionState
        call ZeroMem
        add esp, byte 8
        xor eax, eax
        mov dword [NetSessionState+20h], edi
        mov dword [NetSessionState+4], eax
        mov dword [NetSessionState+8], eax
        mov dword [NetSessionState+0Ch], eax
        mov dword [NetSessionState+10h], eax
        mov eax, dword [byte esp+010h]
        mov dword [NetSessionState+14h], ebp
        mov dword [NetSessionState+24h], eax
        cmp word [byte esi+0Ah], byte 0
        je short .9
        push byte 4
        push dword 0FAh
        push byte 0
        push byte 20h
        push NetSessionState
        call OpenSerialPacketLink
        add esp, byte 14h
        test eax, eax
        jne short .10
        pop ebp
        pop edi
        pop esi
        ret 4
.9:
        push byte 4
        push dword 0FAh
        push byte 0
        push byte 20h
        push NetSessionState
        call OpenModemPacketLink
        add esp, byte 14h
        test eax, eax
        je short .11
.10:
        mov esi, 1
        xor ecx, ecx
        mov edx, 20h
        mov dword [NetSessionState+14h], ecx
        mov word [NetSessionPort], si
        mov dword [str_Punct_ModemSettingsScreen], edx
        mov eax, 1
        mov dword [ebx], NetSessionState
.11:
        pop ebp
        pop edi
        pop esi
        ret 4
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; CloseNetSession                                 E59A8  97 PC, low confidence
; Closes the network session
;-----------------------------------------------------------------------------
CloseNetSession:
        push ecx
        push edx
        cmp word [NetSessionActive], byte 0
        je short .1
        cmp word [NetSessionPort], byte 0
        je short .1
        push NetSessionState
        call ClosePacketLink
        xor ecx, ecx
        add esp, byte 4
        mov word [NetSessionPort], cx
.1:
        pop edx
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; ShutdownNetSession                              E59D8  97 PC, low confidence
; Shuts down the network session
;-----------------------------------------------------------------------------
ShutdownNetSession:
        push ebx
        push ecx
        push edx
        push edi
        mov dx, word [NetSessionActive]
        test dx, dx
        je short .1
        mov bx, word [NetSessionPort]
        test bx, bx
        je short .1
        test dx, dx
        je short .1
        test bx, bx
        je short .1
        push NetSessionState
        call ClosePacketLink
        xor edi, edi
        add esp, byte 4
        mov word [NetSessionPort], di
.1:
        pop edi
        pop edx
        pop ecx
        pop ebx
        ret
        db 00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; SetNetPlayerName                                E5A20  97 PC, low confidence
; Sets the network player name
;-----------------------------------------------------------------------------
SetNetPlayerName:
        push ebx
        mov ecx, dword [byte esp+08h]
        cmp dword [NetPlayerNameSet], byte 0
        je short .1
        xor edx, edx
        mov dx, word [NetPlayerNameLength]
        lea eax, [nosplit edx*4+00h]
        add eax, edx
        mov edx, dword [NetPlayerNameSet]
        shl eax, 4
        add eax, edx
        mov edx, dword [byte esp+0Ch]
        call strcpy_
        xor edx, edx
        mov dx, word [NetPlayerNameLength]
        lea eax, [nosplit edx*4+00h]
        add eax, edx
        mov edx, dword [NetPlayerNameSet]
        shl eax, 4
        add eax, edx
        mov ebx, 10h
        add eax, byte 40h
        mov edx, ecx
        call memcpy_
.1:
        mov dx, word [NetPlayerNameLength]
        inc edx
        mov eax, 1
        mov word [NetPlayerNameLength], dx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; IpxInit                                         E5A98  97 PC, low confidence
; Looks for the IPX driver and allocates the "IPXMEM" / "NETWORK" blocks
;-----------------------------------------------------------------------------
IpxInit:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov dx, word [IpxSocketOpen]
        xor ebx, ebx
        test dx, dx
        je short .1
        xor eax, eax
        jmp near .8
.1:
        mov dword [IpxPresent], ebx
        call DetectWindows
        test eax, eax
        jne short .2
        mov eax, dword [GameSettings]
        shl eax, 1Ch
        shr eax, 1Eh
        mov eax, dword [nosplit eax*4+IpxDriverNames]
        call IpxLinkStartup
        mov ebx, eax
.2:
        test ebx, ebx
        jle short .3
        push dword 200h
        push ebx
        push str_IPXMEM
        call AllocMemBlock
        add esp, byte 0Ch
        mov dword [IpxBuffer], eax
        call SetNetCallback
.3:
        xor ebx, ebx
        push byte 2
        mov word [NetPlayerNameLength], bx
        xor ebx, ebx
        push ebx
        push dword 2580h
        push SetNetPlayerName
        mov dword [NetPlayerNameSet], ebx
        call NetCopyName
        add esp, byte 10h
        test eax, eax
        jne short .5
        xor edx, edx
        mov ebp, dword [IpxBuffer]
        mov word [NetPlayerNameLength], dx
        test ebp, ebp
        je short .4
        push ebp
        call FreeMemBlock
        add esp, byte 4
        mov dword [IpxBuffer], ebx
.4:
        xor eax, eax
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.5:
        mov cx, word [NetPlayerNameLength]
        test cx, cx
        jbe short .7
        mov bx, cx
        lea eax, [nosplit ebx*4+00h]
        add eax, ebx
        push byte 20h
        shl eax, 4
        push eax
        push str_NETWORK
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 2
        push byte 0
        push dword 2580h
        xor esi, esi
        push SetNetPlayerName
        mov dword [NetPlayerNameSet], eax
        mov word [NetPlayerNameLength], si
        call NetCopyName
        add esp, byte 10h
        test eax, eax
        jne short .7
        mov ecx, dword [IpxBuffer]
        mov word [NetPlayerNameLength], si
        test ecx, ecx
        je short .6
        push ecx
        call FreeMemBlock
        xor edi, edi
        add esp, byte 4
        mov dword [IpxBuffer], edi
.6:
        xor eax, eax
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.7:
        push byte 4
        push dword 0FAh
        push byte 0
        push byte 20h
        mov edi, 1
        push byte 0
        mov word [IpxSocketOpen], di
        call OpenNetPacketLink
        add esp, byte 14h
.8:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; LoadServerList                                  E5BF8  97 PC, low confidence
; Loads the "SERVLIST" block for the network games screen
;-----------------------------------------------------------------------------
LoadServerList:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov dword [esp], eax
        mov dx, word [NetPlayerNameLength]
        test dx, dx
        jbe short .3
        xor eax, eax
        mov ax, dx
        push byte 20h
        shl eax, 6
        push eax
        push str_SERVLIST
        xor esi, esi
        xor ebx, ebx
        call AllocMemBlock
        add esp, byte 0Ch
        mov ebp, eax
        mov edi, eax
        jmp short .2
.1:
        push byte 40h
        mov eax, dword [NetPlayerNameSet]
        push edi
        add eax, ebx
        push eax
        inc esi
        call bcopy
        add ebx, byte 50h
        add edi, byte 40h
        add esp, byte 0Ch
.2:
        xor eax, eax
        mov ax, word [NetPlayerNameLength]
        cmp esi, eax
        jge short .4
        jmp short .1
.3:
        xor ebp, ebp
.4:
        xor eax, eax
        mov ebx, dword [esp]
        mov ax, word [NetPlayerNameLength]
        mov dword [ebx], eax
        mov eax, ebp
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; IpxCloseSocket                                  E5C78  95 PC, medium confidence
; Frees rinkbm and the rinktilebm buffer (resets currink to -1); used by
; cdstream and highlights
;-----------------------------------------------------------------------------
IpxCloseSocket:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        cmp word [IpxSocketOpen], byte 0
        je short .3
        mov bx, word [IpxSocketHandle]
        test bx, bx
        jl short .1
        jl short .1
        push NetSocket
        mov esi, 0FFFFFFFFh
        call NetCloseSession
        add esp, byte 4
        mov word [IpxSocketHandle], si
.1:
        mov edx, dword [IpxBuffer]
        test edx, edx
        je short .2
        push edx
        call FreeMemBlock
        xor ecx, ecx
        add esp, byte 4
        mov dword [IpxBuffer], ecx
.2:
        xor edi, edi
        mov word [IpxSocketOpen], di
.3:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; HostNetGame                                     E5CD8  97 PC, low confidence
; Hosts a network game
;-----------------------------------------------------------------------------
HostNetGame:
        push ebx
        push ecx
        push esi
        mov esi, eax
        mov ebx, 12h
        mov eax, NetHostName
        call strncpy_
        cmp word [IpxSocketHandle], byte 0
        jl short .1
        xor eax, eax
        pop esi
        pop ecx
        pop ebx
        ret
.1:
        xor eax, eax
        mov ax, word [NetPlayerNameLength]
        cmp eax, esi
        jg short .2
        xor eax, eax
        pop esi
        pop ecx
        pop ebx
        ret
.2:
        push dword 0C0h
        push NetSocket
        call ZeroMem
        mov edx, esi
        lea eax, [nosplit edx*4+00h]
        add esp, byte 8
        add eax, edx
        mov edx, dword [NetPlayerNameSet]
        shl eax, 4
        push NetHostName
        add eax, edx
        push NetHostName
        add eax, byte 40h
        push eax
        push NetHostSessionName
        push NetSocket
        call NetOpenSession
        add esp, byte 14h
        test eax, eax
        je short .3
        mov eax, 1
        mov word [IpxSocketHandle], si
.3:
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; LeaveNetGame                                    E5D6C  97 PC, low confidence
; Leaves the network game
;-----------------------------------------------------------------------------
LeaveNetGame:
        push ebx
        push ecx
        push edx
        cmp word [IpxSocketHandle], byte 0
        jl short .1
        push NetSocket
        mov ebx, 0FFFFFFFFh
        call NetCloseSession
        add esp, byte 4
        mov word [IpxSocketHandle], bx
.1:
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; AddFoundGame                                    E5D98  97 PC, low confidence
; Adds a found network game to the list
;-----------------------------------------------------------------------------
AddFoundGame:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov ebp, dword [byte esp+01Ch]
        cmp word [NetGameCount], byte 10h
        jl short .1
        xor eax, eax
        jmp near .8
.1:
        mov edx, str_NHL97
        lea eax, [byte ebp+020h]
        call strcmp_
        test eax, eax
        jne near .7
        mov bx, word [NetFoundCount]
        mov ax, word [NetGameCount]
        cmp ax, bx
        jge near .7
        cmp dword [NetGameList], byte 0
        je near .6
        mov edx, 1
        xor ebx, ebx
        xor esi, esi
.2:
        mov eax, dword [NetGameCountPad]
        sar eax, 10h
        cmp esi, eax
        jge short .3
        mov eax, dword [NetGameList]
        mov edx, ebp
        add eax, ebx
        call stricmp_
        mov edx, eax
        test eax, eax
        jge short .3
        inc esi
        add ebx, byte 34h
        jmp short .2
.3:
        test edx, edx
        je near .7
        mov eax, dword [NetGameCountPad]
        sar eax, 10h
        cmp esi, eax
        jge short .5
        cmp eax, esi
        jle short .5
        mov edx, eax
        shl eax, 2
        sub eax, edx
        shl eax, 2
        add eax, edx
        shl eax, 2
        lea ebx, [byte eax-034h]
        mov edi, eax
        lea eax, [nosplit esi*4+00h]
        sub eax, esi
        shl eax, 2
        add eax, esi
        shl eax, 2
        mov dword [esp], eax
        sub eax, byte 34h
        mov dword [esp], eax
.4:
        mov eax, dword [NetGameList]
        push byte 34h
        lea edx, [eax+edi]
        push edx
        add eax, ebx
        push eax
        call bcopy
        add esp, byte 0Ch
        sub ebx, byte 34h
        mov ecx, dword [esp]
        sub edi, byte 34h
        cmp ebx, ecx
        jg short .4
.5:
        lea ebx, [nosplit esi*4+00h]
        sub ebx, esi
        shl ebx, 2
        add ebx, esi
        mov eax, dword [NetGameList]
        shl ebx, 2
        mov edx, ebp
        add eax, ebx
        call strcpy_
        mov eax, dword [NetGameList]
        mov esi, dword [byte esp+024h]
        lea edi, [byte ebx+eax+020h]
        movsd
        movsd
        movsd
        movsd
        movsd
        inc word [NetGameCount]
        mov eax, 1
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
.6:
        mov ecx, eax
        inc ecx
        mov word [NetGameCount], cx
.7:
        mov eax, 1
.8:
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
;-----------------------------------------------------------------------------
; FindNetworkGames                                E5EE0  97 PC, low confidence
; Looks for open "GAMEADDR" games on the network (AddFoundGame matches "NHL97"
; entries)
;-----------------------------------------------------------------------------
FindNetworkGames:
        push ebx
        push ecx
        push edx
        push esi
        mov edx, dword [NetGameList]
        test edx, edx
        je short .1
        push edx
        call FreeMemBlock
        xor ecx, ecx
        add esp, byte 4
        mov dword [NetGameList], ecx
.1:
        mov ebx, 3E8h
        xor edx, edx
        mov eax, 2
        mov word [NetGameCount], dx
        mov word [NetFoundCount], bx
        call SecondsToSamples
        call WaitSoundTime
        push byte 1Eh
        push AddFoundGame
        push NetSocket
        call NetAnnounce
        add esp, byte 0Ch
        mov eax, dword [tickcount]
        lea ebx, [byte eax+05h]
        call ServiceIdle
        mov cx, word [NetGameCount]
        test cx, cx
        jle near .4
        mov word [NetFoundCount], cx
        mov edx, dword [NetFoundCountPad]
        sar edx, 10h
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        shl eax, 2
        add eax, edx
        push byte 0
        shl eax, 2
        push eax
        xor esi, esi
        push str_GAMEADDR
        mov word [NetGameCount], si
        call AllocMemBlock
        add esp, byte 0Ch
        mov dword [NetGameList], eax
        mov eax, 2
        call SecondsToSamples
        call WaitSoundTime
.2:
        mov eax, dword [tickcount]
        cmp eax, ebx
        jge short .3
        call ServiceIdle
        jmp short .2
.3:
        push byte 1Eh
        push AddFoundGame
        push NetSocket
        call NetAnnounce
        add esp, byte 0Ch
        call ServiceIdle
.4:
        mov eax, dword [NetGameCountPad]
        sar eax, 10h
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; DrawNetGameList                                 E5FD8  97 PC, low confidence
; Draws the list of network games
;-----------------------------------------------------------------------------
DrawNetGameList:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov edx, dword [NetListLayer]
        push edx
        call SetDrawTarget
        add esp, byte 4
        push byte 0
        mov eax, dword [NetListArt]
        push byte 0
        mov ebx, dword [byte eax+02Ch]
        push ebx
        call BlitArt
        mov edx, dword [NetScreenItems]
        mov ecx, dword [NetListTop]
        mov eax, dword [dword edx+02BAh]
        add esp, byte 0Ch
        sub eax, ecx
        mov esi, dword [NetListRows]
        push eax
        mov eax, dword [dword edx+02B6h]
        sub eax, esi
        push eax
        mov edi, dword [dword edx+02AAh]
        push edi
        call DrawArt
        mov eax, dword [NetScreenItems]
        mov dword [dword eax+029Ch], 1
        mov edx, dword [NetScreenItems]
        mov ebp, dword [NetListTop]
        mov eax, dword [dword edx+030Ch]
        add esp, byte 0Ch
        sub eax, ebp
        mov ebx, dword [NetListRows]
        push eax
        mov eax, dword [dword edx+0308h]
        sub eax, ebx
        push eax
        mov ecx, dword [dword edx+02FCh]
        push ecx
        call DrawArt
        mov eax, dword [NetScreenItems]
        mov dword [dword eax+02EEh], 1
        mov dx, word [NetGameCount]
        add esp, byte 0Ch
        test dx, dx
        jle near .3
        mov esi, dword [NetListFirst]
        push byte 0FFFFFFFFh
        lea edi, [nosplit esi*4+00h]
        call MakeColor
        sub edi, esi
        add esp, byte 4
        shl edi, 2
        mov ebx, 3
        add edi, esi
        call SetTextColor
        shl edi, 2
.1:
        mov eax, dword [NetGameCountPad]
        sar eax, 10h
        cmp esi, eax
        jge near .4
        cmp esi, dword [NetListChoice]
        jne short .2
        push dword 0FFAA0000h
        call MakeColor
        add esp, byte 4
        push eax
        mov eax, dword [LinkTextFont]
        push eax
        imul eax, ebx
        push dword 14Ah
        push eax
        push byte 14h
        call FillRect
        mov edx, dword [NetGameList]
        add esp, byte 14h
        mov eax, NetGameName
        add edx, edi
        call strcpy_
.2:
        mov eax, dword [NetGameList]
        add eax, edi
        add eax, byte 8
        push eax
        mov eax, dword [LinkTextFont]
        imul eax, ebx
        push eax
        push byte 19h
        inc esi
        push byte 0
        add edi, byte 34h
        inc ebx
        call DrawTextAligned
        add esp, byte 10h
        cmp ebx, byte 9
        jl short .1
        jmp short .4
.3:
        push dword 0FFAAAAAAh
        call MakeColor
        add esp, byte 4
        call SetTextColor
        mov eax, 22Ah
        call GetLangText
        mov edx, dword [LinkTextFont]
        push eax
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        shl eax, 2
        sub eax, edx
        sar eax, 1
        push eax
        push dword 0C3h
        push byte 1
        call DrawTextAligned
        add esp, byte 10h
.4:
        call SetScreenTarget
        mov edx, dword [NetListTop]
        push edx
        mov ebx, dword [NetListRows]
        mov eax, dword [NetListLayer]
        push ebx
        mov ecx, dword [byte eax+02Ch]
        push ecx
        call BlitArt
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ChooseNetGame                                   E61AC  97 PC, low confidence
; Lets the player choose a network game
;-----------------------------------------------------------------------------
ChooseNetGame:
        push ebx
        push ecx
        push edx
        push esi
        push ebp
        mov eax, dword [tickcount]
        cmp eax, dword [NetListTick]
        jle near .20
        call PresentScreen
        call FindNetworkGames
        cmp word [NetGameCount], byte 0
        jle near .13
        cmp byte [NetGameName], 0
        je near .11
        xor ebx, ebx
.1:
        mov eax, dword [NetGameCountPad]
        sar eax, 10h
        cmp ebx, eax
        jge short .5
        imul eax, ebx, byte 34h
        mov edx, dword [NetGameList]
        add eax, edx
        mov edx, NetGameName
        call strcmp_
        test eax, eax
        jne short .4
        mov eax, dword [NetListFirst]
        mov dword [NetListChoice], ebx
        cmp ebx, eax
        jl short .2
        add eax, byte 5
        cmp ebx, eax
        jle short .3
        sub ebx, byte 5
        mov dword [NetListFirst], ebx
        test ebx, ebx
        jge short .3
        xor ebx, ebx
.2:
        mov dword [NetListFirst], ebx
.3:
        mov ebx, dword [NetGameCountPad]
        sar ebx, 10h
.4:
        inc ebx
        jmp short .1
.5:
        jne near .12
        mov ebp, dword [NetListFirst]
        sub eax, byte 6
        cmp eax, ebp
        jge short .6
        mov dword [NetListFirst], eax
.6:
        cmp dword [NetListFirst], byte 0
        jge short .7
        xor edx, edx
        mov dword [NetListFirst], edx
.7:
        mov eax, dword [NetGameCountPad]
        mov ebx, dword [NetListChoice]
        sar eax, 10h
        cmp eax, ebx
        jg short .8
        dec eax
        mov dword [NetListChoice], eax
.8:
        mov ecx, dword [NetListChoice]
        cmp ecx, dword [NetListFirst]
        jge short .9
        mov dword [NetListFirst], ecx
        jmp short .12
.9:
        mov esi, dword [NetListFirst]
        lea eax, [byte ecx-05h]
        cmp eax, esi
        jle short .10
        mov dword [NetListFirst], eax
        test eax, eax
        jge short .12
        xor ebp, ebp
        mov dword [NetListFirst], ebp
        jmp short .12
.10:
        cmp word [NetGameCount], byte 6
        jle short .12
        mov eax, dword [NetGameCountPad]
        sar eax, 10h
        sub eax, byte 6
        cmp eax, esi
        jge short .12
        mov dword [NetListFirst], eax
        jmp short .12
.11:
        xor esi, esi
        mov dword [NetListFirst], esi
        mov dword [NetListChoice], esi
.12:
        mov edx, dword [NetListChoice]
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        shl eax, 2
        add eax, edx
        mov edx, dword [NetGameList]
        shl eax, 2
        add edx, eax
        mov eax, NetGameName
        call strcpy_
        mov eax, dword [NetTitleShape]
        mov edx, dword [NetScreenItems]
        mov eax, dword [byte eax+02Ch]
        mov dword [byte edx+06Ch], eax
        mov eax, dword [NetFrameShape]
        mov edx, dword [NetScreenItems]
        mov eax, dword [byte eax+02Ch]
        mov dword [byte edx+070h], eax
        mov eax, dword [NetButtonShape]
        mov edx, dword [NetScreenItems]
        mov eax, dword [byte eax+02Ch]
        mov dword [byte edx+074h], eax
        mov eax, dword [NetScreenItems]
        mov word [byte eax+06Ah], 0
        jmp short .14
.13:
        mov ebx, 0FFFFFFFFh
        xor ecx, ecx
        xor ah, ah
        mov dword [NetListFirst], ecx
        mov byte [NetGameName], ah
        mov eax, dword [NetTitleShape]
        mov dword [NetListChoice], ebx
        mov edx, dword [NetScreenItems]
        mov eax, dword [byte eax+02Ch]
        mov dword [byte edx+06Ch], eax
        mov eax, dword [NetScreenItems]
        mov dword [byte eax+070h], ecx
        mov eax, dword [NetScreenItems]
        mov dword [byte eax+074h], ecx
        mov eax, dword [NetScreenItems]
        mov word [byte eax+06Ah], 3
.14:
        mov ebx, 0A4h
        xor eax, eax
.15:
        mov edx, dword [NetGameCountPad]
        sar edx, 10h
        cmp eax, edx
        jge short .16
        mov edx, dword [NetScreenItems]
        mov word [byte edx+ebx+018h], 0
        mov edx, dword [NetScreenItems]
        mov dword [byte edx+ebx+02Eh], 100h
        jmp short .17
.16:
        mov edx, dword [NetScreenItems]
        mov word [byte edx+ebx+018h], 3
        mov edx, dword [NetScreenItems]
        mov dword [byte edx+ebx+02Eh], 0
.17:
        inc eax
        add ebx, byte 52h
        cmp eax, byte 6
        jl short .15
        cmp word [NetGameCount], byte 6
        jle near .18
        mov eax, dword [NetScrollUpShape]
        mov edx, dword [NetScreenItems]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword edx+02AEh], eax
        mov eax, dword [NetScrollDownShape]
        mov edx, dword [NetScreenItems]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword edx+02B2h], eax
        mov eax, dword [NetScreenItems]
        mov word [dword eax+02A8h], 0
        mov eax, dword [NetScreenItems]
        mov dword [dword eax+02BEh], 100h
        mov edx, dword [NetJoinShape]
        mov eax, dword [NetScreenItems]
        mov edx, dword [byte edx+02Ch]
        mov dword [dword eax+0300h], edx
        mov eax, dword [NetHostShape]
        mov edx, dword [NetScreenItems]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword edx+0304h], eax
        mov eax, dword [NetScreenItems]
        mov word [dword eax+02FAh], 0
        mov eax, dword [NetScreenItems]
        mov dword [dword eax+0310h], 100h
        jmp short .19
.18:
        mov eax, dword [NetScreenItems]
        mov dword [dword eax+02AEh], 0
        mov eax, dword [NetScreenItems]
        mov dword [dword eax+02B2h], 0
        mov eax, dword [NetScreenItems]
        mov word [dword eax+02A8h], 3
        mov eax, dword [NetScreenItems]
        mov dword [dword eax+02BEh], 0
        mov eax, dword [NetScreenItems]
        mov dword [dword eax+0300h], 0
        mov eax, dword [NetScreenItems]
        mov dword [dword eax+0304h], 0
        mov eax, dword [NetScreenItems]
        mov word [dword eax+02FAh], 3
        mov eax, dword [NetScreenItems]
        mov dword [dword eax+0310h], 0
.19:
        mov eax, dword [NetScreenItems]
        mov dword [byte eax+0Ch], 1
        mov eax, dword [NetScreenItems]
        mov dword [byte eax+05Eh], 1
        mov eax, dword [NetScreenItems]
        mov dword [dword eax+029Ch], 1
        mov eax, dword [NetScreenItems]
        mov dword [dword eax+02EEh], 1
        call SetScreenTarget
        call DrawNetGameList
        mov eax, dword [tickcount]
        add eax, 12Ch
        mov dword [NetListTick], eax
.20:
        pop ebp
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
ChooseNetworkGameScreenJumpTable:               ; jump table for the switch cases of ChooseNetworkGameScreen
        dd ChooseNetworkGameScreen_A51
        dd ChooseNetworkGameScreen_A99
        dd ChooseNetworkGameScreen_BA2
        dd ChooseNetworkGameScreen_BA2
        dd ChooseNetworkGameScreen_BA2
        dd ChooseNetworkGameScreen_BA2
        dd ChooseNetworkGameScreen_BA2
        dd ChooseNetworkGameScreen_BA2
        dd ChooseNetworkGameScreen_AE5
        dd ChooseNetworkGameScreen_B21
;-----------------------------------------------------------------------------
; ChooseNetworkGameScreen                         E657C  97 PC, low confidence
; Network play: the "Choose a game:" list of open games
;-----------------------------------------------------------------------------
ChooseNetworkGameScreen:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 44h
        mov dword [byte esp+030h], eax
        mov edx, dword [LinkTextFont]
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        shl eax, 2
        add eax, edx
        push byte 20h
        mov dword [byte esp+044h], eax
        mov eax, dword [ViewScreenWidth]
        mov edx, 0FFFFFFFFh
        sar eax, 1
        mov dword [byte esp+030h], edx
        sub eax, 0C8h
        mov edx, dword [ViewScreenHeight]
        mov dword [NetListRows], eax
        mov eax, dword [byte esp+044h]
        sar edx, 1
        sar eax, 1
        push dword 334h
        sub edx, eax
        push str_PICKS2
        mov dword [NetListTop], edx
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 20h
        push dword 280h
        push str_REGS2
        mov dword [NetScreenItems], eax
        call AllocMemBlock
        add esp, byte 0Ch
        push byte 0
        mov ebx, dword [byte esp+044h]
        push ebx
        push dword 190h
        mov dword [NetListBitmap], eax
        call CreateBitmap
        add esp, byte 0Ch
        push byte 0
        mov ecx, dword [byte esp+044h]
        push ecx
        push dword 190h
        mov ebx, eax
        mov dword [byte esp+040h], eax
        call CreateBitmap
        add esp, byte 0Ch
        push byte 0
        mov esi, dword [byte esp+044h]
        push esi
        push dword 190h
        mov dword [NetListArt], eax
        call CreateBitmap
        add esp, byte 0Ch
        mov dword [NetListLayer], eax
        call SetScreenTarget
        mov eax, dword [ViewScreenWidth]
        mov edi, dword [NetListTop]
        sar eax, 1
        push edi
        sub eax, 0C8h
        push eax
        mov ebp, dword [byte ebx+02Ch]
        push ebp
        call ConvertArtXY
        add esp, byte 0Ch
        call PresentScreen
        mov eax, dword [NetListArt]
        push eax
        call SetDrawTarget
        add esp, byte 4
        push byte 0
        push byte 0
        mov edx, dword [byte ebx+02Ch]
        push edx
        mov ebx, esi
        call BlitArt
        add esp, byte 0Ch
        xor ebx, esi
        mov ecx, 190h
        push esi
        mov eax, 3
        xor edx, edx
        call DrawEditBox
        mov edx, dword [LinkTextFont]
        lea eax, [nosplit edx*8+00h]
        add eax, edx
        mov ecx, 15Eh
        push eax
        lea ebx, [nosplit edx*4+00h]
        mov eax, 7
        sub ebx, edx
        mov edx, 14h
        call DrawEditBox
        mov ebx, 190h
        mov ecx, esi
        xor edx, edx
        xor eax, eax
        call DrawFrameBox
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        call SetTextColor
        mov eax, 22Bh
        call GetLangText
        push eax
        mov ecx, dword [LinkTextFont]
        push ecx
        push dword 0C8h
        mov ebp, 0FFFFFFFFh
        push byte 1
        xor edi, edi
        xor esi, esi
        call DrawTextAligned
        add esp, byte 10h
.1:
        push byte 0
        push str_LX003
        mov eax, dword [FrontShapeFile]
        push eax
        call FindShape
        mov eax, dword [byte eax+04h]
        add esp, byte 8
        sar eax, 10h
        push eax
        push str_LX003
        mov edx, dword [FrontShapeFile]
        push edx
        call FindShape
        mov eax, dword [byte eax+02h]
        add esp, byte 8
        sar eax, 10h
        push eax
        call CreateBitmap
        add esp, byte 0Ch
        push byte 0
        mov dword [byte esp+esi+04h], eax
        push str_LC003
        mov ebx, dword [FrontShapeFile]
        push ebx
        call FindShape
        mov eax, dword [byte eax+04h]
        add esp, byte 8
        sar eax, 10h
        push eax
        push str_LC003
        mov ecx, dword [FrontShapeFile]
        push ecx
        call FindShape
        mov eax, dword [byte eax+02h]
        add esp, byte 8
        sar eax, 10h
        push eax
        call CreateBitmap
        add esp, byte 0Ch
        mov dword [dword esi+NetTitleShape], eax
        mov eax, dword [esp+esi]
        mov dx, word [NetListRows]
        mov eax, dword [byte eax+02Ch]
        add edx, byte 32h
        mov word [byte eax+0Ch], dx
        mov edx, dword [byte esp+040h]
        add dx, word [NetListTop]
        mov eax, dword [esp+esi]
        mov eax, dword [byte eax+02Ch]
        sub edx, byte 32h
        mov word [byte eax+0Eh], dx
        mov eax, dword [dword esi+NetTitleShape]
        mov dx, word [NetListRows]
        mov eax, dword [byte eax+02Ch]
        add edx, 15Eh
        mov bx, word [byte eax+04h]
        sub edx, ebx
        mov word [byte eax+0Ch], dx
        mov ecx, dword [byte esp+040h]
        mov dx, word [NetListTop]
        mov eax, dword [dword esi+NetTitleShape]
        add edx, ecx
        mov eax, dword [byte eax+02Ch]
        sub edx, byte 32h
        mov word [byte eax+0Eh], dx
        mov eax, dword [esp+esi]
        mov eax, dword [byte eax+02Ch]
        mov edx, dword [byte eax+0Ch]
        mov ebx, dword [NetListTop]
        sar edx, 10h
        sub edx, ebx
        push edx
        mov edx, dword [byte eax+0Ah]
        mov ecx, dword [NetListRows]
        sar edx, 10h
        sub edx, ecx
        push edx
        push eax
        call ConvertArtXY
        add esp, byte 0Ch
        mov eax, dword [dword esi+NetTitleShape]
        mov eax, dword [byte eax+02Ch]
        mov edx, dword [byte eax+0Ch]
        mov ebx, dword [NetListTop]
        sar edx, 10h
        sub edx, ebx
        push edx
        mov edx, dword [byte eax+0Ah]
        mov ecx, dword [NetListRows]
        sar edx, 10h
        sub edx, ecx
        push edx
        push eax
        call ConvertArtXY
        add esp, byte 0Ch
        mov eax, dword [esp+esi]
        mov eax, dword [byte eax+02Ch]
        mov dx, word [NetListRows]
        add word [byte eax+0Ch], dx
        mov eax, dword [esp+esi]
        mov eax, dword [byte eax+02Ch]
        mov dx, word [NetListTop]
        add word [byte eax+0Eh], dx
        mov eax, dword [dword esi+NetTitleShape]
        mov eax, dword [byte eax+02Ch]
        mov dx, word [NetListRows]
        add word [byte eax+0Ch], dx
        mov eax, dword [dword esi+NetTitleShape]
        mov eax, dword [byte eax+02Ch]
        mov dx, word [NetListTop]
        add word [byte eax+0Eh], dx
        mov eax, dword [esp+esi]
        push eax
        call SetDrawTarget
        add esp, byte 4
        test edi, edi
        jne short .2
        mov ebx, dword [MenuScreenBitmap]
        push ebx
        push str_LX003
        mov ecx, dword [FrontShapeFile]
        push ecx
        call FindShape
        add esp, byte 8
        push eax
        call ConvertArtNew
        mov edx, dword [byte eax+04h]
        add esp, byte 8
        sar edx, 10h
        push edx
        mov edx, dword [byte eax+02h]
        sar edx, 10h
        push edx
        push edi
        mov ebx, 10h
        push edi
        mov edx, dword [byte esp+010h]
        xor ecx, ecx
        push edi
        mov edx, dword [byte edx+02Ch]
        mov dword [byte esp+04Ch], eax
        call DrawShadedLogo
        jmp short .3
.2:
        push ebp
        push str_LX0D3
        lea eax, [byte esp+02Ch]
        push eax
        call sprintf_
        add esp, byte 0Ch
        push byte 0
        push byte 0
        lea eax, [byte esp+02Ch]
        push eax
        mov edx, dword [FrontShapeFile]
        push edx
        call FindShape
        add esp, byte 8
        push eax
        call DrawArt
        add esp, byte 0Ch
.3:
        mov eax, dword [dword esi+NetTitleShape]
        push eax
        call SetDrawTarget
        add esp, byte 4
        test edi, edi
        jne short .4
        mov ebx, dword [MenuScreenBitmap]
        push ebx
        push str_LC003
        mov ecx, dword [FrontShapeFile]
        push ecx
        call FindShape
        add esp, byte 8
        push eax
        call ConvertArtNew
        mov edx, dword [byte eax+04h]
        add esp, byte 8
        sar edx, 10h
        push edx
        mov edx, dword [byte eax+02h]
        sar edx, 10h
        push edx
        push edi
        mov ebx, 10h
        push edi
        mov edx, dword [NetTitleShape]
        xor ecx, ecx
        push edi
        mov edx, dword [byte edx+02Ch]
        mov dword [byte esp+050h], eax
        call DrawShadedLogo
        jmp short .5
.4:
        push ebp
        push str_LC0D3
        lea eax, [byte esp+02Ch]
        push eax
        call sprintf_
        add esp, byte 0Ch
        push byte 0
        push byte 0
        lea eax, [byte esp+02Ch]
        push eax
        mov edx, dword [FrontShapeFile]
        push edx
        call FindShape
        add esp, byte 8
        push eax
        call DrawArt
        add esp, byte 0Ch
.5:
        mov eax, dword [NetListArt]
        add esi, byte 4
        push eax
        inc ebp
        inc edi
        call SetDrawTarget
        add esp, byte 4
        cmp edi, byte 9
        jl near .1
        mov eax, 0Ah
        mov edx, dword [NetScreenItems]
        call InitMenuItems
        mov eax, dword [esp]
        mov edx, dword [NetScreenItems]
        mov eax, dword [byte eax+02Ch]
        mov dword [byte edx+01Ah], eax
        mov edx, dword [byte esp+04h]
        mov eax, dword [NetScreenItems]
        mov edx, dword [byte edx+02Ch]
        mov dword [byte eax+01Eh], edx
        mov edx, dword [byte esp+08h]
        mov eax, dword [NetScreenItems]
        mov edx, dword [byte edx+02Ch]
        mov dword [byte eax+022h], edx
        mov eax, dword [NetScreenItems]
        mov dword [byte eax+010h], 4
        mov eax, dword [NetScreenItems]
        mov edx, dword [byte eax+01Ah]
        mov edx, dword [byte edx+0Ah]
        sar edx, 10h
        mov dword [byte eax+026h], edx
        mov eax, dword [NetScreenItems]
        mov edx, dword [byte eax+01Ah]
        mov edx, dword [byte edx+0Ch]
        sar edx, 10h
        mov dword [byte eax+02Ah], edx
        mov eax, dword [NetScreenItems]
        mov edx, dword [NetListBitmap]
        mov dword [byte eax+014h], edx
        mov eax, dword [NetScreenItems]
        mov dword [byte eax+02Eh], 101h
        mov eax, dword [NetScreenItems]
        mov edx, dword [byte eax+01Ah]
        mov ebx, dword [byte edx+04h]
        mov ecx, dword [byte edx+02h]
        sar ebx, 10h
        sar ecx, 10h
        mov edx, dword [byte eax+026h]
        push ebx
        mov ebx, dword [byte eax+02Ah]
        mov eax, dword [NetListBitmap]
        call SetRegionRect
        mov eax, dword [NetScreenItems]
        mov eax, dword [byte eax+01Ah]
        mov edx, dword [byte eax+0Ch]
        mov ebx, dword [NetListTop]
        sar edx, 10h
        sub edx, ebx
        push edx
        mov edx, dword [byte eax+0Ah]
        mov ecx, dword [NetListRows]
        sar edx, 10h
        sub edx, ecx
        push edx
        push eax
        call DrawArt
        mov eax, dword [NetTitleShape]
        mov edx, dword [NetScreenItems]
        mov eax, dword [byte eax+02Ch]
        mov dword [byte edx+06Ch], eax
        mov eax, dword [NetScreenItems]
        mov dword [byte eax+070h], 0
        mov eax, dword [NetScreenItems]
        mov dword [byte eax+074h], 0
        mov eax, dword [NetScreenItems]
        add esp, byte 0Ch
        mov dword [byte eax+062h], 4
        mov eax, dword [NetScreenItems]
        mov edx, dword [byte eax+06Ch]
        mov edx, dword [byte edx+0Ah]
        sar edx, 10h
        mov dword [byte eax+078h], edx
        mov eax, dword [NetScreenItems]
        mov edx, dword [byte eax+06Ch]
        mov edx, dword [byte edx+0Ch]
        sar edx, 10h
        mov dword [byte eax+07Ch], edx
        mov eax, dword [NetListBitmap]
        mov edx, dword [NetScreenItems]
        add eax, byte 40h
        mov dword [byte edx+066h], eax
        mov eax, dword [NetScreenItems]
        mov dword [dword eax+080h], 101h
        mov eax, dword [NetScreenItems]
        mov word [byte eax+06Ah], 3
        mov eax, dword [NetScreenItems]
        mov ecx, dword [byte eax+06Ch]
        mov edx, dword [byte ecx+04h]
        mov ebx, dword [byte eax+07Ch]
        sar edx, 10h
        mov ecx, dword [byte ecx+02h]
        push edx
        mov edx, dword [byte eax+078h]
        mov eax, dword [NetListBitmap]
        sar ecx, 10h
        add eax, byte 40h
        call SetRegionRect
        mov eax, dword [NetScreenItems]
        mov eax, dword [byte eax+06Ch]
        mov edx, dword [byte eax+0Ch]
        mov esi, dword [NetListTop]
        sar edx, 10h
        sub edx, esi
        push edx
        mov edx, dword [byte eax+0Ah]
        mov edi, dword [NetListRows]
        sar edx, 10h
        sub edx, edi
        push edx
        xor ebp, ebp
        push eax
        mov esi, 0A4h
        mov edi, 80h
        call DrawArt
        add esp, byte 0Ch
.6:
        mov eax, dword [NetScreenItems]
        mov dword [byte esi+eax+010h], 4
        mov eax, dword [NetListBitmap]
        lea edx, [edi+eax]
        mov eax, dword [NetScreenItems]
        mov dword [byte esi+eax+014h], edx
        mov eax, dword [NetScreenItems]
        mov dword [byte esi+eax+02Eh], 0
        mov eax, dword [NetScreenItems]
        mov word [byte esi+eax+018h], 3
        mov eax, dword [LinkTextFont]
        mov ebx, dword [LinkTextFont]
        dec eax
        lea ebx, [ebx+ebx*2]
        push eax
        add ebx, dword [NetListTop]
        mov eax, dword [LinkTextFont]
        imul eax, ebp
        mov ecx, 14Ah
        mov edx, dword [NetListRows]
        add esi, byte 52h
        add edx, byte 14h
        add ebx, eax
        mov eax, dword [NetListBitmap]
        inc ebp
        add eax, edi
        add edi, byte 40h
        call SetRegionRect
        cmp edi, 200h
        jne short .6
        xor ebx, ebx
        xor eax, eax
        xor ebp, ebp
.7:
        lea edi, [byte eax+01h]
        push edi
        push str_DTOP
        lea eax, [byte esp+02Ch]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte esp+024h]
        push eax
        mov edx, dword [FrontShapeFile]
        push edx
        call FindShape
        add esp, byte 8
        mov esi, eax
        mov eax, dword [byte eax+04h]
        push byte 20h
        sar eax, 10h
        push eax
        mov eax, dword [byte esi+02h]
        sar eax, 10h
        push eax
        call CreateBitmap
        mov dword [dword ebx+NetPlayerBitmaps], eax
        mov eax, dword [LinkTextFont]
        add esp, byte 0Ch
        lea eax, [eax+eax*2]
        push eax
        mov eax, dword [dword ebx+NetPlayerBitmaps]
        push dword 16Eh
        mov ecx, dword [byte eax+02Ch]
        push ecx
        call ConvertArtXY
        add esp, byte 0Ch
        mov eax, dword [dword ebx+NetPlayerBitmaps]
        push eax
        call SetDrawTarget
        add esp, byte 4
        push ebp
        push ebp
        push esi
        call DrawArt
        add esp, byte 0Ch
        mov edx, dword [NetListArt]
        push edx
        call SetDrawTarget
        add esp, byte 4
        push edi
        push str_DBOT
        lea eax, [byte esp+02Ch]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte esp+024h]
        push eax
        mov ecx, dword [FrontShapeFile]
        push ecx
        call FindShape
        add esp, byte 8
        mov esi, eax
        mov eax, dword [byte eax+04h]
        push byte 20h
        sar eax, 10h
        push eax
        mov eax, dword [byte esi+02h]
        sar eax, 10h
        push eax
        call CreateBitmap
        mov dword [dword ebx+NetGameBitmaps], eax
        mov edx, dword [LinkTextFont]
        mov eax, dword [byte esi+04h]
        lea edx, [edx+edx*8]
        sar eax, 10h
        add esp, byte 0Ch
        sub edx, eax
        push edx
        mov eax, dword [dword ebx+NetGameBitmaps]
        push dword 16Eh
        mov edx, dword [byte eax+02Ch]
        push edx
        call ConvertArtXY
        add esp, byte 0Ch
        mov ecx, dword [dword ebx+NetGameBitmaps]
        push ecx
        call SetDrawTarget
        add esp, byte 4
        push ebp
        push ebp
        push esi
        call DrawArt
        add esp, byte 0Ch
        mov esi, dword [NetListArt]
        push esi
        add ebx, byte 4
        call SetDrawTarget
        add esp, byte 4
        mov eax, edi
        cmp edi, byte 3
        jl near .7
        mov eax, dword [NetPlayerBitmaps]
        mov edx, dword [NetScreenItems]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword edx+02AAh], eax
        mov eax, dword [NetScreenItems]
        mov dword [dword eax+02A0h], 4
        mov eax, dword [NetListBitmap]
        mov edx, dword [NetScreenItems]
        add eax, 200h
        mov dword [dword edx+02A4h], eax
        mov eax, dword [NetListRows]
        mov edx, dword [NetScreenItems]
        add eax, 16Eh
        mov dword [dword edx+02B6h], eax
        mov edx, dword [LinkTextFont]
        lea eax, [nosplit edx*4+00h]
        mov edi, dword [NetListTop]
        sub eax, edx
        mov edx, dword [NetScreenItems]
        add eax, edi
        mov dword [dword edx+02BAh], eax
        mov eax, dword [NetScreenItems]
        mov word [dword eax+02A8h], 3
        mov eax, dword [NetScreenItems]
        push byte 15h
        mov ebx, dword [dword eax+02BAh]
        mov edx, dword [dword eax+02B6h]
        mov eax, dword [NetListBitmap]
        mov ecx, 0Eh
        add eax, 200h
        call SetRegionRect
        mov eax, dword [NetScreenItems]
        mov ebp, dword [NetListTop]
        mov edx, dword [dword eax+02BAh]
        sub edx, ebp
        mov ebx, dword [NetListRows]
        push edx
        mov edx, dword [dword eax+02B6h]
        sub edx, ebx
        push edx
        mov ecx, dword [dword eax+02AAh]
        push ecx
        call DrawArt
        mov eax, dword [NetGameBitmaps]
        mov edx, dword [NetScreenItems]
        mov eax, dword [byte eax+02Ch]
        mov dword [dword edx+02FCh], eax
        mov eax, dword [NetScreenItems]
        mov dword [dword eax+02F2h], 4
        mov edx, dword [NetListBitmap]
        mov eax, dword [NetScreenItems]
        add edx, 240h
        mov dword [dword eax+02F6h], edx
        mov eax, dword [NetListRows]
        mov edx, dword [NetScreenItems]
        add eax, 16Eh
        mov dword [dword edx+0308h], eax
        mov edx, dword [LinkTextFont]
        lea eax, [nosplit edx*8+00h]
        add eax, edx
        mov edx, dword [NetListTop]
        add edx, eax
        mov eax, dword [NetScreenItems]
        mov ebx, dword [dword eax+02FCh]
        mov ebx, dword [byte ebx+04h]
        sar ebx, 10h
        sub edx, ebx
        mov dword [dword eax+030Ch], edx
        mov eax, dword [NetScreenItems]
        mov word [dword eax+02FAh], 3
        add esp, byte 0Ch
        mov eax, dword [NetScreenItems]
        push byte 15h
        mov ebx, dword [dword eax+030Ch]
        mov edx, dword [dword eax+0308h]
        mov eax, dword [NetListBitmap]
        mov ecx, 0Eh
        add eax, 240h
        call SetRegionRect
        mov edx, dword [NetScreenItems]
        mov esi, dword [NetListTop]
        mov eax, dword [dword edx+030Ch]
        sub eax, esi
        mov edi, dword [NetListRows]
        push eax
        mov eax, dword [dword edx+0308h]
        sub eax, edi
        push eax
        mov ebp, dword [dword edx+02FCh]
        push ebp
        call DrawArt
        mov edx, 0FFFFFFFFh
        xor eax, eax
        add esp, byte 0Ch
        mov dword [NetListTick], eax
        mov dword [NetListFirst], eax
        xor ah, ah
        mov dword [NetListChoice], edx
        mov byte [NetGameName], ah
        call SetScreenTarget
        call ChooseNetGame
        call PresentScreen
        mov ebp, 2
        mov edi, 9
        mov esi, 3
.8:
        mov ecx, 0FFFFFFFFh
        lea eax, [byte esp+02Ch]
        mov ebx, 0FFFFFFFFh
        push esi
        mov edx, dword [NetScreenItems]
        mov dword [byte esp+030h], ecx
        push eax
        mov ecx, ChooseNetGame
        mov eax, 0Ah
        call RunMenu
        mov eax, dword [byte esp+02Ch]
        cmp ebp, eax
        jg short .9
        cmp eax, byte 7
        jle near ChooseNetworkGameScreen_B21.20
.9:
        mov ecx, dword [byte esp+02Ch]
        cmp edi, ecx
        jb near ChooseNetworkGameScreen_BA2
        mov eax, ecx
        jmp dword [nosplit cs:eax*4+ChooseNetworkGameScreenJumpTable]
ChooseNetworkGameScreen_A51:
        mov ebx, 1
.10:
        cmp ebx, byte 2
        jne short .11
        mov ebx, esi
.11:
        call SetScreenTarget
        mov eax, dword [esp+ebx*4]
        mov edx, dword [byte eax+02Ch]
        push edx
        call BlitShape
        add esp, byte 4
        call PresentScreen
        mov eax, dword [tickcount]
        lea edx, [byte eax+05h]
.12:
        mov eax, dword [tickcount]
        cmp eax, edx
        jge short .13
        call ServiceIdle
        jmp short .12
.13:
        inc ebx
        cmp ebx, byte 9
        jl short .10
        jmp near ChooseNetworkGameScreen_BA2
ChooseNetworkGameScreen_A99:
        mov ebx, 1
.14:
        cmp ebx, byte 2
        jne short .15
        mov ebx, esi
.15:
        call SetScreenTarget
        mov eax, dword [nosplit ebx*4+NetTitleShape]
        mov ecx, dword [byte eax+02Ch]
        push ecx
        call BlitShape
        add esp, byte 4
        call PresentScreen
        mov eax, dword [tickcount]
        lea edx, [byte eax+05h]
.16:
        mov eax, dword [tickcount]
        cmp eax, edx
        jge short .17
        call ServiceIdle
        jmp short .16
.17:
        inc ebx
        cmp ebx, byte 9
        jl short .14
        jmp near ChooseNetworkGameScreen_BA2
ChooseNetworkGameScreen_AE5:
        mov eax, dword [NetListFirst]
        test eax, eax
        jle near ChooseNetworkGameScreen_BA2
        lea edx, [byte eax-01h]
        mov ebx, dword [NetListChoice]
        mov dword [NetListFirst], edx
        lea eax, [byte edx+05h]
        cmp eax, ebx
        jge short .18
        mov dword [NetListChoice], eax
.18:
        call SetScreenTarget
        call DrawNetGameList
        call PresentScreen
        jmp near ChooseNetworkGameScreen_BA2
ChooseNetworkGameScreen_B21:
        mov eax, dword [NetGameCountPad]
        sar eax, 10h
        mov edx, dword [NetListFirst]
        sub eax, byte 6
        cmp eax, edx
        jle short ChooseNetworkGameScreen_BA2
        lea ebx, [byte edx+01h]
        mov eax, dword [NetListChoice]
        mov dword [NetListFirst], ebx
        cmp eax, ebx
        jge short .19
        mov dword [NetListChoice], ebx
.19:
        call SetScreenTarget
        call DrawNetGameList
        call PresentScreen
        jmp short ChooseNetworkGameScreen_BA2
.20:
        lea ebx, [byte eax-02h]
        mov eax, dword [NetListFirst]
        add eax, ebx
        mov dword [NetListChoice], eax
        mov eax, dword [NetGameCountPad]
        mov edx, dword [NetListChoice]
        sar eax, 10h
        mov dword [byte esp+02Ch], ebx
        cmp eax, edx
        jg short .21
        dec eax
        mov dword [NetListChoice], eax
.21:
        call SetScreenTarget
        call DrawNetGameList
        mov ebx, 0FFFFFFFFh
        call PresentScreen
        mov dword [byte esp+02Ch], ebx
ChooseNetworkGameScreen_BA2:
        mov ebx, dword [byte esp+02Ch]
        test ebx, ebx
        jl near ChooseNetworkGameScreen.8
        cmp ebx, byte 1
        jg near ChooseNetworkGameScreen.8
        call SetScreenTarget
        mov esi, dword [NetListTop]
        push esi
        mov edi, dword [NetListRows]
        mov eax, dword [byte esp+038h]
        push edi
        mov ebp, dword [byte eax+02Ch]
        push ebp
        call BlitArt
        add esp, byte 0Ch
        call PresentScreen
        cmp word [NetGameCount], byte 0
        jle short .22
        mov eax, dword [NetListChoice]
        cmp eax, byte 0FFFFFFFFh
        jle short .22
        cmp dword [byte esp+02Ch], byte 1
        jne short .22
        mov edx, eax
        shl eax, 2
        sub eax, edx
        shl eax, 2
        push byte 14h
        add eax, edx
        mov edx, dword [NetGameList]
        shl eax, 2
        mov ecx, dword [byte esp+034h]
        add eax, edx
        push ecx
        add eax, byte 20h
        push eax
        call bcopy
        add esp, byte 0Ch
        jmp short .23
.22:
        xor ebx, ebx
        mov dword [byte esp+02Ch], ebx
.23:
        mov esi, dword [NetGameList]
        test esi, esi
        je short .24
        push esi
        call FreeMemBlock
        xor ebp, ebp
        add esp, byte 4
        mov dword [NetGameList], ebp
.24:
        xor edi, edi
        xor ebx, ebx
        mov word [NetGameCount], di
.25:
        mov eax, dword [dword ebx+NetPlayerBitmaps]
        push eax
        call FreeBitmap
        add esp, byte 4
        mov edx, dword [dword ebx+NetGameBitmaps]
        push edx
        add ebx, byte 4
        call FreeBitmap
        add esp, byte 4
        cmp ebx, byte 0Ch
        jne short .25
        xor ebx, ebx
.26:
        mov ecx, dword [esp+ebx]
        push ecx
        call FreeBitmap
        add esp, byte 4
        mov esi, dword [dword ebx+NetTitleShape]
        push esi
        add ebx, byte 4
        call FreeBitmap
        add esp, byte 4
        cmp ebx, byte 24h
        jne short .26
        mov edi, dword [NetListLayer]
        push edi
        call FreeBitmap
        add esp, byte 4
        mov ebp, dword [NetListArt]
        push ebp
        call FreeBitmap
        add esp, byte 4
        mov eax, dword [byte esp+034h]
        push eax
        call FreeBitmap
        add esp, byte 4
        mov edx, dword [NetListBitmap]
        push edx
        call FreeMemBlock
        add esp, byte 4
        mov ebx, dword [NetScreenItems]
        push ebx
        call FreeMemBlock
        add esp, byte 4
        mov ecx, dword [byte esp+038h]
        push ecx
        call FreeMemBlock
        add esp, byte 4
        mov esi, dword [byte esp+03Ch]
        push esi
        call FreeMemBlock
        add esp, byte 4
        mov eax, dword [byte esp+02Ch]
        add esp, byte 44h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; CopyJoinedGameInfo                              E728C  97 PC, low confidence
; Copies the joined game's info
;-----------------------------------------------------------------------------
CopyJoinedGameInfo:
        push ebx
        mov edx, dword [byte esp+0Ch]
        mov ebx, 5Ch
        mov eax, NetJoinedInfo
        call memcpy_
        mov edx, 1
        mov dword [NetJoinedOk], edx
        mov eax, edx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; JoinNetworkGame                                 E72B0  97 PC, low confidence
; Network play: "Waiting for connection", runs ChooseNetworkGameScreen and
; connects to the chosen game
;-----------------------------------------------------------------------------
JoinNetworkGame:
        push esi
        push edi
        push ebp
        sub esp, byte 5Ch
        mov esi, eax
        mov dword [byte esp+058h], edx
        mov ebp, ecx
        mov dword [ecx], 0
        cmp word [NetJoinPending], byte 0
        je short .1
        xor eax, eax
        jmp near .11
.1:
        push byte 32h
        call SetTickDeadline
        add esp, byte 4
        call WaitTickDeadline
        push byte 28h
        push NetJoinRequest
        call ZeroMem
        add esp, byte 8
        push byte 32h
        call SetTickDeadline
        add esp, byte 4
        call WaitTickDeadline
        mov edx, 1
        mov eax, dword [byte esp+058h]
        mov dword [NetJoinRequest+20h], ebx
        xor ecx, ecx
        mov dword [NetJoinRequest+4], edx
        mov dword [NetJoinRequest+8], ecx
        mov dword [NetJoinRequest+0Ch], ecx
        mov dword [NetJoinRequest+10h], ecx
        mov dword [NetJoinRequest+14h], eax
        mov eax, dword [byte esp+06Ch]
        mov edx, NetSocket
        mov dword [NetJoinRequest+24h], eax
        mov dword [NetJoinSocket], edx
        test byte [esi], 1
        je near .6
        mov ebx, 44h
        mov eax, esp
        xor edx, edx
        mov dword [NetJoinedOk], ecx
        call memset_
        mov ecx, dword [StaticBuffer]
        push ecx
        push str_08x
        lea eax, [byte esp+08h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea edx, [byte esi+06h]
        mov eax, esp
        call strcat_
        mov edx, str_NHL97
        lea eax, [byte esp+020h]
        call strcpy_
        push CopyJoinedGameInfo
        push str_KWKJSK122691
        lea eax, [byte esp+08h]
        push eax
        mov esi, 2
        push NetSocket
        mov dword [byte esp+050h], esi
        call NetLeaveGame
        add esp, byte 10h
        test eax, eax
        jne short .2
        mov ecx, 1
        push eax
        xor ebx, ebx
        mov eax, 22Ch
        mov edx, ecx
        call GetLangText
        call ShowMessageBox
        xor eax, eax
        add esp, byte 5Ch
        pop ebp
        pop edi
        pop esi
        ret 4
.2:
        mov eax, 160h
        call GetLangText
        call ShowLinkMessage
        cmp dword [NetJoinedOk], byte 0
        jne short .5
.3:
        cmp dword [byte esp+058h], byte 0
        je short .4
        push byte 0
        call dword [byte esp+05Ch]
        add esp, byte 4
        test eax, eax
        je short .4
        push NetSocket
        call NetDisconnectPeer
        add esp, byte 4
        call HideLinkBox
        xor eax, eax
        add esp, byte 5Ch
        pop ebp
        pop edi
        pop esi
        ret 4
.4:
        call ServiceIdle
        cmp dword [NetJoinedOk], byte 0
        je short .3
.5:
        mov edi, NetJoinedGame
        mov esi, NetJoinedInfo
        movsd
        movsd
        movsd
        movsd
        movsd
        call HideLinkBox
        push byte 0
        push NetSocket
        call NetListGames
        add esp, byte 8
        test eax, eax
        jne near .9
        push NetSocket
        call NetDisconnectPeer
        add esp, byte 4
        xor ebx, ebx
        mov ecx, 1
        push byte 0
        mov eax, 22Dh
        mov edx, ecx
        call GetLangText
        call ShowMessageBox
        xor eax, eax
        add esp, byte 5Ch
        pop ebp
        pop edi
        pop esi
        ret 4
.6:
        xor edi, edi
.7:
        lea eax, [byte esp+044h]
        call ChooseNetworkGameScreen
        test eax, eax
        je near .11
        push str_KWKJSK122691
        lea eax, [byte esp+048h]
        push eax
        push NetSocket
        call NetJoinGame
        add esp, byte 0Ch
        mov esi, eax
        test eax, eax
        jne short .8
        mov eax, 22Eh
        mov ecx, 1
        push edi
        mov ebx, edi
        mov edx, ecx
        call GetLangText
        call ShowMessageBox
.8:
        test esi, esi
        je short .7
        lea esi, [byte esp+044h]
        mov edi, NetJoinedGame
        movsd
        movsd
        movsd
        movsd
        movsd
.9:
        push byte 4
        push dword 0FAh
        push byte 0
        push byte 20h
        push NetJoinRequest
        call OpenNetPacketLink
        add esp, byte 14h
        test eax, eax
        jne short .10
        push NetSocket
        call NetDisconnectPeer
        add esp, byte 4
        xor ebx, ebx
        mov ecx, 1
        push byte 0
        mov eax, 22Fh
        mov edx, ecx
        call GetLangText
        call ShowMessageBox
        xor eax, eax
        add esp, byte 5Ch
        pop ebp
        pop edi
        pop esi
        ret 4
.10:
        mov ebx, 0FAh
        xor ecx, ecx
        mov dword [str_Punct_ModemSettingsScreen], ebx
        mov ebx, 1
        mov dword [NetJoinRequest+14h], ecx
        mov word [NetJoinPending], bx
        mov eax, 1
        mov dword [byte ebp+00h], NetJoinRequest
.11:
        add esp, byte 5Ch
        pop ebp
        pop edi
        pop esi
        ret 4
;-----------------------------------------------------------------------------
; CloseNetConnection                              E7570  97 PC, low confidence
; Closes the network connection
;-----------------------------------------------------------------------------
CloseNetConnection:
        push ebx
        push ecx
        push edx
        cmp word [NetJoinPending], byte 0
        je short .1
        push NetSocket
        xor edx, edx
        xor ebx, ebx
        mov dword [NetJoinRequest+20h], edx
        call NetDisconnectPeer
        add esp, byte 4
        mov word [NetJoinPending], bx
.1:
        pop edx
        pop ecx
        pop ebx
        ret
