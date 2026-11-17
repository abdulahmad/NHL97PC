; Sound: SpeechBufferSize.
bits 32
%include "hockey.inc"
section s_10A856 progbits alloc exec nowrite align=1
global SpeechBufferSize
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; SpeechBufferSize                               10A860  97 PC, low confidence
; Returns the size of one speech buffer header (208h)
;-----------------------------------------------------------------------------
SpeechBufferSize:
        mov eax, 208h
        ret
