; Watcom C runtime: __CMain, __InitRtns, __FiniRtns.
bits 32
%include "hockey.inc"
section s_12F9E3 progbits alloc exec nowrite align=1
extern __CommonInit_, CMainArgc, CMainArgv, CMainEnv, CMainHook, CMainResult, exit_, FiniRtnsEntry
extern InitRtnsEntry, main_, VideoCodePtr
global __CMain, __InitRtns, __FiniRtns
;-----------------------------------------------------------------------------
; __CMain                                                      12F9E3  library
; Run-time library: calls main
;-----------------------------------------------------------------------------
__CMain:
        push edx
        push ebp
        mov ebp, esp
        mov edx, dword [CMainEnv]
        add edx, byte 3
        and dl, 0FCh
        call CMainHook
        cmp edx, eax
        jae short .1
        mov eax, edx
        sub esp, eax
        mov eax, esp
        jmp short .2
.1:
        xor eax, eax
.2:
        mov edx, dword [CMainEnv]
        add eax, edx
        mov dword [CMainResult], eax
        call __CommonInit_
        mov edx, dword [CMainArgv]
        mov eax, dword [CMainArgc]
        call main_
        call exit_
        db 089h,0ECh,05Dh,05Ah,0C3h
;-----------------------------------------------------------------------------
; __InitRtns                                                   12FA32  library
; Run-time library: runs the init routine table by priority
;-----------------------------------------------------------------------------
__InitRtns:
        push esi
        push edi
        push ebx
        push edx
        push es
        mov edx, eax
.1:
        db 03Eh,0BEh                            ; insn: mov esi,InitRtnsEntry
        dd InitRtnsEntry
        db 03Eh,0BFh                            ; insn: mov edi,FiniRtnsEntry
        dd FiniRtnsEntry
        mov ebx, edi
        mov al, dl
.2:
        cmp esi, edi
        jae short .4
        cmp byte [esi], 2
        je short .3
        cmp byte [byte esi+01h], al
        ja short .3
        mov ebx, esi
        mov al, byte [byte esi+01h]
.3:
        add esi, byte 6
        jmp short .2
.4:
        cmp ebx, edi
        je short .6
        mov eax, dword [byte ebx+02h]
        or eax, eax
        je short .5
        push ds
        pop es
        push edx
        call eax
        pop edx
.5:
        mov byte [ebx], 2
        jmp short .1
.6:
        pop es
        pop edx
        pop ebx
        pop edi
        pop esi
        ret
;-----------------------------------------------------------------------------
; __FiniRtns                                                   12FA7D  library
; Run-time library: runs the fini routine table by priority
;-----------------------------------------------------------------------------
__FiniRtns:
        push esi
        push edi
        push ebx
        push es
        mov dh, dl
        mov dl, al
.1:
        db 03Eh,0BEh                            ; insn: mov esi,FiniRtnsEntry
        dd FiniRtnsEntry
        db 03Eh,0BFh                            ; insn: mov edi,VideoCodePtr
        dd VideoCodePtr
        mov ebx, edi
        mov al, dl
.2:
        cmp esi, edi
        jae short .4
        cmp byte [esi], 2
        je short .3
        cmp al, byte [byte esi+01h]
        ja short .3
        mov ebx, esi
        mov al, byte [byte esi+01h]
.3:
        add esi, byte 6
        jmp short .2
.4:
        cmp ebx, edi
        je short .6
        cmp al, dh
        ja short .5
        mov eax, dword [byte ebx+02h]
        or eax, eax
        je short .5
        push ds
        pop es
        push edx
        call eax
        pop edx
.5:
        mov byte [ebx], 2
        jmp short .1
.6:
        pop es
        pop ebx
        pop edi
        pop esi
        ret
