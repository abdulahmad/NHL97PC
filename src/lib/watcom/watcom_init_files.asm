; Watcom C runtime: __InitFiles_, __full_io_exit_, docloseall_, flushall_, __flushall_.
bits 32
%include "hockey.inc"
section s_132448 progbits alloc exec nowrite align=1
extern __ClosedStreams, __fatal_runtime_error_, __flush_, __freefp__39, __iob, __iob_end, __iob_flags, __OpenStreams
extern __shutdown_stream_, _nmalloc_, str_NotEnoughMemoryTo
global __InitFiles_, __full_io_exit_, docloseall_, flushall_, __flushall_
;-----------------------------------------------------------------------------
; __InitFiles_                                                 132448  library
; Run-time library: sets up the standard streams
;-----------------------------------------------------------------------------
__InitFiles_:
        push ebx
        push ecx
        push edx
        mov ah, byte [__iob_flags]
        and ah, 0F8h
        mov dl, ah
        mov byte [__iob_flags], ah
        or dl, 4
        mov ecx, __iob
        mov byte [__iob_flags], dl
        jmp short .3
.1:
        mov eax, 8
        call _nmalloc_
        mov ebx, eax
        test eax, eax
        jne short .2
        mov eax, 8
        call _nmalloc_
        mov ebx, eax
        test eax, eax
        jne short .2
        mov edx, 1
        mov eax, str_NotEnoughMemoryTo
        call __fatal_runtime_error_
.2:
        mov eax, dword [__ClosedStreams]
        mov dword [byte ebx+04h], ecx
        mov dword [__ClosedStreams], ebx
        add ecx, byte 1Ah
        mov dword [ebx], eax
.3:
        mov edx, dword [byte ecx+0Ch]
        test edx, edx
        jne short .1
        mov dword [__OpenStreams], edx
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; __full_io_exit_                                              1324BF  library
; Run-time library: closes all streams at exit
;-----------------------------------------------------------------------------
__full_io_exit_:
        xor eax, eax
        call docloseall_
        jmp near __freefp__39
        mov eax, 5
;-----------------------------------------------------------------------------
; docloseall_                                                  1324D0  library
;-----------------------------------------------------------------------------
docloseall_:
        push ebx
        push ecx
        push edx
        push esi
        mov edx, eax
        shl eax, 2
        sub eax, edx
        shl eax, 2
        add eax, edx
        mov esi, __iob
        add eax, eax
        xor ebx, ebx
        add esi, eax
        mov eax, dword [__ClosedStreams]
        jmp short .4
.1:
        mov ecx, dword [eax]
        mov eax, dword [byte eax+04h]
        mov edx, 1
        test byte [byte eax+0Dh], 40h
        jne short .2
        test byte [byte eax+0Dh], 8
        jne short .2
        cmp eax, esi
        jb short .3
        cmp eax, __iob_end
        jae short .2
        xor edx, edx
.2:
        call __shutdown_stream_
        inc ebx
.3:
        mov eax, ecx
.4:
        test eax, eax
        jne short .1
        mov eax, ebx
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; flushall_                                                    132528  library
; Run-time library flushall: writes out every stream
;-----------------------------------------------------------------------------
flushall_:
        mov eax, 0FFFFFFFFh
;-----------------------------------------------------------------------------
; __flushall_                                                  13252D  library
;-----------------------------------------------------------------------------
__flushall_:
        push ebx
        push ecx
        push edx
        mov ecx, eax
        mov edx, dword [__ClosedStreams]
        xor ebx, ebx
        jmp short .3
.1:
        mov eax, dword [byte edx+04h]
        test dword [byte eax+0Ch], ecx
        je short .2
        inc ebx
        test byte [byte eax+0Dh], 10h
        je short .2
        call __flush_
.2:
        mov edx, dword [edx]
.3:
        test edx, edx
        jne short .1
        mov eax, ebx
        pop edx
        pop ecx
        pop ebx
        ret
