; EA library: IniFindKey.
bits 32
%include "hockey.inc"
section s_12A787 progbits alloc exec nowrite align=1
extern fgets_, fseek_, ScapeCodecBase, SoundscapeBasePort, str_Punct_IniFindKey, strcmp_, strstr_, strupr_
global IniFindKey
        db 090h
;-----------------------------------------------------------------------------
; IniFindKey                                     12A788  97 PC, low confidence
; Finds a key in a settings file
;-----------------------------------------------------------------------------
IniFindKey:
        push ecx
        push esi
        push edi
        push ebp
        sub esp, 100h
        mov ebp, eax
        mov ecx, edx
        mov edi, esp
        mov esi, ebx
        push edi
.1:
        mov al, byte [esi]
        mov byte [edi], al
        cmp al, 0
        je short .2
        mov al, byte [byte esi+01h]
        add esi, byte 2
        mov byte [byte edi+01h], al
        add edi, byte 2
        cmp al, 0
        jne short .1
.2:
        pop edi
        mov eax, esp
        xor edx, edx
        call strupr_
        xor ebx, ebx
        mov eax, ebp
        call fseek_
        mov edi, 21h
.3:
        lea eax, [dword esp+080h]
        mov ebx, ebp
        mov edx, edi
        call fgets_
        mov esi, eax
        mov ah, byte [dword esp+080h]
        cmp ah, 5Bh
        je short .4
        cmp ah, 3Bh
        je short .4
        mov edx, str_Punct_IniFindKey
        lea eax, [dword esp+080h]
        call strstr_
        mov ebx, eax
        test eax, eax
        je short .4
        lea eax, [dword esp+080h]
        mov edx, esp
        call strupr_
        lea eax, [dword esp+080h]
        mov byte [ebx], 0
        call strcmp_
        inc ebx
        test eax, eax
        je short .5
.4:
        test esi, esi
        jne short .3
        jmp short .7
.5:
        mov dh, byte [ebx]
        test dh, dh
        je short .6
        cmp dh, 20h
        je short .6
        cmp dh, 9
        je short .6
        inc ecx
        inc ebx
        mov byte [byte ecx-01h], dh
        jmp short .5
.6:
        mov byte [ecx], 0
        xor eax, eax
        jmp short .8
.7:
        mov eax, 0FFFFFFFFh
.8:
        add esp, 100h
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 090h
        push edx
        mov edx, dword [SoundscapeBasePort]
        add edx, byte 4
        out dx, al
        mov edx, dword [SoundscapeBasePort]
        add edx, byte 5
        sub eax, eax
        in al, dx
        pop edx
        ret
        db 08Dh,040h,00h
        push ebx
        mov ebx, edx
        mov edx, dword [SoundscapeBasePort]
        add edx, byte 4
        out dx, al
        mov edx, dword [SoundscapeBasePort]
        mov al, bl
        add edx, byte 5
        out dx, al
        pop ebx
        ret
        db 090h
        push edx
        mov edx, dword [ScapeCodecBase]
        out dx, al
        mov edx, dword [ScapeCodecBase]
        inc edx
        sub eax, eax
        in al, dx
        pop edx
        ret
        push ebx
        mov ebx, edx
        mov edx, dword [ScapeCodecBase]
        out dx, al
        mov edx, dword [ScapeCodecBase]
        mov al, bl
        inc edx
        out dx, al
        pop ebx
        ret
        db 08Bh,0C0h
        push ebx
        push edx
        mov edx, 21h
        xor ebx, ebx
.9:
        inc ebx
        sub eax, eax
        in al, dx
        cmp ebx, 1C800h
        jl short .9
        pop edx
        pop ebx
        ret
