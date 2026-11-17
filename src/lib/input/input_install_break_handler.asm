; Input: InstallBreakHandler, RemoveBreakHandler, DispatchHotkey, RegisterHotkey.
bits 32
%include "hockey.inc"
section s_13073E progbits alloc exec nowrite align=1
extern AddExitHandler, BreakCallFunc, BreakDataSelector, ClearNumLock_F, DosGetVector, DosSetVector, HotkeyFuncTable, HotkeyModTable
extern HotkeyNesting, HotkeyScanTable, SavedBreakOffset, SavedBreakSelector
global InstallBreakHandler, RemoveBreakHandler, DispatchHotkey, RegisterHotkey
;-----------------------------------------------------------------------------
; InstallBreakHandler                            13073E  97 PC, low confidence
; Installs a Ctrl-Break handler through a real-mode callback in DOS memory
; and registers its removal at exit
;-----------------------------------------------------------------------------
InstallBreakHandler:
        push ebp
        LD mov, ebp, esp
        push ebx
        mov eax, dword [byte ebp+08h]
        mov dword [BreakCallFunc], eax
        mov ax, cs
        mov word [BreakDataSelector], ax
        cmp word [SavedBreakSelector], byte 0
        jne short .1
        mov ebx, 24h
        call DosGetVector
        mov dword [SavedBreakOffset], eax
        mov word [SavedBreakSelector], dx
        mov ebx, 24h
        mov dx, cs
        mov eax, ClearNumLock_F
        call DosSetVector
        push RemoveBreakHandler
        call AddExitHandler
        add esp, byte 4
.1:
        pop ebx
        leave
        ret
;-----------------------------------------------------------------------------
; RemoveBreakHandler                             130795  97 PC, low confidence
; Frees the DOS memory of the Ctrl-Break callback and clears its selector
;-----------------------------------------------------------------------------
RemoveBreakHandler:
        pusha
        mov ebx, 24h
        mov dx, word [SavedBreakSelector]
        mov eax, dword [SavedBreakOffset]
        LD or, dx, dx
        je short .1
        call DosSetVector
        mov word [SavedBreakSelector], 0
.1:
        popa
        ret
;-----------------------------------------------------------------------------
; DispatchHotkey                                 1307BC  97 PC, low confidence
; Looks up the handler registered for a key (ASCII or extended scan code) and
; calls it
;-----------------------------------------------------------------------------
DispatchHotkey:
        push ebp
        LD mov, ebp, esp
        dec dword [HotkeyNesting]
        jne short .4
        mov edx, dword [byte ebp+08h]
        LD or, dl, dl
        je short .2
        and edx, byte 7Fh
        mov dword [byte ebp+08h], edx
        mov dl, byte [dword edx+HotkeyScanTable]
.1:
        dec edx
        jl short .4
        push edi
        push esi
        call dword [nosplit edx*4+HotkeyFuncTable]
        pop esi
        pop edi
        LD xor, eax, eax
        inc dword [HotkeyNesting]
        leave
        ret
.2:
        movzx edx, dh
        cmp edx, 84h
        jl short .3
        mov edx, 84h
.3:
        mov dl, byte [dword edx+HotkeyModTable]
        jmp short .1
.4:
        mov eax, dword [byte ebp+08h]
        inc dword [HotkeyNesting]
        leave
        ret
;-----------------------------------------------------------------------------
; RegisterHotkey                                 130815  97 PC, low confidence
; Stores a handler in the hotkey table (64 slots) and maps a key to it
;-----------------------------------------------------------------------------
RegisterHotkey:
        push ebp
        LD mov, ebp, esp
        mov eax, dword [byte ebp+0Ch]
        mov ecx, 40h
        mov edx, HotkeyFuncTable
.1:
        cmp dword [edx], eax
        je short .3
        cmp word [edx], byte 0
        je short .2
        add edx, byte 4
        dec ecx
        jne short .1
        leave
        ret
.2:
        mov dword [edx], eax
.3:
        mov eax, 41h
        LD sub, eax, ecx
.4:
        mov edx, dword [byte ebp+08h]
        LD or, dl, dl
        je short .6
        cmp edx, byte 7Fh
        jg short .5
        mov byte [dword edx+HotkeyScanTable], al
.5:
        leave
        ret
.6:
        movzx edx, dh
        cmp edx, 84h
        jg short .5
        mov byte [dword edx+HotkeyModTable], al
        leave
        ret
        push ebp
        LD mov, ebp, esp
        LD xor, eax, eax
        jmp short .4
