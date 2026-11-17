; EA library: FillRectList.
bits 32
%include "hockey.inc"
section s_132101 progbits alloc exec nowrite align=1
extern FillRect
global FillRectList
        db 0CDh,01h,0C3h,0CDh,02h,0C3h,0CCh,090h,0C3h,0CDh,04h,0C3h,0CDh,05h,0C3h,0CDh
        db 06h,0C3h,0CDh,07h,0C3h,0CDh,08h,0C3h,0CDh,09h,0C3h,0CDh,0Ah,0C3h,0CDh,0Bh
        db 0C3h,0CDh,0Ch,0C3h,0CDh,0Dh,0C3h,0CDh,0Eh,0C3h,0CDh,0Fh,0C3h,0CDh,010h,0C3h
        db 0CDh,011h,0C3h,0CDh,012h,0C3h,0CDh,013h,0C3h,0CDh,014h,0C3h,0CDh,015h,0C3h,0CDh
        db 016h,0C3h,0CDh,017h,0C3h,0CDh,018h,0C3h,0CDh,019h,0C3h,0CDh,01Ah,0C3h,0CDh,01Bh
        db 0C3h,0CDh,01Ch,0C3h,0CDh,01Dh,0C3h,0CDh,01Eh,0C3h,0CDh,01Fh,0C3h,0CDh,020h,0C3h
        db 0CDh,021h,0C3h,0CDh,022h,0C3h,0CDh,023h,0C3h,0CDh,024h,0C3h,0CDh,025h,0C3h,0CDh
        db 026h,0C3h,0CDh,027h,0C3h,0CDh,028h,0C3h,0CDh,029h,0C3h,0CDh,02Ah,0C3h,0CDh,02Bh
        db 0C3h,0CDh,02Ch,0C3h,0CDh,02Dh,0C3h,0CDh,02Eh,0C3h,0CDh,02Fh,0C3h,0CDh,030h,0C3h
        db 0CDh,031h,0C3h,0CDh,032h,0C3h,0CDh,033h,0C3h,0CDh,034h,0C3h,0CDh,035h,0C3h,0CDh
        db 036h,0C3h,0CDh,037h,0C3h,0CDh,038h,0C3h,0CDh,039h,0C3h,0CDh,03Ah,0C3h,0CDh,03Bh
        db 0C3h,0CDh,03Ch,0C3h,0CDh,03Dh,0C3h,0CDh,03Eh,0C3h,0CDh,03Fh,0C3h,0CDh,040h,0C3h
        db 0CDh,041h,0C3h,0CDh,042h,0C3h,0CDh,043h,0C3h,0CDh,044h,0C3h,0CDh,045h,0C3h,0CDh
        db 046h,0C3h,0CDh,047h,0C3h,0CDh,048h,0C3h,0CDh,049h,0C3h,0CDh,04Ah,0C3h,0CDh,04Bh
        db 0C3h,0CDh,04Ch,0C3h,0CDh,04Dh,0C3h,0CDh,04Eh,0C3h,0CDh,04Fh,0C3h,0CDh,050h,0C3h
        db 0CDh,051h,0C3h,0CDh,052h,0C3h,0CDh,053h,0C3h,0CDh,054h,0C3h,0CDh,055h,0C3h,0CDh
        db 056h,0C3h,0CDh,057h,0C3h,0CDh,058h,0C3h,0CDh,059h,0C3h,0CDh,05Ah,0C3h,0CDh,05Bh
        db 0C3h,0CDh,05Ch,0C3h,0CDh,05Dh,0C3h,0CDh,05Eh,0C3h,0CDh,05Fh,0C3h,0CDh,060h,0C3h
        db 0CDh,061h,0C3h,0CDh,062h,0C3h,0CDh,063h,0C3h,0CDh,064h,0C3h,0CDh,065h,0C3h,0CDh
        db 066h,0C3h,0CDh,067h,0C3h,0CDh,068h,0C3h,0CDh,069h,0C3h,0CDh,06Ah,0C3h,0CDh,06Bh
        db 0C3h,0CDh,06Ch,0C3h,0CDh,06Dh,0C3h,0CDh,06Eh,0C3h,0CDh,06Fh,0C3h,0CDh,070h,0C3h
        db 0CDh,071h,0C3h,0CDh,072h,0C3h,0CDh,073h,0C3h,0CDh,074h,0C3h,0CDh,075h,0C3h,0CDh
        db 076h,0C3h,0CDh,077h,0C3h,0CDh,078h,0C3h,0CDh,079h,0C3h,0CDh,07Ah,0C3h,0CDh,07Bh
        db 0C3h,0CDh,07Ch,0C3h,0CDh,07Dh,0C3h,0CDh,07Eh,0C3h,0CDh,07Fh,0C3h,0CDh,080h,0C3h
        db 0CDh,081h,0C3h,0CDh,082h,0C3h,0CDh,083h,0C3h,0CDh,084h,0C3h,0CDh,085h,0C3h,0CDh
        db 086h,0C3h,0CDh,087h,0C3h,0CDh,088h,0C3h,0CDh,089h,0C3h,0CDh,08Ah,0C3h,0CDh,08Bh
        db 0C3h,0CDh,08Ch,0C3h,0CDh,08Dh,0C3h,0CDh,08Eh,0C3h,0CDh,08Fh,0C3h,0CDh,090h,0C3h
        db 0CDh,091h,0C3h,0CDh,092h,0C3h,0CDh,093h,0C3h,0CDh,094h,0C3h,0CDh,095h,0C3h,0CDh
        db 096h,0C3h,0CDh,097h,0C3h,0CDh,098h,0C3h,0CDh,099h,0C3h,0CDh,09Ah,0C3h,0CDh,09Bh
        db 0C3h,0CDh,09Ch,0C3h,0CDh,09Dh,0C3h,0CDh,09Eh,0C3h,0CDh,09Fh,0C3h,0CDh,0A0h,0C3h
        db 0CDh,0A1h,0C3h,0CDh,0A2h,0C3h,0CDh,0A3h,0C3h,0CDh,0A4h,0C3h,0CDh,0A5h,0C3h,0CDh
        db 0A6h,0C3h,0CDh,0A7h,0C3h,0CDh,0A8h,0C3h,0CDh,0A9h,0C3h,0CDh,0AAh,0C3h,0CDh,0ABh
        db 0C3h,0CDh,0ACh,0C3h,0CDh,0ADh,0C3h,0CDh,0AEh,0C3h,0CDh,0AFh,0C3h,0CDh,0B0h,0C3h
        db 0CDh,0B1h,0C3h,0CDh,0B2h,0C3h,0CDh,0B3h,0C3h,0CDh,0B4h,0C3h,0CDh,0B5h,0C3h,0CDh
        db 0B6h,0C3h,0CDh,0B7h,0C3h,0CDh,0B8h,0C3h,0CDh,0B9h,0C3h,0CDh,0BAh,0C3h,0CDh,0BBh
        db 0C3h,0CDh,0BCh,0C3h,0CDh,0BDh,0C3h,0CDh,0BEh,0C3h,0CDh,0BFh,0C3h,0CDh,0C0h,0C3h
        db 0CDh,0C1h,0C3h,0CDh,0C2h,0C3h,0CDh,0C3h,0C3h,0CDh,0C4h,0C3h,0CDh,0C5h,0C3h,0CDh
        db 0C6h,0C3h,0CDh,0C7h,0C3h,0CDh,0C8h,0C3h,0CDh,0C9h,0C3h,0CDh,0CAh,0C3h,0CDh,0CBh
        db 0C3h,0CDh,0CCh,0C3h,0CDh,0CDh,0C3h,0CDh,0CEh,0C3h,0CDh,0CFh,0C3h,0CDh,0D0h,0C3h
        db 0CDh,0D1h,0C3h,0CDh,0D2h,0C3h,0CDh,0D3h,0C3h,0CDh,0D4h,0C3h,0CDh,0D5h,0C3h,0CDh
        db 0D6h,0C3h,0CDh,0D7h,0C3h,0CDh,0D8h,0C3h,0CDh,0D9h,0C3h,0CDh,0DAh,0C3h,0CDh,0DBh
        db 0C3h,0CDh,0DCh,0C3h,0CDh,0DDh,0C3h,0CDh,0DEh,0C3h,0CDh,0DFh,0C3h,0CDh,0E0h,0C3h
        db 0CDh,0E1h,0C3h,0CDh,0E2h,0C3h,0CDh,0E3h,0C3h,0CDh,0E4h,0C3h,0CDh,0E5h,0C3h,0CDh
        db 0E6h,0C3h,0CDh,0E7h,0C3h,0CDh,0E8h,0C3h,0CDh,0E9h,0C3h,0CDh,0EAh,0C3h,0CDh,0EBh
        db 0C3h,0CDh,0ECh,0C3h,0CDh,0EDh,0C3h,0CDh,0EEh,0C3h,0CDh,0EFh,0C3h,0CDh,0F0h,0C3h
        db 0CDh,0F1h,0C3h,0CDh,0F2h,0C3h,0CDh,0F3h,0C3h,0CDh,0F4h,0C3h,0CDh,0F5h,0C3h,0CDh
        db 0F6h,0C3h,0CDh,0F7h,0C3h,0CDh,0F8h,0C3h,0CDh,0F9h,0C3h,0CDh,0FAh,0C3h,0CDh,0FBh
        db 0C3h,0CDh,0FCh,0C3h,0CDh,0FDh,0C3h,0CDh,0FEh,0C3h,0CDh,0FFh,0C3h,00h,00h
;-----------------------------------------------------------------------------
; FillRectList                                   132400  97 PC, low confidence
; Fills each rectangle of a list with its colour
;-----------------------------------------------------------------------------
FillRectList:
        push ebx
        push esi
        push edi
        push ebp
        mov ebx, dword [byte esp+014h]
        mov edi, dword [byte esp+018h]
        mov ebp, dword [byte esp+01Ch]
        mov edx, dword [byte esp+020h]
        xor esi, esi
        test edx, edx
        jle short .2
.1:
        mov ecx, dword [byte esp+024h]
        mov eax, dword [edi]
        mov edx, dword [ebx]
        push ecx
        sub eax, edx
        push byte 1
        inc eax
        push eax
        push ebp
        push edx
        add ebx, byte 4
        add edi, byte 4
        call FillRect
        add esp, byte 14h
        inc esi
        mov eax, dword [byte esp+020h]
        inc ebp
        cmp esi, eax
        jl short .1
.2:
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
