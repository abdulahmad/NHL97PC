; Watcom C runtime: modf_, __CmpBigInt, __Rnd2Int, __Bin2String, BigIntCallHook and 13 more.
bits 32
%include "hockey.inc"
section s_13B9C2 progbits alloc exec nowrite align=1
extern __8087, __CHP, __DOS4G_hook_fini_, __DOS4G_hook_init_, __Ergo_hook_fini_, __Ergo_hook_init_, __fatal_runtime_error_, __Intel_hook_fini_
extern __Intel_hook_init_, __Phar_hook_fini_, __Phar_hook_init_, __sigfpe_handler_, _Extender, _STACKLOW, AbortHandler, FpuExitHook
extern FpuFixupBuffer, FpuHandlerStack, FpuInitHook, FpuLoadInfinity, FpuRestoreStackTop, FpuSavedEsp, FpuSavedSs, FpuStoreResult
extern RestoreDS, SavedFpuEs, str_ABNORMALTERMINATION
global modf_, __CmpBigInt, __Rnd2Int, __Bin2String, BigIntCallHook, BigIntNullHook, frexp_, abort_
global __terminate_, SignalHookFpu, __GrabFP87_, HookFpuExceptions, UnhookFpuExceptions, EnableFpuExceptions, FpuIrqEoi, FpuExceptionHandler
global FpuClassifyException, FpuFixupResult
;-----------------------------------------------------------------------------
; modf_                                                        13B9C2  library
; Run-time library modf: splits a double into integer and fraction
;-----------------------------------------------------------------------------
modf_:
        push eax
        fld qword [byte esp+08h]
        fld st0
        call __CHP
        fsub to st1
        mov eax, dword [byte esp+010h]
        fstp qword [eax]
        pop eax
        wait
        ret 0Ch
        db 00h
;-----------------------------------------------------------------------------
; __CmpBigInt                                                  13B9DC  library
; Run-time library: compares two big integers (float conversion)
;-----------------------------------------------------------------------------
__CmpBigInt:
        push edi
        push ecx
        call BigIntCallHook
        inc eax
        lea edi, [edi+eax*8]
        mov ecx, dword [edx]
        mov edx, dword [byte edx+04h]
        sub eax, eax
.1:
        cmp edx, dword [cs:edi]
        jne short .2
        cmp ecx, dword [byte cs:edi+04h]
.2:
        jb short .3
        add edi, byte 8
        inc eax
        jmp short .1
.3:
        sub edi, byte 8
.4:
        cmp edx, dword [cs:edi]
        jne short .5
        cmp ecx, dword [byte cs:edi+04h]
.5:
        jae short .6
        sub edi, byte 8
        dec eax
        jmp short .4
.6:
        pop ecx
        pop edi
        ret
;-----------------------------------------------------------------------------
; __Rnd2Int                                                    13BA16  library
; Run-time library: rounds a double to an integer
;-----------------------------------------------------------------------------
__Rnd2Int:
        push ebx
        push ecx
        push edx
        push ebp
        push esi
        push edx
        mov ebp, eax
        mov ecx, dword [byte ebp+00h]
        mov ebx, dword [byte ebp+04h]
        mov ebp, ebx
        and ebp, 0FFF00000h
        xor ebx, ebp
        xor ebx, 100000h
        shr ebp, 14h
        sub ebp, 433h
        je short .5
        jbe short .2
.1:
        shl ecx, 1
        rcl ebx, 1
        dec ebp
        jne short .1
        jmp short .5
.2:
        sub eax, eax
        sub esi, esi
.3:
        shr ebx, 1
        rcr ecx, 1
        rcr eax, 1
        adc esi, esi
        inc ebp
        jne short .3
        cmp eax, 80000000h
        jb short .5
        jne short .4
        or esi, esi
        jne short .4
        test ecx, 1
        je short .5
.4:
        add ecx, byte 1
        adc ebx, byte 0
.5:
        pop ebp
        mov dword [byte ebp+00h], ecx
        mov dword [byte ebp+04h], ebx
        pop esi
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; __Bin2String                                                 13BA81  library
; Run-time library: a binary value to decimal digits
;-----------------------------------------------------------------------------
__Bin2String:
        push ebp
        push edi
        push ecx
        push ebx
        mov ebp, eax
        mov ecx, dword [byte ebp+00h]
        mov eax, dword [byte ebp+04h]
        mov ebp, edx
        add ebp, ebx
        mov byte [byte ebp+00h], 0
        push eax
.1:
        pop eax
        mov edi, 2710h
        sub edx, edx
        or eax, eax
        jne short .2
        or ecx, ecx
        jne short .3
        push eax
        jmp short .4
.2:
        div edi
.3:
        xchg ecx, eax
        div edi
        xchg ecx, eax
        push eax
        mov eax, edx
        mov dl, 64h
        div dl
        mov dl, ah
        mov ah, 0
        aam
        xchg edx, eax
        mov ah, 0
        aam
.4:
        add ax, 3030h
        add dx, 3030h
        sub ebp, byte 4
        mov byte [byte ebp+03h], al
        dec ebx
        je short .5
        mov byte [byte ebp+02h], ah
        dec ebx
        je short .5
        mov byte [byte ebp+01h], dl
        dec ebx
        je short .5
        mov byte [byte ebp+00h], dh
        dec ebx
        jne short .1
.5:
        pop eax
        pop ebx
        pop ecx
        pop edi
        pop ebp
        ret
;-----------------------------------------------------------------------------
; BigIntCallHook                                 13BAEB  97 PC, low confidence
; Calls the empty big-integer compare hook
;-----------------------------------------------------------------------------
BigIntCallHook:
        call BigIntNullHook
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,01h,00h,00h,00h
        db 00h,00h,00h,00h,0Ah,00h,00h,00h,00h,00h,00h,00h,064h,00h,00h,00h
        db 00h,00h,00h,00h,0E8h,03h,00h,00h,00h,00h,00h,00h,010h,027h,00h,00h
        db 00h,00h,00h,00h,0A0h,086h,01h,00h,00h,00h,00h,00h,040h,042h,0Fh,00h
        db 00h,00h,00h,00h,080h,096h,098h,00h,00h,00h,00h,00h,00h,0E1h,0F5h,05h
        db 00h,00h,00h,00h,00h,0CAh,09Ah,03Bh,02h,00h,00h,00h,00h,0E4h,0Bh,054h
        db 017h,00h,00h,00h,00h,0E8h,076h,048h,0E8h,00h,00h,00h,00h,010h,0A5h,0D4h
        db 018h,09h,00h,00h,00h,0A0h,072h,04Eh,0F3h,05Ah,00h,00h,00h,040h,07Ah,010h
        db 07Eh,08Dh,03h,00h,00h,080h,0C6h,0A4h,0F2h,086h,023h,00h,00h,00h,0C1h,06Fh
        db 078h,045h,063h,01h,00h,00h,08Ah,05Dh,0B3h,0B6h,0E0h,0Dh,00h,00h,064h,0A7h
        db 04h,023h,0C7h,08Ah,00h,00h,0E8h,089h,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh,0FFh
;-----------------------------------------------------------------------------
; BigIntNullHook                                 13BBA0  97 PC, low confidence
; Empty big-integer compare hook
;-----------------------------------------------------------------------------
BigIntNullHook:
        pop edi
        ret
;-----------------------------------------------------------------------------
; frexp_                                                       13BBA2  library
; Run-time library frexp: splits a double into mantissa and exponent
;-----------------------------------------------------------------------------
frexp_:
        push eax
        push ebx
        push ecx
        push edx
        sub esp, byte 8
        mov eax, dword [byte esp+01Ch]
        mov ecx, dword [byte esp+01Ch]
        mov dword [esp], eax
        mov eax, dword [byte esp+020h]
        xor edx, edx
        mov dword [byte esp+04h], eax
        test eax, 7FFFFFFFh
        jne short .1
        test ecx, ecx
        je short .2
.1:
        mov edx, dword [byte esp+06h]
        and edx, 7FF0h
        mov ebx, dword [byte esp+06h]
        and edx, 0FFFFh
        and ebx, 800Fh
        sar edx, 4
        mov ecx, ebx
        mov word [byte esp+06h], bx
        or ecx, 3FE0h
        sub edx, 3FEh
        mov word [byte esp+06h], cx
.2:
        mov eax, dword [byte esp+024h]
        fld qword [esp]
        mov dword [eax], edx
        add esp, byte 8
        pop edx
        pop ecx
        pop ebx
        pop eax
        ret 0Ch
;-----------------------------------------------------------------------------
; abort_                                                       13BC11  library
; Run-time library abort: ends the program abnormally
;-----------------------------------------------------------------------------
abort_:
        call dword [AbortHandler]
;-----------------------------------------------------------------------------
; __terminate_                                                 13BC17  library
;-----------------------------------------------------------------------------
__terminate_:
        push edx
        mov edx, 0FFh
        mov eax, str_ABNORMALTERMINATION
        call __fatal_runtime_error_
        pop edx
        ret
;-----------------------------------------------------------------------------
; SignalHookFpu                                  13BC29  97 PC, low confidence
; Signal() entry that hooks the coprocessor exception handler
;-----------------------------------------------------------------------------
SignalHookFpu:
        jmp near __GrabFP87_
;-----------------------------------------------------------------------------
; __GrabFP87_                                                  13BC2E  library
; Run-time library: takes over the FPU exception vector
;-----------------------------------------------------------------------------
__GrabFP87_:
        push ebx
        push ecx
        cmp dword [FpuExitHook], UnhookFpuExceptions
        je short .1
        mov ebx, __sigfpe_handler_
        mov ecx, UnhookFpuExceptions
        mov dword [FpuInitHook], ebx
        call HookFpuExceptions
        mov dword [FpuExitHook], ecx
.1:
        call EnableFpuExceptions
        pop ecx
        pop ebx
        ret
        db 00h
;-----------------------------------------------------------------------------
; HookFpuExceptions                              13BC60  97 PC, low confidence
; Installs the coprocessor exception handler through the running DOS extender
; when a coprocessor is present
;-----------------------------------------------------------------------------
HookFpuExceptions:
        cmp word [SavedFpuEs], byte 0
        jne short .1
        cmp byte [__8087], 0
        je short .1
        jmp short .2
.1:
        ret
.2:
        push eax
        push ebx
        push ecx
        push edx
        push es
        push ds
        cmp byte [_Extender], 0
        jne short .3
        call __Ergo_hook_init_
        jmp short .6
.3:
        cmp byte [_Extender], 1
        jne short .4
        call __DOS4G_hook_init_
        jmp short .6
.4:
        cmp byte [_Extender], 9
        jne short .5
        call __Intel_hook_init_
        jmp short .6
.5:
        call __Phar_hook_init_
.6:
        pop ds
        call EnableFpuExceptions
        pop es
        pop edx
        pop ecx
        pop ebx
        pop eax
        ret
;-----------------------------------------------------------------------------
; UnhookFpuExceptions                            13BCBD  97 PC, low confidence
; Masks coprocessor exceptions and removes the handler through the running
; DOS extender
;-----------------------------------------------------------------------------
UnhookFpuExceptions:
        cmp word [SavedFpuEs], byte 0
        jne short .1
        ret
.1:
        push eax
        push ebx
        push edx
        push ds
        sub esp, byte 4
        wait
        fnstcw word [esp]
        wait
        mov byte [esp], 7Fh
        fldcw word [esp]
        wait
        add esp, byte 4
        cmp byte [_Extender], 0
        jne short .2
        call __Ergo_hook_fini_
        jmp short .5
.2:
        cmp byte [_Extender], 1
        jne short .3
        call __DOS4G_hook_fini_
        jmp short .5
.3:
        cmp byte [_Extender], 9
        jne short .4
        call __Intel_hook_fini_
        jmp short .5
.4:
        call __Phar_hook_fini_
.5:
        pop ds
        pop edx
        pop ebx
        pop eax
        ret
        db 00h
;-----------------------------------------------------------------------------
; EnableFpuExceptions                            13BD1A  97 PC, low confidence
; Unmasks the invalid, divide-by-zero and overflow coprocessor exceptions
;-----------------------------------------------------------------------------
EnableFpuExceptions:
        sub esp, byte 4
        wait
        fnstcw word [esp]
        wait
        and word [esp], byte 0FFF2h
        fldcw word [esp]
        wait
        add esp, byte 4
        ret
;-----------------------------------------------------------------------------
; FpuIrqEoi                                      13BD2F  97 PC, low confidence
; Acknowledges the coprocessor interrupt at both interrupt controllers and
; the coprocessor port
;-----------------------------------------------------------------------------
FpuIrqEoi:
        push eax
        mov al, 20h
        out 20h, al
        out 0A0h, al
        xor ax, ax
        out 0F0h, al
        pop eax
;-----------------------------------------------------------------------------
; FpuExceptionHandler                            13BD3C  97 PC, low confidence
; Coprocessor exception handler: works out which exception fired, fixes the
; result and raises SIGFPE
;-----------------------------------------------------------------------------
FpuExceptionHandler:
        push eax
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        push ds
        push es
        sub esp, byte 1Ch
        mov ebp, esp
        fnstenv [byte ebp+00h]
        wait
        wait
        fnclex
        wait
        fndisi
        sti
        call RestoreDS
        mov edx, dword [byte ebp+00h]
        not edx
        mov dh, 0FFh
        and edx, dword [byte ebp+04h]
        mov es, word [byte ebp+010h]
        mov edi, dword [byte ebp+0Ch]
.1:
        db 066h,026h,08Bh,01Fh                  ; insn: mov bx,[es:edi]
        inc edi
        cmp bl, 0D8h
        jb short .1
        cmp bl, 0DFh
        ja short .1
        mov es, word [byte ebp+018h]
        mov edi, dword [byte ebp+014h]
        xchg bh, bl
        mov cl, 0
        test dl, 20h
        je short .2
        mov cl, 86h
        jmp short .10
.2:
        test dl, 40h
        je short .5
        test dx, 200h
        jne short .3
        mov cl, 8Bh
        jmp short .4
.3:
        mov cl, 8Ah
.4:
        jmp short .10
.5:
        test dl, 1
        je short .6
        call FpuClassifyException
        jmp short .10
.6:
        test dl, 2
        je short .7
        mov cl, 82h
        jmp short .10
.7:
        test dl, 8
        je short .8
        call FpuFixupResult
        mov cl, 84h
        jmp short .10
.8:
        test dl, 10h
        je short .9
        mov cl, 85h
        jmp short .10
.9:
        test dl, 4
        je short .10
        call FpuLoadInfinity
        mov cl, 83h
.10:
        cmp cl, 0
        je short .11
        push dword [_STACKLOW]
        o16 mov word [FpuSavedSs], ss
        mov dword [FpuSavedEsp], esp
        push ds
        pop ss
        lea esp, [FpuSavedSs]
        lea eax, [FpuHandlerStack]
        mov dword [_STACKLOW], eax
        movzx eax, cl
        call dword [FpuInitHook]
        o16 mov ss, word [FpuSavedSs]
        mov esp, dword [FpuSavedEsp]
        pop dword [_STACKLOW]
        mov word [FpuSavedSs], 0
.11:
        wait
        fnclex
        and word [byte ebp+00h], 0FF72h
        fldcw word [byte ebp+00h]
        wait
        add esp, byte 1Ch
        pop es
        pop ds
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        pop eax
        iret
;-----------------------------------------------------------------------------
; FpuClassifyException                           13BE42  97 PC, low confidence
; Decodes the faulting coprocessor instruction and returns the matching
; floating-point error code
;-----------------------------------------------------------------------------
FpuClassifyException:
        mov cl, 81h
        cmp bx, 0D9FAh
        jne short .1
        mov cl, 88h
        ret
.1:
        cmp bx, 0D9F1h
        jne short .2
        mov cl, 8Eh
        ret
.2:
        cmp bx, 0D9F8h
        je short .3
        cmp bx, 0D9F5h
.3:
        jne short .4
        mov cl, 8Fh
        jmp short .9
.4:
        mov dx, bx
        and dx, 310h
        cmp dx, 310h
        jne short .5
        mov cl, 8Dh
        jmp short .9
.5:
        and dx, 110h
        cmp dx, 110h
        jne short .8
        fstp st0
        fldz
        mov dl, bl
        and dl, 0C0h
        cmp dl, 0C0h
        je short .6
        call FpuStoreResult
.6:
        test bl, 8
        je short .7
        fstp st0
.7:
        mov cl, 85h
        jmp short .9
.8:
        mov dx, bx
        and dx, 130h
        cmp dx, byte 30h
        jne short .9
        mov dx, word [byte ebp+08h]
        mov cl, ah
        and cl, 38h
        shr cl, 2
        ror dx, cl
        and dl, 5
        cmp dl, 5
        jne short .9
        mov cl, 83h
.9:
        ret
;-----------------------------------------------------------------------------
; FpuFixupResult                                 13BECF  97 PC, low confidence
; Replaces the result of the faulting instruction with an infinity or the
; original operand
;-----------------------------------------------------------------------------
FpuFixupResult:
        cmp bx, 0D9FDh
        jne short .1
        jmp short .6
.1:
        mov dx, bx
        and dx, 110h
        cmp dx, 110h
        jne short .4
        call FpuLoadInfinity
        mov dl, bl
        and dl, 0C0h
        cmp dl, 0C0h
        je short .2
        call FpuStoreResult
.2:
        test bl, 8
        je short .3
        fstp st0
.3:
        jmp short .6
.4:
        mov dl, bl
        and dl, 0C0h
        cmp dl, 0C0h
        jne short .5
        lea esi, [FpuFixupBuffer]
        call FpuRestoreStackTop
        jmp short .6
.5:
        call FpuLoadInfinity
.6:
        ret
