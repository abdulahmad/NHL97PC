; Watcom C runtime: copypart_, _splitpath_, pickup_, _makepath_, strnicmp_ and 5 more.
bits 32
%include "hockey.inc"
section s_115BF9 progbits alloc exec nowrite align=1
extern __CHP, __CMain, __FiniRtns, __InitRtns, __MBCSFlag, __MBCSTable, __mbvtop_, __no87
extern __saved_DS, _curbrk, _dynend, _Envptr, _Envptr_w4, _Extender, _ExtenderSubtype, _LpCmdLine
extern _mbptov_, _mbsdec_, _mbsnbcnt_, _mbsnccnt_, _mbsncpy_, _osmajor, _osminor, _psp
extern _STACKLOW, _STACKTOP, BitReaderBits, BitReaderPtr, CodeStartPad, F64_0p5_ReadBits, FpuFlags, GripCallOffset
extern StackLow, StartupStack, str_Punct_InitFpuFlags
global copypart_, _splitpath_, pickup_, _makepath_, strnicmp_, SetBitReader, ReadBits, start
global start_74, start_28F, WriteConsoleMessage, WriteConsoleMessage_23, RestoreDS
;-----------------------------------------------------------------------------
; copypart_                                                    115BF9  library
; Run-time library: copies one part of a path (for _splitpath)
;-----------------------------------------------------------------------------
copypart_:
        push esi
        push edi
        mov esi, eax
        mov edi, edx
        mov edx, ebx
        test eax, eax
        je short .2
        cmp ebx, ecx
        jle short .1
        mov edx, ecx
.1:
        mov eax, edi
        call _mbsnccnt_
        mov ecx, eax
        mov ebx, eax
        mov edx, edi
        mov eax, esi
        call _mbsncpy_
        mov edx, ecx
        mov eax, esi
        call _mbsnbcnt_
        mov byte [esi+eax], 0
.2:
        pop edi
        pop esi
        ret
;-----------------------------------------------------------------------------
; _splitpath_                                                  115C2F  library
; Run-time library _splitpath: splits a path into drive, directory, name and extension
;-----------------------------------------------------------------------------
_splitpath_:
        push esi
        push edi
        push ebp
        sub esp, byte 0Ch
        mov esi, eax
        mov dword [esp], ebx
        mov dword [byte esp+04h], ecx
        cmp byte [eax], 0
        je short .2
        xor eax, eax
        mov al, byte [byte esi+01h]
        cmp eax, byte 3Ah
        jne short .2
        test edx, edx
        je short .1
        mov al, byte [esi]
        mov byte [byte edx+01h], 3Ah
        mov byte [byte edx+02h], 0
        mov byte [edx], al
.1:
        add esi, byte 2
        jmp short .3
.2:
        test edx, edx
        je short .3
        mov byte [edx], 0
.3:
        mov ebp, esi
        mov dword [byte esp+08h], esi
.4:
        xor edi, edi
.5:
        cmp byte [esi], 0
        je short .10
        mov eax, esi
        call _mbptov_
        mov edx, eax
        cmp eax, byte 2Eh
        jne short .6
        mov edi, esi
        inc esi
        jmp short .5
.6:
        cmp dword [__MBCSFlag], byte 0
        je short .7
        xor eax, eax
        mov al, byte [esi]
        mov al, byte [dword eax+__MBCSTable]
        and al, 1
        and eax, 0FFh
        jmp short .8
.7:
        xor eax, eax
.8:
        inc esi
        add esi, eax
        cmp edx, byte 5Ch
        je short .9
        cmp edx, byte 2Fh
        jne short .5
.9:
        mov ebp, esi
        jmp short .4
.10:
        mov ecx, dword [byte esp+08h]
        mov edx, dword [byte esp+08h]
        mov ebx, ebp
        mov eax, dword [esp]
        sub ebx, ecx
        mov ecx, 81h
        call copypart_
        test edi, edi
        jne short .11
        mov edi, esi
.11:
        mov ecx, 8
        mov eax, dword [byte esp+04h]
        mov ebx, edi
        mov edx, ebp
        sub ebx, ebp
        call copypart_
        mov ecx, 4
        mov eax, dword [byte esp+01Ch]
        mov ebx, esi
        mov edx, edi
        sub ebx, edi
        call copypart_
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        ret 4
;-----------------------------------------------------------------------------
; pickup_                                                      115D08  library
; Run-time library: notes the path separator in use (for _makepath)
;-----------------------------------------------------------------------------
pickup_:
        cmp eax, byte 5Ch
        je short .1
        cmp eax, byte 2Fh
        jne short .3
.1:
        cmp dword [edx], byte 0
        jne short .2
        mov dword [edx], eax
.2:
        mov eax, dword [edx]
.3:
        ret
;-----------------------------------------------------------------------------
; _makepath_                                                   115D1C  library
; Run-time library _makepath: builds a path from its parts
;-----------------------------------------------------------------------------
_makepath_:
        push esi
        push edi
        push ebp
        sub esp, byte 8
        mov ebp, eax
        xor esi, esi
        mov dword [esp], eax
        mov dword [byte esp+04h], esi
        test edx, edx
        je short .1
        mov ah, byte [edx]
        test ah, ah
        je short .1
        mov byte [byte ebp+00h], ah
        inc ebp
        mov byte [byte ebp+00h], 3Ah
        inc ebp
.1:
        mov byte [byte ebp+00h], 0
        test ebx, ebx
        je near .10
        cmp byte [ebx], 0
        je near .10
.2:
        mov eax, ebx
        lea edx, [byte esp+04h]
        call _mbptov_
        call pickup_
        call __mbvtop_
        mov edi, ebp
        mov esi, eax
        push edi
.3:
        mov al, byte [esi]
        mov byte [edi], al
        cmp al, 0
        je short .4
        mov al, byte [byte esi+01h]
        add esi, byte 2
        mov byte [byte edi+01h], al
        add edi, byte 2
        cmp al, 0
        jne short .3
.4:
        pop edi
        cmp dword [__MBCSFlag], byte 0
        je short .5
        xor eax, eax
        mov al, byte [byte ebp+00h]
        mov al, byte [dword eax+__MBCSTable]
        and al, 1
        and eax, 0FFh
        jmp short .6
.5:
        xor eax, eax
.6:
        inc ebp
        add ebp, eax
        mov eax, dword [__MBCSFlag]
        test eax, eax
        je short .7
        xor eax, eax
        mov al, byte [ebx]
        mov al, byte [dword eax+__MBCSTable]
        and al, 1
        and eax, 0FFh
.7:
        inc ebx
        add ebx, eax
        cmp byte [ebx], 0
        jne short .2
        cmp dword [byte esp+04h], byte 0
        jne short .8
        mov dword [byte esp+04h], 5Ch
.8:
        mov eax, dword [esp]
        mov edx, ebp
        call _mbsdec_
        mov al, byte [eax]
        mov esi, dword [byte esp+04h]
        and eax, 0FFh
        cmp eax, esi
        jne short .9
        dec ebp
        jmp short .10
.9:
        mov al, byte [byte esp+04h]
        mov byte [byte ebp+00h], al
.10:
        cmp dword [byte esp+04h], byte 0
        jne short .11
        mov dword [byte esp+04h], 5Ch
.11:
        lea ebx, [byte ebp+01h]
        test ecx, ecx
        je near .18
        mov eax, ecx
        lea edx, [byte esp+04h]
        call _mbptov_
        call pickup_
        mov esi, dword [byte esp+04h]
        cmp eax, esi
        je short .12
        xor eax, eax
        mov al, byte [byte ebp+00h]
        cmp eax, esi
        jne short .12
        mov ebp, ebx
.12:
        mov eax, ecx
        lea edx, [byte esp+04h]
        call _mbptov_
        call pickup_
        call __mbvtop_
        mov edi, ebp
        mov esi, eax
        push edi
.13:
        mov al, byte [esi]
        mov byte [edi], al
        cmp al, 0
        je short .14
        mov al, byte [byte esi+01h]
        add esi, byte 2
        mov byte [byte edi+01h], al
        add edi, byte 2
        cmp al, 0
        jne short .13
.14:
        pop edi
        mov eax, dword [__MBCSFlag]
        test eax, eax
        je short .15
        xor eax, eax
        mov al, byte [byte ebp+00h]
        mov al, byte [dword eax+__MBCSTable]
        and al, 1
        and eax, 0FFh
.15:
        inc ebp
        mov edx, dword [__MBCSFlag]
        add ebp, eax
        test edx, edx
        je short .16
        xor eax, eax
        mov al, byte [ecx]
        mov al, byte [dword eax+__MBCSTable]
        and al, 1
        and eax, 0FFh
        jmp short .17
.16:
        xor eax, eax
.17:
        inc ecx
        add ecx, eax
        cmp byte [ecx], 0
        jne short .12
        jmp short .19
.18:
        xor eax, eax
        mov edx, dword [byte esp+04h]
        mov al, byte [byte ebp+00h]
        cmp eax, edx
        jne short .19
        mov ebp, ebx
.19:
        mov ebx, dword [byte esp+018h]
        test ebx, ebx
        je short .21
        cmp byte [ebx], 0
        je short .21
        mov edx, dword [byte esp+018h]
        xor eax, eax
        mov al, byte [edx]
        cmp eax, byte 2Eh
        je short .20
        mov byte [byte ebp+00h], 2Eh
        inc ebp
.20:
        mov eax, dword [byte esp+018h]
        mov cl, byte [eax]
        test cl, cl
        je short .21
        mov byte [byte ebp+00h], cl
        lea ecx, [byte eax+01h]
        inc ebp
        mov dword [byte esp+018h], ecx
        jmp short .20
.21:
        mov byte [byte ebp+00h], 0
        add esp, byte 8
        pop ebp
        pop edi
        pop esi
        ret 4
;-----------------------------------------------------------------------------
; strnicmp_                                                    115F07  library
; Run-time library strnicmp: compares at most n characters, ignoring case
;-----------------------------------------------------------------------------
strnicmp_:
        push ecx
        push esi
        mov ecx, eax
        mov esi, ebx
.1:
        test esi, esi
        jne short .3
.2:
        xor eax, eax
        pop esi
        pop ecx
        ret
.3:
        mov al, byte [ecx]
        xor ebx, ebx
        mov ah, byte [edx]
        mov bl, al
        cmp ebx, byte 41h
        jl short .4
        cmp ebx, byte 5Ah
        jg short .4
        add al, 20h
.4:
        xor ebx, ebx
        mov bl, ah
        cmp ebx, byte 41h
        jl short .5
        cmp ebx, byte 5Ah
        jg short .5
        add ah, 20h
.5:
        cmp al, ah
        je short .6
        xor edx, edx
        mov dl, al
        mov al, ah
        and eax, 0FFh
        sub edx, eax
        mov eax, edx
        pop esi
        pop ecx
        ret
.6:
        test ah, ah
        je short .2
        inc ecx
        inc edx
        dec esi
        jmp short .1
        db 00h,00h,00h,00h,00h,00h
        push edx
        xor edx, edx
        mov dword [BitReaderBits], eax
        mov dword [BitReaderPtr], edx
        pop edx
        ret
        push edx
        mov edx, dword [BitReaderBits]
        mov dword [eax], edx
        mov edx, dword [BitReaderPtr]
        mov dword [byte eax+04h], edx
        pop edx
        ret
        push edx
        mov edx, dword [eax]
        mov dword [BitReaderBits], edx
        mov eax, dword [byte eax+04h]
        mov dword [BitReaderPtr], eax
        pop edx
        ret
        db 090h
;-----------------------------------------------------------------------------
; SetBitReader                                   115F98  97 PC, low confidence
; Bit reader: sets the buffer and bit position to read from
;-----------------------------------------------------------------------------
SetBitReader:
        mov dword [BitReaderPtr], edx
        mov dword [BitReaderBits], eax
        ret
        push ebx
        push ecx
        push edx
        mov eax, dword [BitReaderPtr]
        mov edx, dword [BitReaderBits]
        sar eax, 3
        add edx, eax
        mov ah, byte [BitReaderPtr]
        mov dword [BitReaderBits], edx
        test ah, 7
        je short .1
        lea ebx, [byte edx+01h]
        mov dword [BitReaderBits], ebx
.1:
        xor ecx, ecx
        mov dword [BitReaderPtr], ecx
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
        push ebx
        push ecx
        push esi
        push edi
        mov edi, eax
        mov eax, 1
        mov cl, dl
        mov ebx, eax
        shl ebx, cl
        sub ebx, eax
        test edi, edi
        jge short .2
        xor edi, edi
.2:
        cmp edi, ebx
        jle short .3
        mov edi, ebx
.3:
        dec edx
        cmp edx, byte 0FFFFFFFFh
        je short .6
        mov ecx, dword [BitReaderPtr]
        mov esi, 1
        and ecx, byte 7
        mov ebx, dword [BitReaderPtr]
        shl esi, cl
        sar ebx, 3
        mov ecx, esi
        test eax, edi
        je short .4
        mov esi, dword [BitReaderBits]
        or dword [esi+ebx], ecx
        jmp short .5
.4:
        mov esi, dword [BitReaderBits]
        not ecx
        and dword [esi+ebx], ecx
.5:
        mov ebx, dword [BitReaderPtr]
        inc ebx
        add eax, eax
        mov dword [BitReaderPtr], ebx
        jmp short .3
.6:
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ReadBits                                       116050  97 PC, low confidence
; Bit reader: reads the given number of bits
;-----------------------------------------------------------------------------
ReadBits:
        push ebx
        push ecx
        push edx
        mov edx, dword [BitReaderPtr]
        mov ecx, dword [BitReaderBits]
        sar edx, 3
        add edx, ecx
        mov ecx, dword [BitReaderPtr]
        mov edx, dword [edx]
        and ecx, byte 7
        mov ebx, 1
        shr edx, cl
        mov cl, al
        shl ebx, cl
        lea ecx, [byte ebx-01h]
        and ecx, edx
        add dword [BitReaderPtr], eax
        mov eax, ecx
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
        push ecx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, byte 0Ch
        and esp, byte 0FFFFFFF8h
        mov esi, dword [byte ebp+018h]
        mov ecx, edx
        mov edx, ebx
        mov ebx, 461C3C00h
        mov edi, 0C61C3C00h
        mov dword [byte esp+08h], ebx
        mov dword [esp], edi
        xor ebx, ebx
        test ecx, ecx
        jle short .4
        lea edi, [nosplit edx*4+00h]
        imul edx, ebx
        add edx, eax
.1:
        fld dword [edx]
        fcomp dword [byte esp+08h]
        fnstsw ax
        sahf
        jae short .2
        mov eax, dword [edx]
        mov dword [byte esp+08h], eax
.2:
        fld dword [edx]
        fcomp dword [esp]
        fnstsw ax
        sahf
        jbe short .3
        mov eax, dword [edx]
        mov dword [esp], eax
.3:
        inc ebx
        add edx, edi
        cmp ebx, ecx
        jl short .1
.4:
        fld dword [byte esp+08h]
        fadd qword [F64_0p5_ReadBits]
        call __CHP
        fistp dword [byte esp+04h]
        mov edx, dword [byte esp+04h]
        mov word [esi], dx
        fild word [esi]
        fsubr dword [esp]
        fadd qword [F64_0p5_ReadBits]
        call __CHP
        fistp dword [byte esp+04h]
        mov edx, dword [byte esp+04h]
        mov word [byte esi+02h], dx
        xor edx, edx
.5:
        mov ebx, 1
        mov cl, dl
        shl ebx, cl
        dec ebx
        mov dword [byte esp+04h], ebx
        fild dword [byte esp+04h]
        fild word [byte esi+02h]
        fdivrp
        fcomp dword [byte ebp+014h]
        fnstsw ax
        sahf
        jbe short .6
        inc edx
        jmp short .5
.6:
        mov eax, edx
        mov esp, ebp
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret 8
        db 00h,00h
;-----------------------------------------------------------------------------
; start                                                        116150  library
; Program entry point: the C run-time start-up
;-----------------------------------------------------------------------------
start:
        jmp short start_74.1
        push edi
        inc ecx
        push esp
        inc ebx
        dec edi
        dec ebp
        and byte [byte ebx+02Fh], al
        inc ebx
        sub ebp, dword [ebx]
        xor esi, dword [edx]
        and byte [byte edx+075h], dl
        outsb
        sub eax, 656D6954h
        and byte [byte ebx+079h], dh
        db 073h,074h                            ; insn: raw (target 1161E2 unlabelled)
        db 065h,06Dh                            ; insn: insd
        and byte [cs:eax], ch
        arpl word [ecx], bp
        and byte [byte ebx+06Fh], al
        db 070h,079h                            ; insn: raw (target 1161F3 unlabelled)
        jb short start_74.2
        db 067h,068h,074h,020h,062h,079h        ; insn: push 79622074h
        and byte [byte edi+041h], dl
        push esp
        inc ebx
        dec edi
        dec ebp
        and byte [byte ecx+06Eh], cl
        db 074h,065h                            ; insn: raw (target 1161F3 unlabelled)
        jb short start_74.4
        popa
        je short start_74.3
        outsd
        outsb
        popa
        insb
        and byte [byte ebx+06Fh], al
        jb short start_74.5
        and byte [cs:ecx], dh
        cmp dword [eax], edi
        cmp byte [035393931h], ch
        and byte [byte cs:ecx+06Ch], al
        insb
        and byte [byte edx+069h], dh
        db 067h,068h,074h,073h,020h,072h        ; insn: push 72207374h
        db 065h,073h, start_74.6-($+3)
        jb short start_74.7
        db 065h,064h,02Eh,08Dh,040h,00h         ; insn: lea eax,[eax]
        dd CodeStartPad
start_74:
        arpl word [byte edi+06Eh], bp
        db 00h
.1:
        sti
        and esp, byte 0FFFFFFFCh
        mov ebx, esp
        mov dword [_STACKTOP], ebx
        mov dword [_curbrk], ebx
        mov ax, 24h
        mov word [_psp], ax
        db 0BBh
.2:
        push edx
        inc ecx
        dec eax
        push eax
        sub eax, eax
        mov ah, 30h
        int 21h
        mov byte [_osmajor], al
        mov byte [_osminor], ah
        mov ecx, eax
.3:
        sub esi, esi
.4:
        mov edi, 81h
        shr eax, 10h
        cmp ax, 4458h
        jne short .8
.5:
        sub bl, 30h
        mov al, bl
        mov ah, 0
        push eax
        o16 mov es, word [_psp]
        db 026h
        db 08Bh
.6:
        sbb eax, 5Ch
        add ebx, 0FFFh
        and ebx, 0FFFFF000h
        db 089h
        db 01Dh
.7:
        dd _curbrk
        shr ebx, 0Ch
        mov ax, ds
        mov es, eax
        mov ah, 4Ah
        int 21h
        pop eax
        mov bx, ds
        mov cx, 2Ch
        jmp short .9
.8:
        cmp ax, 4243h
        jne short .10
        mov dword [FpuFlags], edx
        mov esi, edx
        mov edx, dword [byte esi+01Ch]
        mov ebx, esp
        sub ebx, edx
        mov ah, 4Ah
        int 21h
        mov bx, ds
        o16 mov word [_psp], ds
        mov eax, dword [byte esi+010h]
        add edi, eax
        sub esi, esi
        mov si, word [byte eax+02Ch]
        shl esi, 4
        mov cx, ds
        mov al, 9
        mov ah, 0
.9:
        jmp short .14
.10:
        mov dx, 78h
        mov ax, 0FF00h
        int 21h
        cmp al, 0
        je short .13
        mov ax, gs
        cmp ax, byte 0
        je short .11
        mov word [str_Punct_InitFpuFlags], ax
.11:
        mov ax, 6
        mov bx, ds
        int 31h
        mov al, 1
        mov ah, 0
        or dx, cx
        je short .12
        mov ah, 1
.12:
        o16 mov word [_psp], es
        db 066h,026h,08Bh,0Dh,02Ch,00h,00h,00h  ; insn: mov cx,[es:2Ch]
        jmp short .14
.13:
        mov dx, ds
        mov cx, 24h
        mov ds, ecx
        mov cx, 2Ch
        mov ds, edx
        mov bx, 17h
        mov al, 0
        mov ah, 0
.14:
        mov byte [_Extender], al
        mov byte [_ExtenderSubtype], ah
        mov es, ebx
        db 066h,026h,08Ch,01Dh                  ; insn: o16 mov [es:__saved_DS],ds
        dd __saved_DS
        mov dword [_Envptr], esi
        mov word [_Envptr_w4], cx
        push esi
        o16 mov es, word [_psp]
        db 03Eh,0BAh                            ; insn: mov edx,StartupStack
        dd StartupStack
        add edx, byte 0Fh
        and dl, 0F0h
        sub ecx, ecx
        mov cl, byte [byte es:edi-01h]
        cld
        mov al, 20h
        repe scasb
        lea esi, [byte edi-01h]
        mov edi, edx
        mov bx, es
        mov dx, ds
        mov ds, ebx
        mov es, edx
        je short .15
        inc ecx
        rep movsb
.15:
        sub al, al
        stosb
        stosb
        pop esi
        dec edi
        push edi
        push edx
        o16 mov ds, word [es:_Envptr_w4]
        sub ebp, ebp
.16:
        mov eax, dword [esi]
        or eax, 20202020h
        cmp eax, 37386F6Eh
        jne short .17
        cmp byte [byte esi+04h], 3Dh
        jne short .17
        inc ebp
.17:
        cmp byte [esi], 0
        lodsb
        jne short .17
        cmp byte [esi], 0
        jne short .16
        lodsb
        inc esi
        inc esi
.18:
        cmp byte [esi], 0
        movsb
        jne short .18
        pop ds
        pop esi
        mov ebx, esp
        mov word [__no87], bp
        mov dword [_STACKLOW], edi
        mov dword [_dynend], ebx
        db 03Eh,0B9h                            ; insn: mov ecx,StartupStack
        dd StartupStack
        db 03Eh,0BFh                            ; insn: mov edi,GripCallOffset
        dd GripCallOffset
        sub ecx, edi
        cmp byte [_Extender], 1
        jne short .19
        cmp ecx, 1000h
        jbe short .19
        mov ecx, 1000h
.19:
        mov dl, cl
        shr ecx, 2
        sub eax, eax
        rep stosd
        mov cl, dl
        and cl, 3
        rep stosb
        db 03Eh,0B8h                            ; insn: mov eax,StartupStack
        dd StartupStack
        add eax, byte 0Fh
        and al, 0F0h
        mov dword [_LpCmdLine], eax
        mov dword [StackLow], esi
        mov eax, 0FFh
        call __InitRtns
        sub ebp, ebp
        call __CMain
start_28F:
        jmp short WriteConsoleMessage_23
;-----------------------------------------------------------------------------
; WriteConsoleMessage                            1163E1  97 PC, low confidence
; Writes a message to the console through DOS before exit
;-----------------------------------------------------------------------------
WriteConsoleMessage:
        push edx
        push eax
        db 0BAh                                 ; insn: mov edx,start_74
        dd start_74
        mov ax, 3D01h
        int 21h
        mov bx, ax
        pop edx
        mov esi, edx
        cld
.1:
        lodsb
        cmp al, 0
        jne short .1
        mov ecx, esi
        sub ecx, edx
        dec ecx
        mov ah, 40h
        int 21h
        pop eax
WriteConsoleMessage_23:
        push eax
        mov eax, 0
        mov edx, 0FFh
        call __FiniRtns
        pop eax
        mov ah, 4Ch
        int 21h
        lea eax, [byte eax+00h]
;-----------------------------------------------------------------------------
; RestoreDS                                      11641C  97 PC, low confidence
; Loads the saved data segment (for interrupt handlers)
;-----------------------------------------------------------------------------
RestoreDS:                                      ; loads the saved data segment (for interrupt handlers); used
                                                ; by AssertFail, ClearNumLock, EmuTrapExit ...
        db 066h,02Eh,08Eh,01Dh                  ; insn: o16 mov ds,[cs:__saved_DS]
        dd __saved_DS
        ret
