; EA library: CountVesaModes, FindModeByResolution, SetModeByResolution.
bits 32
%include "hockey.inc"
section s_120650 progbits alloc exec nowrite align=1
extern BytesPerPixelForDepth, ModeTableBpp, ModeTableHeight, ModeTableNumber, ModeTableWidth, SelectedVideoMode, SetGraphicsMode, VesaQueryMode
extern ZeroMem
global CountVesaModes, FindModeByResolution, SetModeByResolution
;-----------------------------------------------------------------------------
; CountVesaModes                                 120650  97 PC, low confidence
; Counts the listed VESA modes the card answers for
;-----------------------------------------------------------------------------
CountVesaModes:
        push ebx
        xor ebx, ebx
        xor edx, edx
.1:
        mov eax, dword [dword edx+ModeTableNumber]
        lea ecx, [byte ebx+01h]
        cmp eax, 100h
        jl short .2
        call VesaQueryMode
        test eax, eax
        je short .3
.2:
        mov ebx, ecx
.3:
        add edx, byte 10h
        cmp edx, 150h
        jne short .1
        mov eax, ebx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; FindModeByResolution                           120680  97 PC, low confidence
; Finds the listed video mode with the given resolution and depth
;-----------------------------------------------------------------------------
FindModeByResolution:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov edi, dword [byte esp+018h]
        mov ebp, dword [byte esp+01Ch]
        mov edx, 0FFFFFFFFh
        xor ebx, ebx
        xor esi, esi
        mov dword [esp], ebx
.1:
        mov eax, dword [dword ebx+ModeTableNumber]
        lea ecx, [byte edx+01h]
        cmp eax, 100h
        jl short .2
        call VesaQueryMode
        test eax, eax
        je short .3
.2:
        mov edx, ecx
.3:
        cmp edx, edi
        je short .4
        add ebx, byte 10h
        inc esi
        cmp ebx, 150h
        jl short .1
.4:
        test edx, edx
        jl short .5
        push byte 14h
        push ebp
        shl esi, 4
        call ZeroMem
        mov eax, dword [dword esi+ModeTableWidth]
        mov dword [byte ebp+00h], eax
        mov eax, dword [dword esi+ModeTableHeight]
        mov dword [byte ebp+04h], eax
        add esp, byte 8
        mov eax, dword [dword esi+ModeTableBpp]
        push eax
        mov dword [byte ebp+08h], eax
        call BytesPerPixelForDepth
        mov dword [byte ebp+0Ch], eax
        mov esi, 1
        mov ah, byte [byte ebp+010h]
        add esp, byte 4
        or ah, 1
        mov dword [esp], esi
        mov byte [byte ebp+010h], ah
.5:
        mov eax, dword [esp]
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; SetModeByResolution                            12071C  97 PC, low confidence
; Finds the video mode with the given resolution and switches to it
;-----------------------------------------------------------------------------
SetModeByResolution:
        push ebx
        push esi
        sub esp, byte 14h
        mov eax, esp
        push eax
        mov edx, dword [byte esp+024h]
        push edx
        call FindModeByResolution
        add esp, byte 8
        mov ebx, dword [byte esp+08h]
        push ebx
        mov ecx, dword [byte esp+08h]
        push ecx
        mov esi, dword [byte esp+08h]
        push esi
        call SetGraphicsMode
        add esp, byte 0Ch
        mov eax, dword [byte esp+020h]
        mov dword [SelectedVideoMode], eax
        mov eax, 1
        add esp, byte 14h
        pop esi
        pop ebx
        ret
