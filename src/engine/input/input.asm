; Game input: keyboard, input driver, joysticks and input recording.
bits 32
%include "hockey.inc"
section s_E258C progbits alloc exec nowrite align=1
extern __CHK, addtimer, bcopy, ClearLinkInputs, GripDriverPtr, HotKeyFlags, InputPlaybackOn, InputRecordCount
extern InputRecordHead, InputRecordOn, InputRecordPaused, InputRecordRing, InputRecordStamp, InputRecordStopped, InputRecordTail, InputRecordTaken
extern IsKeyDown, JoystickAltKey, JoystickAxisScale, JoystickButtonMap, JoystickDownKey, JoystickFireKey, JoystickFlags, JoystickLeftKey
extern JoystickRightKey, JoystickUpKey, KeyboardControlOn, KeyboardControls, KeyboardLastKey, KeyboardPadAwayOn, KeyboardPadHomeOn, KeyPollTick
extern KeyRepeatOn, KeyRepeatTick, LinkFrameDelay, LinkGameActive, LinkInputFrame, LinkInputTick, LinkSyncMenu, mousex
extern mousey, PadButtonState, PadChanged, PadHoldCount, PadHoldTicks, PadLastButtons, PadPollTick, PadRepeatTicks
extern PadSlotFlags, PresentFuncInput, RemoveTimerCallback, SlotTableCount, slotteam, SlotWords, str_Punct_ReadJoystickPads, tickcount
extern UpdateOptionsAnim, ViewScreenHeight, ViewScreenWidth, ZeroMem
global ReadKeyboardPad, ReadKeyboardPlayers, ReadInputDriver, ReadJoystickPads, PollControllers, InputRecordTimer, InitSlotTable, StartInputRecording
global StopInputTimer, StartInputTimer, ResetInputState, IsInputRecording, StopInputRecording, InputRecordAvail, TakeInputRecord
        db 00h,00h,00h,00h
;-----------------------------------------------------------------------------
; ReadKeyboardPad                                 E2590  97 PC, low confidence
; Reads a keyboard pad
;-----------------------------------------------------------------------------
ReadKeyboardPad:
        push ecx
        push esi
        mov esi, edx
        shl eax, 2
        cmp byte [dword eax+KeyboardControls], 0
        je short .1
        cmp dword [KeyboardPadAwayOn], byte 0
        je near .4
        mov eax, dword [dword eax+KeyboardControls]
        sar eax, 10h
        push eax
        call IsKeyDown
        add esp, byte 4
        test eax, eax
        je short .4
        jmp short .3
.1:
        cmp byte [dword eax+KeyboardControlOn], 0
        je short .2
        cmp dword [KeyboardPadHomeOn], byte 0
        je short .4
        mov eax, dword [dword eax+KeyboardControls]
        sar eax, 10h
        push eax
        call IsKeyDown
        add esp, byte 4
        test eax, eax
        je short .4
        jmp short .3
.2:
        cmp dword [KeyboardPadAwayOn], byte 0
        jne short .4
        cmp dword [KeyboardPadHomeOn], byte 0
        jne short .4
        mov eax, dword [dword eax+KeyboardControls]
        sar eax, 10h
        push eax
        call IsKeyDown
        add esp, byte 4
        test eax, eax
        je short .4
.3:
        or word [ebx], si
.4:
        pop esi
        pop ecx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ReadKeyboardPlayers                             E2620  97 PC, low confidence
; Reads the keyboard players
;-----------------------------------------------------------------------------
ReadKeyboardPlayers:
        push ebx
        push ecx
        push edx
        mov ecx, eax
        mov edx, 10h
        mov ebx, eax
        mov eax, 2
        call ReadKeyboardPad
        mov edx, 20h
        mov eax, 3
        mov ebx, ecx
        call ReadKeyboardPad
        mov edx, 1
        mov eax, 4
        mov ebx, ecx
        call ReadKeyboardPad
        mov edx, 8
        mov eax, 4
        mov ebx, ecx
        call ReadKeyboardPad
        mov edx, 1
        mov eax, 5
        mov ebx, ecx
        call ReadKeyboardPad
        mov edx, 1
        mov eax, 6
        mov ebx, ecx
        call ReadKeyboardPad
        mov edx, 4
        mov eax, 6
        mov ebx, ecx
        call ReadKeyboardPad
        mov edx, 8
        mov eax, 7
        mov ebx, ecx
        call ReadKeyboardPad
        mov edx, 4
        mov eax, 8
        mov ebx, ecx
        call ReadKeyboardPad
        mov edx, 2
        mov eax, 9
        mov ebx, ecx
        call ReadKeyboardPad
        mov edx, 8
        mov eax, 9
        mov ebx, ecx
        call ReadKeyboardPad
        mov edx, 2
        mov eax, 0Ah
        mov ebx, ecx
        call ReadKeyboardPad
        mov edx, 2
        mov eax, 0Bh
        mov ebx, ecx
        call ReadKeyboardPad
        mov edx, 4
        mov eax, 0Bh
        mov ebx, ecx
        call ReadKeyboardPad
        mov dx, word [ecx]
        xor dh, dh
        mov eax, dword [KeyRepeatOn]
        and dl, 0Fh
        test eax, eax
        jbe short .1
        cmp eax, byte 1
        je short .3
        pop edx
        pop ecx
        pop ebx
        ret
.1:
        test dx, dx
        je short .5
        mov eax, dword [tickcount]
        cmp dx, word [KeyboardLastKey]
        jne short .2
        cmp eax, dword [KeyRepeatTick]
        jge short .2
        or byte [ecx], 40h
        mov dword [KeyRepeatTick], eax
.2:
        mov ecx, 1
        mov word [KeyboardLastKey], dx
        mov dword [KeyRepeatOn], ecx
        pop edx
        pop ecx
        pop ebx
        ret
.3:
        test dx, dx
        jne short .4
        xor edx, edx
        mov dword [KeyRepeatOn], edx
        mov eax, dword [tickcount]
        add eax, byte 0Ah
        mov dword [KeyRepeatTick], eax
        pop edx
        pop ecx
        pop ebx
        ret
.4:
        mov word [KeyboardLastKey], dx
.5:
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; ReadInputDriver                                 E2790  97 PC, low confidence
; Reads the input driver
;-----------------------------------------------------------------------------
ReadInputDriver:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov ebx, eax
        call dword [PresentFuncInput]
        mov edx, dword [ViewScreenWidth]
        mov ecx, dword [mousex]
        sar edx, 2
        cmp edx, ecx
        jle short .1
        or byte [ebx], 8
        jmp short .2
.1:
        mov ecx, dword [ViewScreenWidth]
        sar ecx, 1
        mov esi, dword [mousex]
        add edx, ecx
        cmp edx, esi
        jge short .2
        or byte [ebx], 4
.2:
        mov edx, dword [ViewScreenHeight]
        mov edi, dword [mousey]
        sar edx, 2
        cmp edx, edi
        jle short .3
        or byte [ebx], 1
        jmp short .4
.3:
        mov edx, dword [ViewScreenWidth]
        mov ecx, dword [ViewScreenHeight]
        sar edx, 2
        sar ecx, 1
        add edx, ecx
        cmp edx, edi
        jge short .4
        or byte [ebx], 2
.4:
        mov dx, word [ebx]
        xor dl, dl
        and dh, 7
        and edx, 0FFFFh
        sar edx, 8
        cmp edx, byte 4
        jne short .6
        test al, 2
        je short .5
        or byte [ebx], 10h
.5:
        test al, 1
        je short .9
        jmp short .8
.6:
        test al, 1
        je short .7
        or byte [ebx], 10h
.7:
        test al, 2
        je short .9
.8:
        or byte [ebx], 20h
.9:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; ReadJoystickPads                                E2838  97 PC, low confidence
; Reads the joystick pads
;-----------------------------------------------------------------------------
ReadJoystickPads:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        mov dx, word [eax]
        xor dl, dl
        xor ebx, ebx
        and dh, 78h
        mov bx, dx
        sar ebx, 0Bh
        mov ecx, ebx
        shl ebx, 3
        sub ebx, ecx
        mov ecx, dword [GripDriverPtr]
        mov si, word [byte ecx+ebx*8+036h]
        mov edx, esi
        xor dh, dh
        mov bx, word [eax]
        and dl, 0Fh
        or ebx, edx
        mov word [eax], bx
        mov cx, word [JoystickUpKey]
        test cx, cx
        je short .1
        xor ebx, ebx
        mov bx, cx
        xor ecx, ecx
        mov cx, si
        and ecx, ebx
        cmp ecx, ebx
        jne short .1
        or byte [eax], 10h
.1:
        mov di, word [str_Punct_ReadJoystickPads]
        test di, di
        je short .2
        xor ecx, ecx
        xor ebx, ebx
        mov cx, si
        mov bx, di
        and ecx, ebx
        cmp ecx, ebx
        jne short .2
        or byte [eax], 20h
.2:
        test byte [byte eax+01h], 80h
        jne near .7
        cmp word [JoystickDownKey], byte 0
        je short .3
        xor eax, eax
        xor ebx, ebx
        mov ax, word [JoystickDownKey]
        mov bx, si
        and ebx, eax
        cmp ebx, eax
        jne short .3
        or byte [HotKeyFlags], 40h
.3:
        mov dx, word [JoystickLeftKey]
        test dx, dx
        je short .4
        xor ebx, ebx
        xor eax, eax
        mov bx, si
        mov ax, dx
        and ebx, eax
        cmp ebx, eax
        jne short .4
        or byte [HotKeyFlags], 80h
.4:
        mov bx, word [JoystickRightKey]
        test bx, bx
        je short .5
        xor eax, eax
        mov ax, bx
        xor ebx, ebx
        mov bx, si
        and ebx, eax
        cmp ebx, eax
        jne short .5
        or byte [JoystickFlags], 1
.5:
        mov cx, word [JoystickFireKey]
        test cx, cx
        je short .6
        xor ebx, ebx
        xor eax, eax
        mov bx, si
        mov ax, cx
        and ebx, eax
        cmp ebx, eax
        jne short .6
        or byte [JoystickFlags], 2
.6:
        mov di, word [JoystickAltKey]
        test di, di
        je near .12
        xor ebx, ebx
        xor eax, eax
        mov bx, si
        mov ax, di
        and ebx, eax
        cmp ebx, eax
        jne near .12
        or byte [JoystickFlags], 40h
        jmp near .12
.7:
        cmp word [JoystickDownKey], byte 0
        je short .8
        xor eax, eax
        xor ebx, ebx
        mov ax, word [JoystickDownKey]
        mov bx, si
        and ebx, eax
        cmp ebx, eax
        jne short .8
        or byte [JoystickFlags], 4
.8:
        mov dx, word [JoystickLeftKey]
        test dx, dx
        je short .9
        xor ebx, ebx
        xor eax, eax
        mov bx, si
        mov ax, dx
        and ebx, eax
        cmp ebx, eax
        jne short .9
        or byte [JoystickFlags], 8
.9:
        mov bx, word [JoystickRightKey]
        test bx, bx
        je short .10
        xor eax, eax
        mov ax, bx
        xor ebx, ebx
        mov bx, si
        and ebx, eax
        cmp ebx, eax
        jne short .10
        or byte [JoystickFlags], 10h
.10:
        mov cx, word [JoystickFireKey]
        test cx, cx
        je short .11
        xor ebx, ebx
        xor eax, eax
        mov bx, si
        mov ax, cx
        and ebx, eax
        cmp ebx, eax
        jne short .11
        or byte [JoystickFlags], 20h
.11:
        mov di, word [JoystickAltKey]
        test di, di
        je short .12
        xor ebx, ebx
        xor eax, eax
        mov bx, si
        mov ax, di
        and ebx, eax
        cmp ebx, eax
        jne short .12
        or byte [JoystickFlags], 80h
.12:
        mov eax, 7
        xor edx, edx
.13:
        xor ebx, ebx
        mov bx, ax
        add ebx, ebx
        mov cx, word [dword ebx+JoystickUpKey]
        test cx, cx
        je short .14
        mov ebx, ecx
        xor ecx, ecx
        and ebx, 0FFFFh
        mov cx, si
        and ecx, ebx
        cmp ecx, ebx
        jne short .14
        mov ebx, 1
        mov cl, dl
        mov di, word [HotKeyFlags]
        shl ebx, cl
        or edi, ebx
        mov word [HotKeyFlags], di
.14:
        inc eax
        inc edx
        cmp ax, 0Dh
        jb short .13
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
        push ebx
        push edx
        mov ebx, HotKeyFlags
        mov edx, 1
        xor eax, eax
        call ReadKeyboardPad
        mov ebx, HotKeyFlags
        mov edx, 2
        mov eax, 1
        call ReadKeyboardPad
        pop edx
        pop ebx
        ret
        db 08Bh,0C0h
        push ebx
        push ecx
        push edx
        mov edx, eax
        mov bx, word [eax]
        mov ah, byte [eax]
        xor bh, bh
        and ah, 0F0h
        and bl, 0Fh
        mov byte [edx], ah
        cmp bx, byte 0Ah
        jbe short .15
        xor bl, bl
.15:
        xor ecx, ecx
        call JoystickAxisScale
        mov cl, al
        lea eax, [nosplit ecx*4+00h]
        sub eax, ecx
        shl eax, 2
        sub eax, ecx
        xor ecx, ecx
        mov cx, bx
        mov bl, byte [dword ecx+eax+JoystickButtonMap]
        xor bh, bh
        mov cx, word [edx]
        and bl, 0Fh
        or ecx, ebx
        mov word [edx], cx
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; PollControllers                                                 E2AF4  96 PC
; Fills 4-entry slot table (7 bytes each) from keyboard/joystick by device
; word and setup slot team
;-----------------------------------------------------------------------------
PollControllers:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 0Ch
        xor edx, edx
        push byte 1Dh
        mov word [HotKeyFlags], dx
        call IsKeyDown
        add esp, byte 4
        push byte 38h
        mov ebx, HotKeyFlags
        mov dword [KeyboardPadAwayOn], eax
        call IsKeyDown
        mov edx, 1
        add esp, byte 4
        mov dword [KeyboardPadHomeOn], eax
        xor eax, eax
        mov esi, SlotWords
        call ReadKeyboardPad
        mov ebx, HotKeyFlags
        mov edx, 2
        mov eax, 1
        xor edi, edi
        call ReadKeyboardPad
        xor edx, edx
        xor ecx, ecx
        mov dword [byte esp+08h], edx
        mov dword [esp], edx
.1:
        lea eax, [nosplit edi*2+00h]
        mov dx, word [dword eax+SlotWords]
        xor dl, dl
        and dh, 7
        mov byte [dword eax+SlotWords], dl
        and edx, 0FFFFh
        sar edx, 8
        test edx, edx
        je near .3
        mov dx, word [dword eax+SlotWords]
        xor dl, dl
        and dh, 7
        and edx, 0FFFFh
        sar edx, 8
        cmp edx, byte 1
        setne dl
        and edx, 0FFh
        je near .3
        test byte [dword eax+PadSlotFlags], 80h
        jne near .2
        cmp dword [esp], byte 0
        jne near .2
        mov eax, dword [tickcount]
        mov ebp, 1
        mov edx, dword [PadPollTick]
        mov dword [esp], ebp
        cmp eax, edx
        jle near .3
        mov ebx, HotKeyFlags
        mov edx, 40h
        mov eax, 0Ch
        call ReadKeyboardPad
        mov ebx, HotKeyFlags
        mov edx, 80h
        mov eax, 0Dh
        call ReadKeyboardPad
        mov ebx, HotKeyFlags
        mov edx, 100h
        mov eax, 0Eh
        call ReadKeyboardPad
        mov ebx, HotKeyFlags
        mov edx, 200h
        mov eax, 0Fh
        call ReadKeyboardPad
        mov ebx, HotKeyFlags
        mov edx, 4000h
        mov eax, 14h
        call ReadKeyboardPad
        mov eax, dword [tickcount]
        add eax, byte 12h
        mov dword [PadPollTick], eax
        jmp near .3
.2:
        cmp dword [byte esp+08h], byte 0
        jne near .3
        mov eax, dword [tickcount]
        mov edx, 1
        mov ebx, dword [KeyPollTick]
        mov dword [byte esp+08h], edx
        cmp eax, ebx
        jle short .3
        mov ebx, HotKeyFlags
        mov edx, 400h
        mov eax, 10h
        call ReadKeyboardPad
        mov ebx, HotKeyFlags
        mov edx, 800h
        mov eax, 11h
        call ReadKeyboardPad
        mov ebx, HotKeyFlags
        mov edx, 1000h
        mov eax, 12h
        call ReadKeyboardPad
        mov ebx, HotKeyFlags
        mov edx, 2000h
        mov eax, 13h
        call ReadKeyboardPad
        mov ebx, HotKeyFlags
        mov edx, 8000h
        mov eax, 15h
        call ReadKeyboardPad
        mov eax, dword [tickcount]
        add eax, byte 12h
        mov dword [KeyPollTick], eax
.3:
        lea edx, [nosplit edi*2+00h]
        mov ax, word [dword edx+SlotWords]
        xor al, al
        xor ebx, ebx
        and ah, 7
        mov bx, ax
        sar ebx, 8
        cmp ebx, byte 2
        jl near .12
        mov eax, SlotWords
        add eax, edx
        cmp ebx, byte 5
        jne near .8
        call ReadJoystickPads
        mov ax, word [dword edx+SlotWords]
        xor ah, ah
        xor ebx, ebx
        and al, 0Fh
        mov bx, ax
        mov eax, dword [dword ecx+PadRepeatTicks]
        test eax, eax
        jbe short .4
        cmp eax, byte 1
        je short .6
        jmp near .10
.4:
        test ebx, ebx
        je near .10
        mov eax, dword [tickcount]
        mov ebp, eax
        xor eax, eax
        mov ax, word [dword edx+PadButtonState]
        cmp ebx, eax
        jne short .5
        cmp ebp, dword [dword ecx+PadHoldTicks]
        jge short .5
        mov al, byte [dword edx+SlotWords]
        or al, 40h
        mov dword [dword ecx+PadHoldTicks], ebp
        mov byte [dword edx+SlotWords], al
.5:
        mov edx, 1
        mov word [nosplit edi*2+PadButtonState], bx
        mov dword [dword ecx+PadRepeatTicks], edx
        jmp short .10
.6:
        test ebx, ebx
        jne short .7
        mov dword [dword ecx+PadRepeatTicks], ebx
        mov eax, dword [tickcount]
        add eax, byte 0Ch
        mov dword [dword ecx+PadHoldTicks], eax
        jmp short .10
.7:
        mov word [dword edx+PadButtonState], bx
        jmp short .10
.8:
        cmp ebx, byte 2
        jne short .9
        call ReadKeyboardPlayers
        jmp short .10
.9:
        call ReadInputDriver
.10:
        mov ebx, esi
        mov dx, word [esi]
        mov ah, byte [esi]
        xor dh, dh
        and ah, 0F0h
        and dl, 0Fh
        mov byte [esi], ah
        cmp dx, byte 0Ah
        jbe short .11
        xor dl, dl
.11:
        call JoystickAxisScale
        and eax, 0FFh
        imul eax, byte 0Bh
        mov dword [byte esp+04h], eax
        xor eax, eax
        mov ebp, dword [byte esp+04h]
        mov ax, dx
        add eax, ebp
        mov dl, byte [dword eax+JoystickButtonMap]
        xor dh, dh
        mov ax, word [ebx]
        and dl, 0Fh
        or eax, edx
        mov word [ebx], ax
.12:
        add esi, byte 2
        inc edi
        add ecx, byte 4
        cmp edi, byte 8
        jl near .1
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; InputRecordTimer                                                E2E28  96 PC
; Timer callback; every 4th tick pushes 0x12-byte record (4 slot dwords +
; ticks) into ring of 5
;-----------------------------------------------------------------------------
InputRecordTimer:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        cmp word [InputRecordOn], byte 0
        je near .11
        cmp dword [InputRecordStopped], byte 0
        jne near .11
        mov dword [InputRecordStopped], 1
        cmp dword [InputRecordPaused], byte 0
        jne short .1
        call UpdateOptionsAnim
.1:
        cmp dword [InputPlaybackOn], byte 0
        jne short .2
        call PollControllers
.2:
        cmp dword [LinkGameActive], byte 0
        je short .4
        mov eax, dword [LinkInputFrame]
        call LinkInputTick
        test eax, eax
        je near .6
        mov edi, dword [LinkInputFrame]
        test edi, edi
        jne short .3
        mov eax, dword [LinkFrameDelay]
        dec eax
        mov dword [LinkInputFrame], eax
        jmp near .6
.3:
        lea ebp, [byte edi-01h]
        mov dword [LinkInputFrame], ebp
        jmp near .6
.4:
        cmp dword [InputRecordTaken], byte 0
        jne near .6
        mov dword [InputRecordTaken], 1
        cmp dword [InputPlaybackOn], byte 0
        jne short .5
        cmp dword [InputRecordCount], byte 5
        jge short .5
        mov edx, dword [InputRecordHead]
        lea eax, [nosplit edx*4+00h]
        add eax, edx
        mov ebx, InputRecordRing
        shl eax, 2
        push byte 10h
        add ebx, eax
        push ebx
        push SlotWords
        call bcopy
        mov ax, word [HotKeyFlags]
        mov word [byte ebx+012h], 3
        mov word [byte ebx+010h], ax
        mov edx, dword [InputRecordHead]
        inc edx
        mov ebx, 5
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        mov ecx, dword [InputRecordCount]
        inc ecx
        add esp, byte 0Ch
        mov dword [InputRecordCount], ecx
        mov dword [InputRecordHead], edx
        rdtsc
        mov dword [InputRecordStamp], eax
.5:
        xor esi, esi
        mov dword [InputRecordTaken], esi
.6:
        mov eax, dword [InputPlaybackOn]
        test eax, eax
        jne short .7
        mov dword [InputPlaybackOn], 2
        jmp short .8
.7:
        lea edx, [byte eax-01h]
        mov dword [InputPlaybackOn], edx
.8:
        mov ecx, dword [InputRecordPaused]
        test ecx, ecx
        jne short .9
        mov dword [InputRecordPaused], 3
        jmp short .10
.9:
        lea esi, [byte ecx-01h]
        mov dword [InputRecordPaused], esi
.10:
        xor ebp, ebp
        mov dword [InputRecordStopped], ebp
.11:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; InitSlotTable                                E2F98  96 PC, medium confidence
; Slot words and teams from the 8 controller set-up bytes
;-----------------------------------------------------------------------------
InitSlotTable:
        push ebx
        push ecx
        push edx
        push esi
        mov ebx, eax
        push byte 10h
        push SlotWords
        call ZeroMem
        add esp, byte 8
        xor edx, edx
        xor eax, eax
        mov dword [SlotTableCount], edx
        xor esi, esi
.1:
        mov ecx, dword [LinkGameActive]
        cmp esi, ecx
        jne short .2
        cmp edx, byte 4
        jge short .3
.2:
        xor ch, ch
        mov cl, byte [ebx]
        shl ecx, 8
.3:
        mov word [dword eax+SlotWords], cx
        mov cx, word [dword eax+SlotWords]
        xor cl, cl
        and ch, 7
        and ecx, 0FFFFh
        sar ecx, 8
        test ecx, ecx
        je short .5
        test byte [dword eax+PadSlotFlags], 80h
        jne short .4
        mov word [dword eax+slotteam], 1
        jmp short .6
.4:
        mov word [dword eax+slotteam], 2
        jmp short .6
.5:
        mov word [dword eax+slotteam], si
.6:
        mov cx, word [dword eax+SlotWords]
        xor cl, cl
        and ch, 7
        and ecx, 0FFFFh
        sar ecx, 8
        cmp ecx, byte 5
        jne short .7
        mov dword [SlotTableCount], 1
.7:
        add eax, byte 2
        inc edx
        inc ebx
        cmp edx, byte 8
        jl near .1
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; StartInputRecording                             E304C  97 PC, low confidence
; Starts recording input
;-----------------------------------------------------------------------------
StartInputRecording:
        push dword 18h
        call __CHK
        push ebx
        push ecx
        push edx
        cmp word [InputRecordOn], byte 0
        jne short .1
        push byte 64h
        push InputRecordRing
        mov ebx, 1
        call ZeroMem
        xor edx, edx
        add esp, byte 8
        mov dword [InputRecordTail], edx
        mov dword [InputRecordHead], edx
        mov dword [InputRecordCount], edx
        call ResetInputState
        push InputRecordTimer
        mov dword [InputPlaybackOn], edx
        mov dword [InputRecordPaused], edx
        mov dword [LinkInputFrame], edx
        call addtimer
        add esp, byte 4
        mov word [InputRecordOn], bx
.1:
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; StopInputTimer                                  E30BC  97 PC, low confidence
; Stops the input timer
;-----------------------------------------------------------------------------
StopInputTimer:
        push dword 10h
        call __CHK
        push ecx
        push edx
        push InputRecordTimer
        call RemoveTimerCallback
        add esp, byte 4
        pop edx
        pop ecx
        ret
;-----------------------------------------------------------------------------
; StartInputTimer                                 E30D8  97 PC, low confidence
; Starts the input timer
;-----------------------------------------------------------------------------
StartInputTimer:
        push dword 10h
        call __CHK
        push ecx
        push edx
        push InputRecordTimer
        call addtimer
        add esp, byte 4
        pop edx
        pop ecx
        ret
;-----------------------------------------------------------------------------
; ResetInputState                                 E30F4  97 PC, low confidence
; Resets the input state
;-----------------------------------------------------------------------------
ResetInputState:
        push dword 14h
        call __CHK
        push ebx
        push ecx
        push edx
        push esi
        mov dx, word [InputRecordOn]
        test dx, dx
        jne short .2
        call LinkSyncMenu
        mov word [KeyboardLastKey], dx
        xor edx, edx
        xor ecx, ecx
        mov dword [KeyRepeatOn], edx
        mov eax, dword [tickcount]
        mov dword [PadPollTick], eax
        mov eax, dword [tickcount]
        mov dword [KeyPollTick], eax
        call ClearLinkInputs
        mov word [HotKeyFlags], cx
        xor eax, eax
.1:
        add edx, byte 4
        add eax, byte 2
        xor bl, bl
        xor esi, esi
        mov byte [dword eax+PadChanged], bl
        xor ebx, ebx
        mov word [dword eax+PadLastButtons], si
        mov dword [dword edx+PadHoldCount], ebx
        cmp eax, byte 10h
        jne short .1
        call LinkSyncMenu
.2:
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; IsInputRecording                                E3174  97 PC, low confidence
; Returns whether input is being recorded
;-----------------------------------------------------------------------------
IsInputRecording:
        push dword 4
        call __CHK
        cmp word [InputRecordOn], byte 0
        sete al
        and eax, 0FFh
        ret
        db 090h
;-----------------------------------------------------------------------------
; StopInputRecording                              E3190  97 PC, low confidence
; Stops recording input
;-----------------------------------------------------------------------------
StopInputRecording:
        push dword 1Ch
        call __CHK
        push ebx
        push ecx
        push edx
        push esi
        cmp word [InputRecordOn], byte 0
        je short .4
.1:
        cmp dword [InputRecordStopped], byte 0
        jne short .1
        push InputRecordTimer
        call RemoveTimerCallback
        add esp, byte 4
        cmp dword [InputRecordStopped], byte 0
        je short .3
.2:
        cmp dword [InputRecordStopped], byte 0
        jne short .2
.3:
        xor ebx, ebx
        mov word [InputRecordOn], bx
        call ResetInputState
        push byte 64h
        push InputRecordRing
        xor esi, esi
        call ZeroMem
        add esp, byte 8
        mov dword [InputRecordTail], esi
        mov dword [InputRecordHead], esi
        mov dword [InputRecordCount], esi
.4:
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; InputRecordAvail                                                E3208  97 PC
; Returns InputRecordCount (Gameloop's is there a record)
;-----------------------------------------------------------------------------
InputRecordAvail:
        push dword 4
        call __CHK
        mov eax, dword [InputRecordCount]
        ret
;-----------------------------------------------------------------------------
; TakeInputRecord                                                 E3218  97 PC
; Copies the next record out of InputRecordRing
;-----------------------------------------------------------------------------
TakeInputRecord:
        push dword 24h
        call __CHK
        push ebx
        push ecx
        push edx
        push esi
        push edi
        cmp dword [InputRecordCount], byte 0
        je short .2
.1:
        cmp dword [InputRecordTaken], byte 0
        jne short .1
        mov ecx, 1
        push byte 14h
        mov dword [InputRecordTaken], ecx
        mov edx, dword [InputRecordTail]
        push eax
        lea eax, [nosplit edx*4+00h]
        add eax, edx
        shl eax, 2
        add eax, InputRecordRing
        push eax
        call bcopy
        mov edx, dword [InputRecordTail]
        inc edx
        mov ebx, 5
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        mov esi, dword [InputRecordCount]
        xor edi, edi
        dec esi
        add esp, byte 0Ch
        mov dword [InputRecordCount], esi
        mov dword [InputRecordTail], edx
        mov dword [InputRecordTaken], edi
.2:
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
