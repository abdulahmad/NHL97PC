; GrIP gamepads: the code start trap, loading and calling the GrIP library and the joystick set-up.
bits 32
%include "hockey.inc"
section s_10000 progbits alloc exec nowrite align=1
extern _nfree_, _nmalloc_, _searchenv_, AllocMemBlock, CalibrateJoystick, fclose_, fopen_, fread_
extern fseek_, ftell_, GripCodeSel, GripDataSeg, GripDriverData, GripDriverPtr, GripDriverSeg, GripDriverSel
extern GripFarCall, GripFlags, GripLinkByte, GripLinked, GripPortWord, GripReady, GripResult, GripSlot
extern JoyAxisSecondX, JoyAxisSecondY, JoyAxisValues, JoyAxisY, JoyPortMask, ResetJoystickRange, str_CGRIP, str_DOSJoystick
extern str_GRIP, str_GRIPGLL, str_JSTICKS, str_PATH2, str_Rb, strcat_, strcpy_, ZeroMem
global CodeStartTrap, CodeStartPad, GripLinkLibrary, CallGripDriver, LoadGripLibrary, InitGripDriver, LoadJoystickConfig
;-----------------------------------------------------------------------------
; CodeStartTrap                                                   10000  97 PC
; First bytes of the code: an int3 and a jump to itself, so a call through a null code pointer traps
;-----------------------------------------------------------------------------
CodeStartTrap:
        int3
        jmp short CodeStartTrap
CodeStartPad:                                   ; used by start
        db 090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h
;-----------------------------------------------------------------------------
; GripLinkLibrary                              10010  96 PC, medium confidence
; (image, size): checks the GrIP GLL image ("DB" header, sizes, xor checksum), copies it to DOS memory (DPMI
; 100h) and calls its init (8490h); 0 on failure
;-----------------------------------------------------------------------------
GripLinkLibrary:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 8
        mov ebx, eax
        cmp dword [GripLinked], byte 0
        je short .1
        xor ebx, eax
        jmp near .25
.1:
        test eax, eax
        je short .2
        cmp dx, byte 10h
        jae short .3
.2:
        xor ebx, ebx
        mov eax, ebx
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.3:
        cmp byte [eax], 44h
        jne short .4
        cmp byte [byte ebx+01h], 42h
        je short .5
.4:
        xor ebx, ebx
        mov eax, ebx
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.5:
        mov al, byte [byte ebx+02h]
        and al, 0Fh
        xor ah, ah
        mov esi, eax
        mov al, byte [byte ebx+03h]
        and al, 0Fh
        shl esi, 0Ch
        shl eax, 8
        or esi, eax
        mov al, byte [byte ebx+04h]
        and al, 0Fh
        xor ah, ah
        shl eax, 4
        or esi, eax
        mov al, byte [byte ebx+05h]
        and al, 0Fh
        xor ah, ah
        or esi, eax
        mov al, byte [byte ebx+06h]
        and al, 0Fh
        mov dword [byte esp+04h], esi
        movzx si, al
        mov al, byte [byte ebx+07h]
        and al, 0Fh
        shl esi, 0Ch
        shl eax, 8
        or esi, eax
        mov al, byte [byte ebx+08h]
        and al, 0Fh
        xor ah, ah
        shl eax, 4
        or esi, eax
        mov al, byte [byte ebx+09h]
        and al, 0Fh
        movzx di, al
        mov ah, byte [byte ebx+0Ah]
        or edi, esi
        and ah, 0Fh
        movzx ebp, di
        xor esi, esi
        shl ah, 4
        mov si, word [byte esp+04h]
        mov al, byte [byte ebx+0Bh]
        add ebp, esi
        and al, 0Fh
        shl ebp, 4
        or al, ah
        and edx, 0FFFFh
        cmp edx, ebp
        jge short .6
        xor ebx, ebx
        mov eax, ebx
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.6:
        shl esi, 4
        add ebx, esi
        mov dword [esp], ebx
        mov edx, dword [esp]
        xor ebx, ebx
        jmp short .8
.7:
        mov ch, byte [edx]
        inc edx
        inc ebx
        xor al, ch
.8:
        xor esi, esi
        mov si, di
        shl esi, 4
        cmp ebx, esi
        jl short .7
        test al, al
        je short .9
        xor ebx, ebx
        mov eax, ebx
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.9:
        mov ecx, GripDataSeg
        mov ebx, edi
        mov eax, 100h
        int 31h
        mov ebx, 0
        jb short .10
        mov ebx, eax
        shl ebx, 4
        mov word [ecx], dx
.10:
        mov ebp, ebx
        test ebx, ebx
        jne short .11
        xor ebx, ebx
        mov eax, ebx
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.11:
        mov esi, ebx
        xor edx, edx
        mov ebx, dword [esp]
        jmp short .13
.12:
        add esi, byte 4
        mov eax, dword [ebx]
        add ebx, byte 4
        inc edx
        mov dword [byte esi-04h], eax
.13:
        xor eax, eax
        mov ax, di
        shl eax, 2
        cmp edx, eax
        jl short .12
        mov eax, 0
        mov ecx, 1
        int 31h
        jae short .14
        xor eax, eax
.14:
        mov word [GripResult], ax
        test ax, ax
        jne short .16
        mov dx, word [GripDataSeg]
        mov eax, 101h
        int 31h
        jb short .15
        xor eax, eax
.15:
        xor ebx, ebx
        mov eax, ebx
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.16:
        mov esi, edi
        mov edx, ebp
        mov ebx, eax
        shl esi, 4
        mov ecx, edx
        shr ecx, 10h
        mov eax, 7
        int 31h
        jb short .17
        mov edx, esi
        dec edx
        xor ecx, ecx
        mov eax, 8
        int 31h
        jb short .17
        xor eax, eax
.17:
        test al, al
        je short .19
        mov bx, word [GripResult]
        mov eax, 1
        int 31h
        setb al
        mov dx, word [GripDataSeg]
        mov eax, 101h
        int 31h
        jb short .18
        xor eax, eax
.18:
        xor ebx, ebx
        mov eax, ebx
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.19:
        mov bx, word [GripResult]
        mov cx, cs
        lar ecx, ecx
        shr cx, 8
        mov eax, 9
        int 31h
        setb al
        test al, al
        je short .21
        mov bx, word [GripResult]
        mov eax, 1
        int 31h
        setb al
        mov dx, word [GripDataSeg]
        mov eax, 101h
        int 31h
        jb short .20
        xor eax, eax
.20:
        xor ebx, ebx
        mov eax, ebx
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.21:
        mov ebx, dword [esp]
        xor edx, edx
.22:
        inc edx
        mov al, byte [ebx]
        inc ebx
        mov byte [dword edx+GripLinkByte], al
        cmp edx, byte 0Eh
        jb short .22
        xor edx, edx
        mov ax, word [GripResult]
        mov word [GripDriverSeg], dx
        mov word [GripDriverSel], ax
        mov word [GripCodeSel], ax
        mov word [byte ebp+012h], dx
        mov word [byte ebp+016h], dx
        mov word [byte ebp+010h], dx
        mov ax, word [GripDataSeg]
        mov word [byte ebp+014h], ax
        mov ax, 8490h
        call far [GripFarCall]
        test ax, ax
        jne short .24
        mov bx, word [GripResult]
        mov eax, 1
        int 31h
        setb al
        mov dx, word [GripDataSeg]
        mov eax, 101h
        int 31h
        jb short .23
        xor eax, eax
.23:
        xor ebx, ebx
        mov eax, ebx
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
.24:
        mov esi, 1
        mov ebx, 1
        mov dword [GripLinked], esi
.25:
        mov eax, ebx
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; CallGripDriver                                  102F4  97 PC, low confidence
; Calls the gamepad driver
;-----------------------------------------------------------------------------
CallGripDriver:
        push ebx
        push edx
        cmp dword [GripLinked], byte 0
        jne short .1
        xor eax, eax
        pop edx
        pop ebx
        ret
.1:
        mov ax, 8491h
        call far [GripFarCall]
        mov bx, word [GripResult]
        mov eax, 1
        int 31h
        setb al
        test al, al
        je short .2
        xor eax, eax
        pop edx
        pop ebx
        ret
.2:
        mov dx, word [GripDataSeg]
        mov eax, 101h
        int 31h
        jb short .3
        xor eax, eax
.3:
        test al, al
        je short .4
        xor eax, eax
        pop edx
        pop ebx
        ret
.4:
        xor ebx, ebx
        mov eax, 1
        mov dword [GripLinked], ebx
        pop edx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; LoadGripLibrary                              10354  96 PC, medium confidence
; Finds GRIP.GLL on the GRIP and PATH environment variables or in C:\GRIP\, reads it (at most 32 KB) and
; links it with GripLinkLibrary; the result is kept in GripFlags
;-----------------------------------------------------------------------------
LoadGripLibrary:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, 88h
        mov ebx, esp
        xor ah, ah
        mov edx, str_GRIP
        mov byte [esp], ah
        mov eax, str_GRIPGLL
        call _searchenv_
        cmp byte [esp], 0
        jne short .1
        mov ebx, esp
        mov edx, str_PATH2
        mov eax, str_GRIPGLL
        call _searchenv_
.1:
        cmp byte [esp], 0
        jne short .2
        mov edx, str_CGRIP
        mov eax, esp
        call strcpy_
        mov edx, str_GRIPGLL
        mov eax, esp
        call strcat_
.2:
        mov edx, str_Rb
        mov eax, esp
        call fopen_
        mov esi, eax
        test eax, eax
        je near .6
        mov ebx, 2
        xor edx, edx
        call fseek_
        mov eax, esi
        call ftell_
        mov edi, eax
        mov dword [dword esp+084h], eax
        cmp eax, 8000h
        jle short .3
        mov eax, esi
        call fclose_
        jmp short .6
.3:
        call _nmalloc_
        mov ebp, eax
        mov dword [dword esp+080h], eax
        test eax, eax
        jne short .4
        mov eax, esi
        call fclose_
        add esp, 88h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.4:
        mov eax, esi
        xor ebx, ebx
        xor edx, edx
        call fseek_
        mov ecx, esi
        mov edx, 1
        mov ebx, edi
        mov eax, ebp
        call fread_
        mov eax, esi
        xor edx, edx
        call fclose_
        mov dx, word [dword esp+084h]
        mov eax, ebp
        call GripLinkLibrary
        test ax, ax
        je short .5
        or byte [GripFlags], 1
.5:
        mov eax, dword [dword esp+080h]
        call _nfree_
.6:
        add esp, 88h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; InitGripDriver                                  1046C  97 PC, low confidence
; Starts the gamepad driver
;-----------------------------------------------------------------------------
InitGripDriver:
        cmp word [GripReady], byte 0
        je short .2
        test byte [GripFlags], 2
        je short .1
        mov ax, 84A2h
        call far [GripFarCall]
        and byte [GripFlags], 0FDh
.1:
        test byte [GripFlags], 1
        je short .2
        call CallGripDriver
        and byte [GripFlags], 0FEh
.2:
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; LoadJoystickConfig                              104A8  97 PC, low confidence
; From main_: the "JSTICKS" settings ("DOS-Joystick")
;-----------------------------------------------------------------------------
LoadJoystickConfig:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 6Ch
        cmp word [GripReady], byte 0
        jne near .20
        test byte [GripFlags], 1
        je short .1
        mov ax, 84A1h
        call far [GripFarCall]
        test ax, ax
        je short .1
        or byte [GripFlags], 2
.1:
        test byte [GripFlags], 2
        je short .2
        mov word [GripPortWord], 4
        jmp short .3
.2:
        mov word [GripPortWord], 2
.3:
        mov si, word [GripPortWord]
        test si, si
        jbe near .19
        xor edx, edx
        mov dx, si
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        shl eax, 3
        add eax, edx
        push byte 20h
        shl eax, 2
        push eax
        push str_JSTICKS
        xor ebx, ebx
        call AllocMemBlock
        mov bx, word [GripPortWord]
        mov edx, eax
        mov dword [GripDriverPtr], eax
        lea eax, [nosplit ebx*8+00h]
        sub eax, ebx
        add esp, byte 0Ch
        shl eax, 3
        mov ebx, edx
        push eax
        add ebx, eax
        push edx
        mov dword [GripDriverData], ebx
        call ZeroMem
        xor edx, edx
        mov dx, word [GripPortWord]
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        shl eax, 2
        sub eax, edx
        add esp, byte 8
        shl eax, 2
        push eax
        mov edx, dword [GripDriverData]
        push edx
        call ZeroMem
        mov bl, byte [GripFlags]
        add esp, byte 8
        test bl, 2
        je near .14
        xor ebp, ebp
        mov dword [byte esp+050h], ebp
        xor ebx, ebx
.4:
        mov edx, ebx
        mov ax, 84A0h
        call far [GripFarCall]
        mov eax, dword [byte esp+050h]
        inc eax
        mov dword [byte esp+050h], eax
        cmp eax, byte 78h
        jl short .4
        mov ebx, 1
        xor edi, edi
        xor ecx, ecx
        mov word [GripSlot], di
        mov ax, 84B0h
        call far [GripFarCall]
        mov dword [byte esp+050h], ebx
        mov dword [byte esp+054h], eax
        mov eax, dword [byte esp+050h]
        xor ebp, ebp
        dec eax
        mov dword [byte esp+058h], ecx
        mov word [byte esp+064h], ax
.5:
        mov cl, byte [byte esp+050h]
        mov eax, dword [byte esp+054h]
        shr eax, cl
        test al, 1
        je near .13
        mov edi, esp
        mov bh, cl
        mov ax, 84D0h
        call far [GripFarCall]
        mov dword [edi], ebx
        mov dword [byte edi+04h], ecx
        mov dword [byte edi+08h], edx
        mov dword [byte edi+0Ch], esi
        lea edi, [byte esp+028h]
        mov bh, byte [byte esp+050h]
        mov ax, 84D1h
        call far [GripFarCall]
        mov dword [edi], ebx
        mov dword [byte edi+04h], ecx
        mov dword [byte edi+08h], edx
        mov dword [byte edi+0Ch], esi
        mov bh, byte [byte esp+050h]
        mov edx, 1
        mov ax, 84B1h
        call far [GripFarCall]
        test al, 2
        je short .6
        mov bl, 1
        mov bh, byte [byte esp+050h]
        mov ax, 84B3h
        call far [GripFarCall]
        inc al
        mov byte [byte esp+068h], al
        cmp al, 2
        jae short .7
.6:
        xor edx, edx
.7:
        test edx, edx
        je short .9
        mov bh, byte [byte esp+050h]
        mov ax, 84B1h
        call far [GripFarCall]
        test al, 4
        je short .9
        mov bl, 2
        mov bh, byte [byte esp+050h]
        mov ax, 84B3h
        call far [GripFarCall]
        cmp al, 1
        jae short .8
        xor edx, edx
.8:
        test edx, edx
        je short .10
        mov bl, 2
        xor ch, ch
        mov bh, byte [byte esp+050h]
        mov ax, 84B4h
        call far [GripFarCall]
        mov bl, 2
        mov ch, 1
        mov bh, byte [byte esp+050h]
        mov dword [byte esp+060h], eax
        mov ax, 84B4h
        call far [GripFarCall]
        mov dword [byte esp+05Ch], eax
        jmp short .10
.9:
        xor edx, edx
.10:
        test edx, edx
        je near .13
        mov cl, byte [byte esp+064h]
        mov eax, 1
        mov dx, word [GripSlot]
        shl eax, cl
        or edx, eax
        mov eax, dword [GripDriverPtr]
        mov word [GripSlot], dx
        or byte [eax+ebp], 1
        mov eax, dword [GripDriverPtr]
        and byte [eax+ebp], 0FDh
        mov eax, dword [GripDriverPtr]
        xor edx, edx
        mov ch, byte [eax+ebp]
        mov dl, byte [byte esp+068h]
        and ch, 0C3h
        and edx, byte 0Fh
        mov byte [eax+ebp], ch
        shl edx, 2
        or dword [eax+ebp], edx
        mov eax, dword [GripDriverPtr]
        xor ebx, ebx
        mov esi, dword [byte esp+058h]
        mov word [byte eax+ebp+036h], 0
        jmp short .12
.11:
        mov eax, dword [GripDriverData]
        mov cl, bl
        add eax, edx
        mov edx, 1
        shl edx, cl
        mov cx, word [byte eax+028h]
        or ecx, edx
        inc ebx
        mov word [byte eax+028h], cx
.12:
        imul edx, esi, byte 2Ch
        xor eax, eax
        mov al, byte [byte esp+068h]
        cmp ebx, eax
        jl short .11
        mov eax, dword [GripDriverData]
        mov word [byte edx+eax+02Ah], 0Fh
        mov eax, dword [GripDriverData]
        mov dword [edx+eax], 0
        xor esi, esi
        mov eax, dword [GripDriverData]
        mov si, word [byte esp+060h]
        mov dword [byte edx+eax+08h], esi
        mov eax, dword [GripDriverData]
        mov bl, 2
        xor edi, edi
        mov dword [byte edx+eax+04h], 0
        xor ch, ch
        mov eax, dword [GripDriverData]
        mov di, word [byte esp+05Ch]
        mov bh, byte [byte esp+050h]
        mov dword [byte edx+eax+0Ch], edi
        mov ax, 84C0h
        call far [GripFarCall]
        mov ebx, dword [GripDriverData]
        and eax, 0FFFFh
        mov dword [byte edx+ebx+010h], eax
        mov bl, 2
        mov ch, 1
        mov bh, byte [byte esp+050h]
        mov ax, 84C0h
        call far [GripFarCall]
        xor ebx, ebx
        mov bx, ax
        mov eax, dword [GripDriverData]
        mov dword [byte edx+eax+014h], ebx
        mov ebx, esi
        mov eax, dword [GripDriverData]
        sar ebx, 1
        mov dword [byte edx+eax+018h], ebx
        mov ebx, edi
        mov eax, dword [GripDriverData]
        sar ebx, 1
        mov dword [byte edx+eax+01Ch], ebx
        mov eax, dword [GripDriverData]
        sar esi, 2
        mov dword [byte edx+eax+020h], esi
        mov eax, dword [GripDriverData]
        sar edi, 2
        mov dword [byte edx+eax+024h], edi
.13:
        mov esi, dword [byte esp+064h]
        mov eax, dword [byte esp+050h]
        mov edi, dword [byte esp+058h]
        add ebp, byte 38h
        inc esi
        inc eax
        inc edi
        mov word [byte esp+064h], si
        mov dword [byte esp+050h], eax
        mov dword [byte esp+058h], edi
        cmp eax, byte 5
        jge near .19
        jmp near .5
.14:
        call CalibrateJoystick
        mov eax, dword [JoyPortMask]
        and eax, byte 0Fh
        cmp eax, byte 0Fh
        sete al
        and eax, 0FFh
        inc eax
        push eax
        call ResetJoystickRange
        mov bh, byte [JoyPortMask]
        add esp, byte 4
        test bh, 3
        je near .16
        cmp dword [JoyAxisValues], byte 0
        jne short .15
        cmp dword [JoyAxisY], byte 0
        je near .16
.15:
        mov eax, dword [GripDriverPtr]
        or byte [eax], 1
        mov eax, dword [GripDriverPtr]
        and byte [eax], 0C3h
        mov eax, dword [GripDriverPtr]
        or byte [eax], 8
        mov eax, dword [GripDriverPtr]
        mov edx, str_DOSJoystick
        add eax, byte 4
        call strcpy_
        mov eax, dword [GripDriverPtr]
        mov word [byte eax+036h], 0
        mov eax, dword [GripDriverData]
        mov word [byte eax+028h], 3
        mov eax, dword [GripDriverData]
        mov word [byte eax+02Ah], 0
        mov eax, dword [GripDriverData]
        mov edx, dword [JoyAxisValues]
        mov dword [eax], edx
        mov edx, dword [GripDriverData]
        mov eax, dword [JoyAxisValues]
        mov dword [byte edx+08h], eax
        mov edx, dword [GripDriverData]
        mov eax, dword [JoyAxisY]
        mov dword [byte edx+04h], eax
        mov edx, dword [GripDriverData]
        mov dword [byte edx+0Ch], eax
        mov edx, dword [GripDriverData]
        mov eax, dword [JoyAxisValues]
        mov dword [byte edx+010h], eax
        mov edx, dword [GripDriverData]
        mov eax, dword [JoyAxisY]
        mov dword [byte edx+014h], eax
        mov edx, dword [GripDriverData]
        mov eax, dword [JoyAxisValues]
        mov dword [byte edx+018h], eax
        mov edx, dword [GripDriverData]
        mov eax, dword [JoyAxisY]
        mov dword [byte edx+01Ch], eax
        mov eax, dword [GripDriverData]
        mov dword [byte eax+020h], 0F8h
        mov eax, dword [GripDriverData]
        mov dword [byte eax+024h], 0F8h
.16:
        mov eax, dword [GripDriverPtr]
        or byte [eax], 2
        test byte [JoyPortMask], 0Ch
        je near .18
        cmp dword [JoyAxisSecondX], byte 0
        jne short .17
        cmp dword [JoyAxisSecondY], byte 0
        je near .18
.17:
        mov eax, dword [GripDriverPtr]
        or byte [byte eax+038h], 1
        mov eax, dword [GripDriverPtr]
        mov cl, byte [byte eax+038h]
        and cl, 0C3h
        mov byte [byte eax+038h], cl
        mov ch, cl
        or ch, 8
        mov byte [byte eax+038h], ch
        mov eax, dword [GripDriverPtr]
        mov edx, str_DOSJoystick
        add eax, byte 3Ch
        call strcpy_
        mov eax, dword [GripDriverPtr]
        mov word [byte eax+06Eh], 0
        mov eax, dword [GripDriverData]
        mov word [byte eax+054h], 3
        mov eax, dword [GripDriverData]
        mov word [byte eax+056h], 0
        mov edx, dword [GripDriverData]
        mov eax, dword [JoyAxisSecondX]
        mov dword [byte edx+02Ch], eax
        mov edx, dword [GripDriverData]
        mov dword [byte edx+034h], eax
        mov edx, dword [GripDriverData]
        mov eax, dword [JoyAxisSecondY]
        mov dword [byte edx+030h], eax
        mov edx, dword [GripDriverData]
        mov dword [byte edx+038h], eax
        mov edx, dword [GripDriverData]
        mov eax, dword [JoyAxisSecondX]
        mov dword [byte edx+03Ch], eax
        mov edx, dword [GripDriverData]
        mov eax, dword [JoyAxisSecondY]
        mov dword [byte edx+040h], eax
        mov edx, dword [GripDriverData]
        mov eax, dword [JoyAxisSecondX]
        mov dword [byte edx+044h], eax
        mov eax, dword [GripDriverData]
        mov edx, dword [JoyAxisSecondY]
        mov dword [byte eax+048h], edx
        mov eax, dword [GripDriverData]
        mov dword [byte eax+04Ch], 0F8h
        mov eax, dword [GripDriverData]
        mov dword [byte eax+050h], 0F8h
.18:
        mov eax, dword [GripDriverPtr]
        or byte [byte eax+038h], 2
.19:
        mov word [GripReady], 1
.20:
        add esp, byte 6Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
