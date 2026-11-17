; Video: VesaGetModeInfo, VesaQueryMode.
bits 32
%include "hockey.inc"
section s_102F40 progbits alloc exec nowrite align=1
extern AllocMemBlock, FreeMemBlock, int386x_, memset_, segread_, str_VESAMEM, VesaModeInfo
global VesaGetModeInfo, VesaQueryMode
;-----------------------------------------------------------------------------
; VesaGetModeInfo                                102F40  97 PC, low confidence
; Asks the VESA BIOS for a mode's information through a DOS memory buffer
;-----------------------------------------------------------------------------
VesaGetModeInfo:
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 78h
        mov esi, eax
        mov edi, edx
        push dword 200h
        push dword 400h
        push str_VESAMEM
        mov ebx, 32h
        xor ebp, ebp
        call AllocMemBlock
        add esp, byte 0Ch
        mov dword [VesaModeInfo], eax
        mov ecx, eax
        xor edx, edx
        mov eax, esp
        shr ecx, 4
        call memset_
        mov edx, 4F01h
        lea eax, [byte esp+06Ch]
        mov ebx, 10h
        mov dword [byte esp+018h], esi
        mov dword [esp], ebp
        mov word [byte esp+022h], cx
        mov dword [byte esp+01Ch], edx
        call segread_
        xor ecx, ecx
        mov edx, 300h
        mov eax, esp
        mov word [byte esp+054h], bx
        mov word [byte esp+058h], cx
        lea ecx, [byte esp+06Ch]
        mov word [byte esp+050h], dx
        mov edx, ds
        lea ebx, [byte esp+034h]
        mov eax, esp
        mov word [byte esp+06Ch], dx
        lea edx, [byte esp+050h]
        mov dword [byte esp+064h], eax
        mov eax, 31h
        call int386x_
        mov ecx, 100h
        mov esi, dword [VesaModeInfo]
        push edi
        mov eax, ecx
        shr ecx, 2
        repne movsd
        LD mov, cl, al
        and cl, 3
        repne movsb
        pop edi
        mov eax, dword [byte esp+01Ch]
        and eax, 0FFFFh
        cmp eax, byte 4Fh
        jne short .1
        mov ebp, 1
.1:
        mov ecx, dword [VesaModeInfo]
        push ecx
        call FreeMemBlock
        add esp, byte 4
        mov eax, ebp
        add esp, byte 78h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; VesaQueryMode                                  103024  97 PC, low confidence
; Returns the VESA information for a mode in a stack buffer; followed by the
; resolution distance helper
;-----------------------------------------------------------------------------
VesaQueryMode:
        push edx
        sub esp, 100h
        mov edx, esp
        call VesaGetModeInfo
        add esp, 100h
        pop edx
        ret
        db 08Bh,0C0h
        push ecx
        push esi
        mov ecx, eax
        mov esi, edx
        sub eax, edx
        cdq
        xor eax, edx
        sub eax, edx
        mov edx, ebx
        imul edx
        shrd eax, edx, 10h
        adc eax, byte 0
        mov ebx, eax
        cmp ecx, esi
        jge short .1
        lea ebx, [nosplit eax*2+00h]
.1:
        mov eax, ebx
        pop esi
        pop ecx
        ret
