; Watcom C runtime: _nexpand_, __HeapManager_expand_, _nmsize_, isatty_, _dosret0_ and 3 more.
bits 32
%include "hockey.inc"
section s_1301FF progbits alloc exec nowrite align=1
extern __ExpandDGROUP_, __HeapFlags, __io_mode, __NHandles, __set_doserrno_, __set_errno_, _Extender, _ExtenderSubtype
extern _nfree_, _osmajor, DosErrnoTable, HeapList
global _nexpand_, _nexpand__10, __HeapManager_expand_, __HeapManager_expand__18F, __HeapManager_expand__1F0, _nmsize_, isatty_, _dosret0_
global __set_errno_dos_, __IOMode_, __SetIOMode_
;-----------------------------------------------------------------------------
; _nexpand_                                                    1301FF  library
; Run-time library: grows a near heap block in place
;-----------------------------------------------------------------------------
_nexpand_:
        push ebx
        push ecx
        push esi
        push edi
        sub esp, byte 8
        mov esi, eax
        mov edi, edx
        and byte [byte esp+04h], 0FEh
_nexpand__10:
        mov eax, HeapList
        mov edx, ds
        mov ecx, esp
        xor eax, eax
        mov ebx, edi
        mov ax, dx
        mov edx, esi
        call __HeapManager_expand_
        mov ecx, eax
        test eax, eax
        jne near __HeapManager_expand__18F
        mov eax, esi
        jmp near __HeapManager_expand__1F0
;-----------------------------------------------------------------------------
; __HeapManager_expand_                                        130237  library
; Run-time heap: grows a block in place
;-----------------------------------------------------------------------------
__HeapManager_expand_:
        push esi
        push edi
        push ebp
        sub esp, byte 0Ch
        push eax
        mov edi, edx
        lea eax, [byte ebx+07h]
        and al, 0FCh
        cmp eax, ebx
        jae short .1
        mov eax, 0FFFFFFFFh
.1:
        cmp eax, byte 0Ch
        jae short .2
        mov eax, 0Ch
.2:
        lea edx, [byte edi-04h]
        mov dword [byte esp+04h], edx
        mov edx, dword [edx]
        and dl, 0FEh
        cmp eax, edx
        jbe near .14
        mov ebx, dword [byte esp+04h]
        sub eax, edx
        add ebx, edx
.3:
        mov dword [ecx], eax
        mov ebp, dword [ebx]
        cmp ebp, byte 0FFFFFFFFh
        jne short .4
        mov ebp, 2
        jmp near .20
.4:
        test ebp, 1
        jne near .13
        mov eax, dword [byte ebx+08h]
        mov dword [byte esp+08h], eax
        mov eax, dword [byte ebx+04h]
        mov edx, ds
        mov dword [byte esp+0Ch], eax
        mov eax, HeapList
        cmp dx, word [esp]
        jne short .8
        mov esi, dword [HeapList]
        jmp short .7
.5:
        cmp esi, edi
        ja short .6
        cmp edi, edx
        jb short .8
.6:
        mov esi, dword [byte esi+08h]
.7:
        mov edx, dword [byte esi+08h]
        test edx, edx
        jne short .5
.8:
        mov edx, dword [byte esi+0Ch]
        cmp ebx, edx
        jne short .9
        mov eax, dword [byte edx+04h]
        mov dword [byte esi+0Ch], eax
.9:
        cmp ebp, dword [ecx]
        jb short .10
        mov eax, ebp
        mov edx, dword [ecx]
        sub eax, edx
        cmp eax, byte 0Ch
        jae short .11
.10:
        mov eax, dword [byte esp+0Ch]
        mov edx, dword [byte esp+08h]
        mov dword [byte eax+08h], edx
        mov eax, edx
        mov edx, dword [byte esp+0Ch]
        mov dword [byte eax+04h], edx
        mov eax, dword [byte esp+04h]
        add dword [eax], ebp
        mov eax, dword [byte esi+01Ch]
        dec eax
        xor dl, dl
        mov dword [byte esi+01Ch], eax
        mov byte [__HeapFlags], dl
        mov edx, dword [ecx]
        cmp ebp, edx
        jb short .12
        jmp near .19
.11:
        add ebx, edx
        mov dword [ebx], eax
        mov eax, dword [byte esp+0Ch]
        mov dword [byte ebx+04h], eax
        mov eax, dword [byte esp+08h]
        mov dword [byte ebx+08h], eax
        mov eax, dword [byte esp+0Ch]
        mov dword [byte eax+08h], ebx
        mov eax, dword [byte esp+08h]
        mov dword [byte eax+04h], ebx
        mov edx, dword [byte esp+04h]
        mov eax, dword [ecx]
        mov edi, dword [edx]
        xor ebp, ebp
        add edi, eax
        xor ah, ah
        mov dword [edx], edi
        mov byte [__HeapFlags], ah
        jmp near .20
.12:
        mov eax, edx
        sub eax, ebp
        add ebx, ebp
        jmp near .3
.13:
        mov ebp, 1
        jmp short .20
.14:
        sub edx, eax
        cmp edx, byte 0Ch
        jb short .19
        mov ebx, eax
        mov ecx, dword [byte esp+04h]
        or bl, 1
        or dl, 1
        mov dword [ecx], ebx
        lea ebx, [ecx+eax]
        mov eax, HeapList
        mov dword [byte esp+04h], ebx
        mov dword [ebx], edx
        mov edx, ds
        mov ebx, dword [esp]
        cmp dx, bx
        jne short .18
        mov esi, dword [HeapList]
        jmp short .17
.15:
        cmp esi, edi
        ja short .16
        cmp edi, ecx
        jb short .18
.16:
        mov esi, dword [byte esi+08h]
.17:
        mov ecx, dword [byte esi+08h]
        test ecx, ecx
        jne short .15
.18:
        inc dword [byte esi+018h]
        mov eax, dword [byte esp+04h]
        add eax, byte 4
        call _nfree_
.19:
        xor ebp, ebp
.20:
        mov eax, ebp
        add esp, byte 10h
        pop ebp
        pop edi
        pop esi
        ret
__HeapManager_expand__18F:
        cmp eax, byte 1
        je short .25
        xor eax, eax
        mov al, byte [_Extender]
        cmp eax, byte 1
        jne short .21
        cmp byte [_ExtenderSubtype], 0
        je short .22
.21:
        xor eax, eax
        mov al, byte [_Extender]
        cmp eax, byte 9
        jne short .23
.22:
        xor eax, eax
        jmp short .24
.23:
        mov eax, 1
.24:
        test eax, eax
        je short .25
        cmp ecx, byte 2
        jne near _nexpand__10
        mov dh, byte [byte esp+04h]
        test dh, 1
        jne short .25
        mov eax, dword [esp]
        call __ExpandDGROUP_
        test eax, eax
        je short .25
        mov bl, dh
        or bl, 1
        mov byte [byte esp+04h], bl
        jmp near _nexpand__10
.25:
        xor eax, eax
__HeapManager_expand__1F0:
        add esp, byte 8
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; _nmsize_                                                     13042F  library
; Run-time library: the size of a near heap block
;-----------------------------------------------------------------------------
_nmsize_:
        mov eax, dword [byte eax-04h]
        and al, 0FEh
        sub eax, byte 4
        ret
;-----------------------------------------------------------------------------
; isatty_                                                      130438  library
; Run-time library isatty: whether a handle is a terminal
;-----------------------------------------------------------------------------
isatty_:
        push ebx
        push ecx
        push edx
        mov ebx, eax
        mov al, 0
        mov ah, 44h
        int 21h
        rcl edx, 1
        ror edx, 1
        xor dh, dh
        xor eax, eax
        and dl, 80h
        mov ax, dx
        test eax, eax
        setne al
        and eax, 0FFh
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; _dosret0_                                                    13045F  library
; Run-time library: returns 0 or sets errno from a DOS call
;-----------------------------------------------------------------------------
_dosret0_:
        test edx, edx
        jne short .2
        xor eax, eax
.1:
        ret
.2:
        test edx, edx
        je short .1
;-----------------------------------------------------------------------------
; __set_errno_dos_                                             13046A  library
;-----------------------------------------------------------------------------
__set_errno_dos_:
        push ebx
        push edx
        mov ebx, eax
        mov dl, al
        xor eax, eax
        mov al, bl
        call __set_doserrno_
        cmp ebx, 100h
        jae short .5
        xor eax, eax
        mov al, byte [_osmajor]
        cmp eax, byte 3
        jl short .3
        xor ebx, ebx
        mov bl, dl
        cmp ebx, byte 50h
        jne short .1
        mov dl, 0Eh
        jmp short .3
.1:
        cmp ebx, byte 22h
        jl short .2
        mov dl, 13h
        jmp short .3
.2:
        cmp ebx, byte 20h
        jl short .3
        mov dl, 5
.3:
        xor eax, eax
        mov al, dl
        cmp eax, byte 13h
        jle short .4
        mov dl, 13h
.4:
        xor ebx, ebx
        mov bl, dl
        mov eax, dword [dword ebx+DosErrnoTable]
        sar eax, 18h
        jmp short .6
.5:
        mov eax, ebx
        shr eax, 8
        and eax, 0FFh
.6:
        call __set_errno_
        mov eax, 0FFFFFFFFh
        pop edx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; __IOMode_                                                    1304DB  library
; Run-time library: the mode bits of a file handle
;-----------------------------------------------------------------------------
__IOMode_:
        push ebx
        push ecx
        push edx
        mov edx, eax
        cmp eax, dword [__NHandles]
        jb short .1
        xor eax, eax
        pop edx
        pop ecx
        pop ebx
        ret
.1:
        cmp eax, byte 5
        jg short .2
        mov ebx, eax
        mov eax, dword [__io_mode]
        shl ebx, 2
        add eax, ebx
        mov cl, byte [byte eax+01h]
        test cl, 40h
        jne short .2
        mov ch, cl
        or ch, 40h
        mov byte [byte eax+01h], ch
        mov eax, edx
        call isatty_
        test eax, eax
        je short .2
        mov eax, dword [__io_mode]
        or byte [byte ebx+eax+01h], 20h
.2:
        mov eax, dword [__io_mode]
        mov eax, dword [eax+edx*4]
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; __SetIOMode_                                                 130530  library
; Run-time library: sets the mode bits of a file handle
;-----------------------------------------------------------------------------
__SetIOMode_:
        push ebx
        or dh, 40h
        mov ebx, edx
        mov edx, eax
        mov eax, dword [__io_mode]
        shl edx, 2
        mov dword [edx+eax], ebx
        pop ebx
        ret
