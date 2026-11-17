; Watcom C runtime: printf_, DetectCPU, _dos_close_, _dos_commit_, _dos_open_.
bits 32
%include "hockey.inc"
section s_10AF13 progbits alloc exec nowrite align=1
extern __doserror_, __fprtf_, __stdout_buf, CpuFeatures, CpuHasCpuid, CpuIs386, CpuIs486, CpuIsPentium
extern CpuSignature, CpuType
global printf_, DetectCPU, _dos_close_, _dos_commit_, _dos_open_
;-----------------------------------------------------------------------------
; printf_                                                      10AF13  library
; Run-time library printf: formats to standard output
;-----------------------------------------------------------------------------
printf_:
        push ebx
        push edx
        sub esp, byte 4
        lea eax, [byte esp+014h]
        mov ebx, esp
        mov edx, dword [byte esp+010h]
        mov dword [esp], eax
        mov eax, __stdout_buf
        call __fprtf_
        add esp, byte 4
        pop edx
        pop ebx
        ret
        db 00h,00h,00h
;-----------------------------------------------------------------------------
; DetectCPU                                   10AF38  96 PC, medium confidence
; Detects the CPU type (386, 486, Pentium) and its CPUID features
;-----------------------------------------------------------------------------
DetectCPU:
        push ebx
        mov dword [CpuIs386], 1
        mov dword [CpuIs486], 1
        smsw eax
        and eax, byte 1
        mov dword [CpuFeatures], eax
        pushf
        LD mov, edx, esp
        and esp, byte 0FFFFFFFCh
        pushf
        pop eax
        LD mov, ecx, eax
        xor eax, 40000h
        push eax
        popf
        pushf
        pop eax
        LD xor, eax, ecx
        shr eax, 12h
        and eax, byte 1
        push ecx
        db 09Dh                                 ; insn: popf
        LD mov, esp, edx
        popf
        mov dword [CpuType], eax
        cmp eax, byte 0
        je short .1
        pushf
        pop eax
        LD mov, ecx, eax
        or eax, 200000h
        push eax
        popf
        pushf
        pop eax
        LD xor, eax, ecx
        je short .1
        mov eax, 1
        cpuid
        shr edx, 17h
        and edx, byte 1
        mov dword [CpuSignature], edx
        shr eax, 8
        and eax, byte 0Fh
        cmp al, 5
        jl short .1
        mov dword [CpuIsPentium], 1
        cmp al, 6
        jl short .1
        mov dword [CpuHasCpuid], 1
.1:
        pop ebx
        ret
;-----------------------------------------------------------------------------
; _dos_close_                                                  10AFCA  library
; Run-time library _dos_close: closes a DOS file handle
;-----------------------------------------------------------------------------
_dos_close_:
        push ebx
        mov bx, ax
        mov ah, 3Eh
        int 21h
        call __doserror_
        pop ebx
        ret
;-----------------------------------------------------------------------------
; _dos_commit_                                                 10AFD9  library
; Run-time library _dos_commit: flushes a DOS file to disk
;-----------------------------------------------------------------------------
_dos_commit_:
        push ebx
        mov bx, ax
        mov ah, 68h
        clc
        int 21h
        call __doserror_
        pop ebx
        ret
;-----------------------------------------------------------------------------
; _dos_open_                                                   10AFE9  library
; Run-time library _dos_open: opens a DOS file
;-----------------------------------------------------------------------------
_dos_open_:
        xchg edx, eax
        mov ah, 3Dh
        int 21h
        jb short .1
        mov dword [ebx], eax
.1:
        call __doserror_
        ret
