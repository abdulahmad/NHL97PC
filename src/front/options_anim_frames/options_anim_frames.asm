; Options screen animation: set-up, frames and updates.
bits 32
%include "hockey.inc"
section s_10A67 progbits alloc exec nowrite align=1
extern __STOSB, CalibrateJoystick, ChantIndex, ChantPlayed, ChantState, CrowdChantTable, gameopts, GripDriverData
extern GripDriverPtr, GripFarCall, GripFlags, GripPortWord, GripReady, JoyAxisSecondX, JoyAxisSecondY, JoyAxisValues
extern JoyAxisY, JoyPortMask, ResetJoystickRange, str_DOSJoystick, strcpy_
global SetupOptionsAnim, DrawOptionsAnimFrame, UpdateOptionsAnim
        db 090h
;-----------------------------------------------------------------------------
; SetupOptionsAnim                                10A68  97 PC, low confidence
; Sets up the options animation
;-----------------------------------------------------------------------------
SetupOptionsAnim:
        push ebx
        push ecx
        push edx
        mov ebx, eax
        cmp ax, word [GripPortWord]
        jae near .6
        xor edx, edx
        mov dx, ax
        lea eax, [nosplit edx*8+00h]
        sub eax, edx
        mov edx, dword [GripDriverPtr]
        test byte [edx+eax*8], 2
        je near .6
        call CalibrateJoystick
        mov eax, dword [JoyPortMask]
        and eax, byte 0Fh
        cmp eax, byte 0Fh
        sete al
        and eax, 0FFh
        inc eax
        push eax
        call ResetJoystickRange
        add esp, byte 4
        test bx, bx
        jne near .3
        test byte [JoyPortMask], 3
        je near .2
        cmp dword [JoyAxisValues], byte 0
        jne short .1
        cmp dword [JoyAxisY], byte 0
        je near .2
.1:
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
        mov edx, dword [GripDriverData]
        mov eax, dword [JoyAxisValues]
        mov dword [edx], eax
        mov edx, dword [GripDriverData]
        mov dword [byte edx+08h], eax
        mov edx, dword [GripDriverData]
        mov eax, dword [JoyAxisY]
        mov dword [byte edx+04h], eax
        mov eax, dword [GripDriverData]
        mov edx, dword [JoyAxisY]
        mov dword [byte eax+0Ch], edx
        mov eax, dword [GripDriverData]
        mov edx, dword [JoyAxisValues]
        mov dword [byte eax+010h], edx
        mov eax, dword [GripDriverData]
        mov edx, dword [JoyAxisY]
        mov dword [byte eax+014h], edx
        mov eax, dword [GripDriverData]
        mov edx, dword [JoyAxisValues]
        mov dword [byte eax+018h], edx
        mov edx, dword [GripDriverData]
        mov eax, dword [JoyAxisY]
        mov dword [byte edx+01Ch], eax
        mov eax, dword [GripDriverData]
        mov dword [byte eax+020h], 0F8h
        mov eax, dword [GripDriverData]
        mov dword [byte eax+024h], 0F8h
        pop edx
        pop ecx
        pop ebx
        ret
.2:
        mov eax, dword [GripDriverPtr]
        and byte [eax], 0FEh
        pop edx
        pop ecx
        pop ebx
        ret
.3:
        test byte [JoyPortMask], 0Ch
        je near .5
        cmp dword [JoyAxisSecondX], byte 0
        jne short .4
        cmp dword [JoyAxisSecondY], byte 0
        je near .5
.4:
        mov eax, dword [GripDriverPtr]
        or byte [byte eax+038h], 1
        mov eax, dword [GripDriverPtr]
        mov bl, byte [byte eax+038h]
        and bl, 0C3h
        mov byte [byte eax+038h], bl
        mov bh, bl
        or bh, 8
        mov byte [byte eax+038h], bh
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
        mov edx, dword [GripDriverData]
        mov eax, dword [JoyAxisSecondY]
        mov dword [byte edx+048h], eax
        mov eax, dword [GripDriverData]
        mov dword [byte eax+04Ch], 0F8h
        mov eax, dword [GripDriverData]
        mov dword [byte eax+050h], 0F8h
        pop edx
        pop ecx
        pop ebx
        ret
.5:
        mov eax, dword [GripDriverPtr]
        and byte [byte eax+038h], 0FEh
.6:
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; DrawOptionsAnimFrame                            10CC8  97 PC, low confidence
; Draws one frame of the options animation
;-----------------------------------------------------------------------------
DrawOptionsAnimFrame:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        mov ebx, eax
        mov ecx, edx
        lea esi, [nosplit eax*4+00h]
        sub esi, eax
        shl esi, 2
        sub esi, eax
        mov eax, dword [GripDriverData]
        shl esi, 2
        and cx, word [byte esi+eax+028h]
        mov edx, ebx
        lea eax, [nosplit edx*8+00h]
        sub eax, edx
        lea edx, [nosplit eax*8+00h]
        mov eax, dword [GripDriverPtr]
        shl ecx, 4
        mov word [byte edx+eax+036h], cx
        mov eax, dword [GripDriverData]
        add eax, esi
        mov si, word [byte eax+02Ah]
        and esi, byte 3
        xor ecx, ecx
        cmp si, byte 3
        jne short .1
        mov ecx, 1
        jmp near .8
.1:
        cmp si, byte 1
        jne short .3
        mov edi, dword [byte eax+020h]
        mov esi, dword [byte eax+018h]
        mov ebp, dword [byte eax+010h]
        add esi, edi
        cmp esi, ebp
        jge short .2
        mov dh, byte [byte eax+02Ah]
        or dh, 2
        mov ecx, 1
        mov byte [byte eax+02Ah], dh
        jmp near .8
.2:
        mov esi, dword [byte eax+018h]
        sub esi, edi
        cmp esi, ebp
        jle near .8
        mov eax, dword [GripDriverPtr]
        or byte [byte edx+eax+036h], 8
        jmp near .8
.3:
        cmp si, byte 2
        jne short .5
        mov edi, dword [byte eax+020h]
        mov esi, dword [byte eax+018h]
        mov ebp, dword [byte eax+010h]
        sub esi, edi
        cmp esi, ebp
        jle short .4
        mov dl, byte [byte eax+02Ah]
        or dl, 1
        mov ecx, 1
        mov byte [byte eax+02Ah], dl
        jmp short .8
.4:
        mov esi, dword [byte eax+018h]
        add esi, edi
        cmp esi, ebp
        jge short .8
        jmp short .7
.5:
        mov edi, dword [byte eax+020h]
        mov esi, dword [byte eax+018h]
        mov ebp, dword [byte eax+010h]
        sub esi, edi
        cmp esi, ebp
        jle short .6
        or byte [byte eax+02Ah], 1
        mov eax, dword [GripDriverPtr]
        or byte [byte edx+eax+036h], 8
        jmp short .8
.6:
        mov esi, dword [byte eax+018h]
        add esi, edi
        cmp esi, ebp
        jge short .8
        or byte [byte eax+02Ah], 2
.7:
        mov eax, dword [GripDriverPtr]
        or byte [byte edx+eax+036h], 4
.8:
        test ecx, ecx
        je short .10
        lea eax, [nosplit ebx*4+00h]
        sub eax, ebx
        shl eax, 2
        sub eax, ebx
        mov edx, dword [GripDriverData]
        shl eax, 2
        add eax, edx
        mov edx, dword [byte eax+08h]
        mov ecx, dword [eax]
        sub edx, ecx
        mov ecx, edx
        mov edx, dword [byte eax+020h]
        add edx, edx
        cmp ecx, edx
        jle short .10
        mov esi, dword [eax]
        mov edx, dword [byte eax+08h]
        add edx, esi
        mov ebp, dword [byte eax+010h]
        mov esi, edx
        mov edi, edx
        lea edx, [nosplit ebx*8+00h]
        sar esi, 1
        sub edx, ebx
        sar edi, 2
        shl edx, 3
        cmp edi, ebp
        jl short .9
        mov eax, dword [GripDriverPtr]
        or byte [byte edx+eax+036h], 8
        jmp short .10
.9:
        mov ecx, esi
        sar ecx, 1
        add ecx, esi
        cmp ecx, ebp
        jge short .10
        mov eax, dword [GripDriverPtr]
        or byte [byte edx+eax+036h], 4
.10:
        lea eax, [nosplit ebx*4+00h]
        sub eax, ebx
        shl eax, 2
        sub eax, ebx
        lea edx, [nosplit eax*4+00h]
        mov eax, dword [GripDriverData]
        add eax, edx
        mov si, word [byte eax+02Ah]
        and esi, byte 0Ch
        xor ecx, ecx
        cmp si, byte 0Ch
        jne short .11
        mov ecx, 1
        jmp near .18
.11:
        lea edx, [nosplit ebx*8+00h]
        sub edx, ebx
        shl edx, 3
        cmp si, byte 4
        jne short .13
        mov edi, dword [byte eax+024h]
        mov esi, dword [byte eax+01Ch]
        mov ebp, dword [byte eax+014h]
        add esi, edi
        cmp esi, ebp
        jge short .12
        mov dh, byte [byte eax+02Ah]
        or dh, 8
        mov ecx, 1
        mov byte [byte eax+02Ah], dh
        jmp near .18
.12:
        mov esi, dword [byte eax+01Ch]
        sub esi, edi
        cmp esi, ebp
        jle near .18
        mov eax, dword [GripDriverPtr]
        or byte [byte edx+eax+036h], 1
        jmp near .18
.13:
        cmp si, byte 8
        jne short .15
        mov edi, dword [byte eax+024h]
        mov esi, dword [byte eax+01Ch]
        mov ebp, dword [byte eax+014h]
        sub esi, edi
        cmp esi, ebp
        jle short .14
        mov dl, byte [byte eax+02Ah]
        or dl, 4
        mov ecx, 1
        mov byte [byte eax+02Ah], dl
        jmp short .18
.14:
        mov esi, dword [byte eax+01Ch]
        add esi, edi
        cmp esi, ebp
        jge short .18
        jmp short .17
.15:
        mov edi, dword [byte eax+024h]
        mov esi, dword [byte eax+01Ch]
        mov ebp, dword [byte eax+014h]
        sub esi, edi
        cmp esi, ebp
        jle short .16
        or byte [byte eax+02Ah], 4
        mov eax, dword [GripDriverPtr]
        or byte [byte edx+eax+036h], 1
        jmp short .18
.16:
        mov esi, dword [byte eax+01Ch]
        add esi, edi
        cmp esi, ebp
        jge short .18
        or byte [byte eax+02Ah], 8
.17:
        mov eax, dword [GripDriverPtr]
        or byte [byte edx+eax+036h], 2
.18:
        test ecx, ecx
        je short .20
        lea eax, [nosplit ebx*4+00h]
        sub eax, ebx
        shl eax, 2
        sub eax, ebx
        mov edx, dword [GripDriverData]
        shl eax, 2
        add edx, eax
        mov eax, dword [byte edx+0Ch]
        sub eax, dword [byte edx+04h]
        mov ecx, dword [byte edx+024h]
        add ecx, ecx
        cmp eax, ecx
        jle short .20
        mov esi, dword [byte edx+04h]
        mov eax, dword [byte edx+0Ch]
        add eax, esi
        mov edi, dword [byte edx+014h]
        mov ecx, eax
        mov esi, eax
        lea eax, [nosplit ebx*8+00h]
        sar ecx, 1
        sub eax, ebx
        sar esi, 2
        shl eax, 3
        cmp esi, edi
        jl short .19
        mov edx, dword [GripDriverPtr]
        or byte [byte edx+eax+036h], 1
        jmp short .20
.19:
        mov ebx, ecx
        sar ebx, 1
        add ecx, ebx
        cmp ecx, edi
        jge short .20
        mov edx, dword [GripDriverPtr]
        or byte [byte edx+eax+036h], 2
.20:
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; UpdateOptionsAnim                               10FAC  97 PC, low confidence
; Updates the options animation
;-----------------------------------------------------------------------------
UpdateOptionsAnim:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 10h
        cmp word [GripReady], byte 0
        je near .16
        test byte [GripFlags], 2
        jne short .1
        call CalibrateJoystick
.1:
        xor edx, edx
        xor ebp, ebp
        xor esi, esi
        mov dword [byte esp+0Ch], edx
        mov edx, eax
        sar eax, 2
        or edx, byte 0FFFFFFFCh
        or eax, byte 0FFFFFFFCh
        mov dword [byte esp+08h], edx
        mov dword [byte esp+04h], eax
        jmp near .15
.2:
        mov eax, dword [GripDriverPtr]
        test byte [eax+ebp], 1
        je near .14
        test byte [GripFlags], 2
        je near .3
        mov edx, 1
        mov ax, 84A0h
        call far [GripFarCall]
        mov eax, dword [GripDriverPtr]
        mov eax, dword [eax+ebp]
        mov bl, 1
        shl eax, 1Ah
        mov dl, byte [byte esp+0Ch]
        shr eax, 1Ch
        inc dl
        mov cl, al
        mov bh, dl
        xor ch, ch
        mov ax, 84C1h
        call far [GripFarCall]
        mov bl, 2
        xor ch, ch
        mov bh, dl
        mov edi, eax
        mov ax, 84C0h
        call far [GripFarCall]
        xor ebx, ebx
        mov bx, ax
        mov eax, dword [GripDriverData]
        mov dword [byte esi+eax+010h], ebx
        mov ch, 1
        mov eax, dword [GripDriverData]
        mov bl, 2
        add eax, esi
        mov bh, dl
        mov dword [esp], eax
        xor edx, edx
        mov ax, 84C0h
        call far [GripFarCall]
        mov dx, ax
        mov eax, dword [esp]
        mov eax, dword [byte eax+0Ch]
        sub eax, edx
        mov edx, eax
        mov eax, dword [GripDriverData]
        and edi, 0FFFh
        mov dword [byte esi+eax+014h], edx
        jmp near .13
.3:
        cmp dword [byte esp+0Ch], byte 0
        jne near .8
        mov eax, dword [GripDriverData]
        mov ebx, dword [JoyAxisValues]
        cmp ebx, dword [eax]
        jge short .4
        mov dword [eax], ebx
.4:
        mov eax, dword [GripDriverData]
        mov ecx, dword [JoyAxisValues]
        cmp ecx, dword [byte eax+08h]
        jle short .5
        mov dword [byte eax+08h], ecx
.5:
        mov eax, dword [GripDriverData]
        mov edi, dword [JoyAxisY]
        cmp edi, dword [byte eax+04h]
        jge short .6
        mov dword [byte eax+04h], edi
.6:
        mov edi, dword [GripDriverData]
        mov edx, dword [JoyAxisY]
        cmp edx, dword [byte edi+0Ch]
        jle short .7
        mov dword [byte edi+0Ch], edx
.7:
        mov edx, dword [GripDriverData]
        mov eax, dword [JoyAxisValues]
        mov dword [byte edx+010h], eax
        mov edi, dword [byte esp+08h]
        mov edx, dword [GripDriverData]
        mov eax, dword [JoyAxisY]
        not edi
        mov dword [byte edx+014h], eax
        jmp near .13
.8:
        mov eax, dword [GripDriverData]
        mov edx, dword [JoyAxisSecondX]
        cmp edx, dword [byte eax+02Ch]
        jge short .9
        mov dword [byte eax+02Ch], edx
.9:
        mov edi, dword [GripDriverData]
        mov ebx, dword [JoyAxisSecondX]
        cmp ebx, dword [byte edi+034h]
        jle short .10
        mov dword [byte edi+034h], ebx
.10:
        mov eax, dword [GripDriverData]
        mov ecx, dword [JoyAxisSecondY]
        cmp ecx, dword [byte eax+030h]
        jge short .11
        mov dword [byte eax+030h], ecx
.11:
        mov eax, dword [GripDriverData]
        mov edx, dword [JoyAxisSecondY]
        cmp edx, dword [byte eax+038h]
        jle short .12
        mov dword [byte eax+038h], edx
.12:
        mov edx, dword [GripDriverData]
        mov eax, dword [JoyAxisSecondX]
        mov dword [byte edx+03Ch], eax
        mov edi, dword [byte esp+04h]
        mov edx, dword [GripDriverData]
        mov eax, dword [JoyAxisSecondY]
        not edi
        mov dword [byte edx+040h], eax
.13:
        mov eax, dword [byte esp+0Ch]
        mov edx, edi
        call DrawOptionsAnimFrame
.14:
        mov ebx, dword [byte esp+0Ch]
        add esi, byte 2Ch
        inc ebx
        add ebp, byte 38h
        mov dword [byte esp+0Ch], ebx
.15:
        xor eax, eax
        mov ebx, dword [byte esp+0Ch]
        mov ax, word [GripPortWord]
        cmp eax, ebx
        jg near .2
.16:
        add esp, byte 10h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
        push ecx
        push edx
        mov ecx, 3Fh
        mov eax, ChantPlayed
        xor edx, edx
        call __STOSB
        xor ah, ah
        mov byte [ChantState], ah
        mov eax, dword [gameopts]
        mov eax, dword [byte eax+01h]
        shl eax, 0Ch
        shr eax, 1Ah
        mov ax, word [nosplit eax*2+CrowdChantTable]
        mov word [ChantIndex], ax
        pop edx
        pop ecx
        ret
