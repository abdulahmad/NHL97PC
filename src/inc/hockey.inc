; NHL 97 PC: common include of every src/ file (the PC analogue of the Genesis stubinc includes).
; Only equates and macros: nothing here emits bytes, so adding a name never moves code.
%include "x86enc.inc"     ; LD op, dst, src: load-form reg,reg encodings

; VERSION: 10 builds the retail NHL 97 (1.0) HOCKEY.EXE, 11 the patch 1.1 one (./build.sh 11). Code and data that 1.1
; changed sit in %if VERSION = 11 / %else / %endif blocks; everything else is shared.
%ifndef VERSION
%define VERSION 10
%endif
