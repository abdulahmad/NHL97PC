; CD-ROM: CdOpenFile, CdOpenStream, CdHandleEntry, CdCloseFile, CdReadSectors and 12 more.
bits 32
%include "hockey.inc"
section s_105421 progbits alloc exec nowrite align=1
extern AllocMemBlock, bcopy, CdBufferAddr, CdBufferAllocated, CdBufferSegment, CdBufferSelector, CdDirEntryBuf, CdDirSearch
extern CdDriveCount, CdDriveLetter, CdFileBuffer, CdFileHandle, CdFileMode, CdFilePos, CdFileSize, CdFileStart
extern CdFileTable, CdReadResult, CdReadSector, CdRegEax, CdRegEbx, CdRegEdi, CdRegEdx, CdRegEs
extern CdRegFlags, CdRegs, CdRegSegs, CdRequestSegment, CdRequestSelector, CdSectorSize, CdStreamSpeed, DosCloseFile
extern DosOpenFile, DosReadFile, DosSeekFile, FreeMemBlock, int386_, int386x_, memset_, segread_
extern str_CDROMBUFFER, str_CDROMDATA, strncpy_, toupper_, WaitTicks
global CdOpenFile, CdOpenStream, CdHandleEntry, CdCloseFile, CdReadSectors, CdRead, CdSeekSectors, CdSeek
global CdFindFile, DriveLetterIndex, IsCdDrive, AllocCdBuffer, DetectMscdex, DetectMscdex_1FC, CdDeviceStatus, CdReadLong
global CdSeekCmd, CdDirEntry
        db 00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; CdOpenFile                                     105430  97 PC, low confidence
; Opens a file on the CD
;-----------------------------------------------------------------------------
CdOpenFile:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, 100h
        mov ebp, dword [dword esp+0118h]
        mov edi, dword [dword esp+0120h]
        mov eax, dword [dword esp+011Ch]
        mov dword [byte ebp+00h], 0
        mov dword [eax], 0
        mov dword [edi], 0
        mov esi, 1
        mov edx, dword [CdDriveCount]
        mov eax, 24h
        test edx, edx
        je short .2
.1:
        add eax, byte 24h
        inc esi
        cmp eax, 480h
        jge short .2
        cmp dword [dword eax+CdFileMode], byte 0
        jne short .1
.2:
        push dword 100h
        mov ecx, dword [dword esp+0118h]
        push ecx
        lea eax, [byte esp+08h]
        push eax
        call CdFindFile
        add esp, byte 0Ch
        mov eax, esp
        push eax
        call DriveLetterIndex
        add esp, byte 4
        push eax
        mov ebx, eax
        call IsCdDrive
        add esp, byte 4
        test eax, eax
        je near .6
        push byte 0
        push ebx
        lea ebx, [nosplit esi*8+00h]
        call AllocCdBuffer
        add ebx, esi
        mov eax, CdFileTable
        shl ebx, 2
        add esp, byte 8
        add eax, ebx
        push edi
        add eax, byte 20h
        push eax
        lea eax, [byte esp+08h]
        push eax
        call CdDirEntry
        mov eax, dword [edi]
        add esp, byte 0Ch
        test eax, eax
        je short .6
        xor eax, eax
        mov dword [dword ebx+CdFileSize], eax
        mov ecx, 1
        mov dword [dword ebx+CdFilePos], eax
        mov dword [dword ebx+CdFileMode], ecx
        mov eax, dword [CdSectorSize]
        mov edx, dword [dword esp+0124h]
        mov dword [dword ebx+CdFileStart], eax
        mov ecx, esp
        mov dword [edx], eax
        mov eax, esp
.3:
        mov edx, eax
        mov bl, byte [edx]
        inc eax
        test bl, bl
        je short .5
        mov bh, byte [eax]
        cmp bh, 2Fh
        je short .4
        cmp bh, 3Ah
        jne short .3
.4:
        lea ecx, [byte eax+01h]
        jmp short .3
.5:
        lea eax, [nosplit esi*8+00h]
        add eax, esi
        mov ebx, 0Ch
        shl eax, 2
        mov edx, ecx
        add eax, CdFileTable
        call strncpy_
        jmp short .7
.6:
        mov edx, dword [dword esp+0128h]
        push edx
        push edi
        mov ebx, dword [dword esp+0124h]
        push ebx
        lea ebx, [nosplit esi*8+00h]
        add ebx, esi
        mov eax, CdFileTable
        shl ebx, 2
        add eax, ebx
        add eax, byte 10h
        push eax
        mov ecx, dword [dword esp+0124h]
        push ecx
        call DosOpenFile
        add esp, byte 14h
        mov eax, dword [dword esp+011Ch]
        mov eax, dword [eax]
        mov edi, 2
        mov dword [dword ebx+CdFileSize], eax
        mov eax, dword [dword esp+0124h]
        mov dword [dword ebx+CdFileMode], edi
        mov dword [eax], 1
.7:
        xor eax, eax
        mov dword [byte ebp+00h], esi
        add esp, 100h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; CdOpenStream                                   1055D4  97 PC, low confidence
; Opens a stream on the CD
;-----------------------------------------------------------------------------
CdOpenStream:
        push ebx
        push esi
        push edi
        push byte 1
        mov edx, dword [byte esp+024h]
        push edx
        mov ebx, dword [byte esp+024h]
        push ebx
        mov ecx, dword [byte esp+024h]
        push ecx
        mov esi, dword [byte esp+024h]
        push esi
        mov edi, dword [byte esp+024h]
        push edi
        call CdOpenFile
        add esp, byte 18h
        pop edi
        pop esi
        pop ebx
        ret
        db 08Bh,0C0h
        push ebx
        push esi
        push edi
        push byte 0
        mov edx, dword [byte esp+024h]
        push edx
        mov ebx, dword [byte esp+024h]
        push ebx
        mov ecx, dword [byte esp+024h]
        push ecx
        mov esi, dword [byte esp+024h]
        push esi
        mov edi, dword [byte esp+024h]
        push edi
        call CdOpenFile
        add esp, byte 18h
        pop edi
        pop esi
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; CdHandleEntry                                  10562C  97 PC, low confidence
; Returns the entry of a CD file handle
;-----------------------------------------------------------------------------
CdHandleEntry:
        mov edx, dword [byte esp+04h]
        lea eax, [nosplit edx*8+00h]
        add eax, edx
        shl eax, 2
        add eax, CdFileTable
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; CdCloseFile                                    105644  97 PC, low confidence
; Closes a CD file
;-----------------------------------------------------------------------------
CdCloseFile:
        push ebx
        mov edx, dword [byte esp+08h]
        lea eax, [nosplit edx*8+00h]
        add eax, edx
        shl eax, 2
        cmp dword [dword eax+CdFileMode], byte 2
        jne short .1
        mov ebx, dword [dword eax+CdFileHandle]
        push ebx
        call DosCloseFile
        add esp, byte 4
.1:
        mov edx, dword [byte esp+08h]
        lea eax, [nosplit edx*8+00h]
        add eax, edx
        xor ecx, ecx
        mov dword [nosplit eax*4+CdFileMode], ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; CdReadSectors                                  105688  97 PC, low confidence
; Reads sectors of a CD file
;-----------------------------------------------------------------------------
CdReadSectors:
        push ebx
        push esi
        push edi
        push ebp
        mov edx, dword [byte esp+018h]
        mov esi, dword [byte esp+01Ch]
        mov ebx, dword [byte esp+014h]
        lea eax, [nosplit ebx*8+00h]
        add ebx, eax
        shl ebx, 2
        cmp dword [dword ebx+CdFileMode], byte 2
        jne short .1
        push esi
        push edx
        mov edx, dword [dword ebx+CdFileHandle]
        push edx
        call DosReadFile
        add esp, byte 0Ch
        jmp short .2
.1:
        push esi
        mov edi, dword [dword ebx+CdFilePos]
        push edi
        mov ebp, dword [dword ebx+CdFileBuffer]
        push ebp
        push edx
        call CdReadLong
        mov eax, dword [dword ebx+CdFilePos]
        add eax, esi
        add esp, byte 10h
        mov dword [dword ebx+CdFilePos], eax
.2:
        mov eax, esi
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; CdRead                                         1056F0  97 PC, low confidence
; Reads from a CD file
;-----------------------------------------------------------------------------
CdRead:
        push ebx
        push byte 1
        mov edx, dword [byte esp+014h]
        push edx
        mov ebx, dword [byte esp+014h]
        push ebx
        mov ecx, dword [byte esp+014h]
        push ecx
        call CdReadSectors
        add esp, byte 10h
        pop ebx
        ret
        push ebx
        push byte 0
        mov edx, dword [byte esp+014h]
        push edx
        mov ebx, dword [byte esp+014h]
        push ebx
        mov ecx, dword [byte esp+014h]
        push ecx
        call CdReadSectors
        add esp, byte 10h
        pop ebx
        ret
;-----------------------------------------------------------------------------
; CdSeekSectors                                  105728  97 PC, low confidence
; Seeks in a CD file
;-----------------------------------------------------------------------------
CdSeekSectors:
        push ebx
        push edi
        push ebp
        mov edx, dword [byte esp+014h]
        mov eax, dword [byte esp+010h]
        lea ebx, [nosplit eax*8+00h]
        add ebx, eax
        shl ebx, 2
        cmp dword [dword ebx+CdFileMode], byte 2
        jne short .1
        push edx
        mov ebp, dword [dword ebx+CdFileHandle]
        push ebp
        call DosSeekFile
        add esp, byte 8
        xor eax, eax
        pop ebp
        pop edi
        pop ebx
        ret
.1:
        mov eax, dword [dword ebx+CdFileSize]
        add eax, edx
        push eax
        mov edi, dword [dword ebx+CdFileBuffer]
        push edi
        mov dword [dword ebx+CdFilePos], eax
        call CdSeekCmd
        mov eax, dword [dword ebx+CdFilePos]
        add esp, byte 8
        and eax, 7FFh
        pop ebp
        pop edi
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; CdSeek                                         10578C  97 PC, low confidence
; Seeks in a CD file and waits
;-----------------------------------------------------------------------------
CdSeek:
        push ebx
        push byte 1
        mov edx, dword [byte esp+010h]
        push edx
        mov ebx, dword [byte esp+010h]
        push ebx
        call CdSeekSectors
        add esp, byte 0Ch
        pop ebx
        ret
        db 090h
        push ebx
        push byte 0
        mov edx, dword [byte esp+010h]
        push edx
        mov ebx, dword [byte esp+010h]
        push ebx
        call CdSeekSectors
        add esp, byte 0Ch
        pop ebx
        ret
        db 00h,00h,00h,00h,00h
;-----------------------------------------------------------------------------
; CdFindFile                                     1057C0  97 PC, low confidence
; Finds a file on the CD
;-----------------------------------------------------------------------------
CdFindFile:
        push ebx
        mov ecx, dword [byte esp+08h]
        mov edx, dword [byte esp+0Ch]
        mov ebx, dword [byte esp+010h]
        mov eax, ecx
        call CdDirSearch
        mov edx, eax
        test eax, eax
        je short .1
        cmp byte [byte ecx+02h], 5Ch
        jne short .1
        mov byte [byte ecx+02h], 2Fh
.1:
        mov eax, edx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; DriveLetterIndex                               1057E8  97 PC, low confidence
; Returns the drive number of a path's drive letter
;-----------------------------------------------------------------------------
DriveLetterIndex:
        mov eax, dword [byte esp+04h]
        cmp byte [byte eax+01h], 3Ah
        je short .1
        mov eax, 0FFFFFFFFh
        ret
.1:
        mov al, byte [eax]
        and eax, 0FFh
        call toupper_
        sub eax, byte 41h
        ret
;-----------------------------------------------------------------------------
; IsCdDrive                                      105808  97 PC, low confidence
; Returns whether a drive is a CD drive (MSCDEX)
;-----------------------------------------------------------------------------
IsCdDrive:
        push ebx
        sub esp, byte 38h
        cmp dword [CdStreamSpeed], byte 0
        jne short .1
        mov edx, 150Bh
        mov eax, dword [byte esp+040h]
        lea ebx, [byte esp+01Ch]
        mov word [esp], dx
        mov word [byte esp+08h], ax
        mov edx, esp
        mov eax, 2Fh
        call int386_
        cmp word [byte esp+01Ch], byte 0
        je short .1
        cmp word [byte esp+020h], 0ADADh
        jne short .1
        mov eax, 1
        add esp, byte 38h
        pop ebx
        ret
.1:
        xor eax, eax
        add esp, byte 38h
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; AllocCdBuffer                                  10585C  97 PC, low confidence
; Allocates the CD transfer buffer
;-----------------------------------------------------------------------------
AllocCdBuffer:
        push ebx
        cmp dword [CdBufferAllocated], byte 0
        jne short .1
        push dword 220h
        push dword 200h
        mov ebx, 1
        push str_CDROMDATA
        mov dword [CdBufferAllocated], ebx
        call AllocMemBlock
        add esp, byte 0Ch
        push dword 220h
        mov dword [CdDriveLetter], eax
        push dword 10000h
        shr eax, 4
        push str_CDROMBUFFER
        mov dword [CdRequestSelector], eax
        call AllocMemBlock
        mov dword [CdRequestSegment], eax
        shr eax, 4
        add esp, byte 0Ch
        mov dword [CdBufferSegment], eax
.1:
        mov eax, dword [byte esp+08h]
        mov dword [CdBufferSelector], eax
        mov eax, dword [byte esp+0Ch]
        sar eax, 0Bh
        mov dword [CdBufferAddr], eax
        pop ebx
        ret
        push ebx
        push esi
        cmp dword [CdBufferAllocated], byte 0
        je short .2
        mov ecx, dword [CdDriveLetter]
        xor ebx, ebx
        push ecx
        mov dword [CdBufferAllocated], ebx
        call FreeMemBlock
        add esp, byte 4
        mov esi, dword [CdRequestSegment]
        push esi
        call FreeMemBlock
        add esp, byte 4
.2:
        pop esi
        pop ebx
        ret
;-----------------------------------------------------------------------------
; DetectMscdex                                   105904  97 PC, low confidence
; Finds MSCDEX and the CD drives
;-----------------------------------------------------------------------------
DetectMscdex:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 44h
        mov edx, 1501h
        mov ax, word [CdBufferSegment]
        xor ebx, ebx
        xor ecx, ecx
        mov dword [CdRegEdx], edx
        mov dword [CdRegEbx], ebx
        mov word [CdRegEs], ax
        lea eax, [byte esp+038h]
        mov edx, 300h
        mov ebx, 2Fh
        call segread_
        mov eax, CdRegs
        mov word [byte esp+01Ch], dx
        mov word [byte esp+020h], bx
        mov word [byte esp+024h], cx
        mov ecx, CdRegs
        mov edx, ds
        mov ebx, esp
        mov eax, 31h
        mov word [byte esp+038h], dx
        mov dword [byte esp+030h], ecx
        lea ecx, [byte esp+038h]
        lea edx, [byte esp+01Ch]
        call int386x_
        mov eax, dword [CdRequestSegment]
        xor edx, edx
        mov dx, word [byte eax+03h]
        shl edx, 4
        mov ax, word [byte eax+01h]
        and eax, 0FFFFh
        add edx, eax
        lea ebx, [byte edx+0Ah]
        xor eax, eax
        mov cl, byte [ebx]
        mov edx, ebx
        cmp cl, 20h
        je short .2
.1:
        mov ebx, dword [CdDriveLetter]
        inc edx
        lea ecx, [ebx+eax]
        mov bl, byte [byte edx-01h]
        inc eax
        mov byte [ecx], bl
        cmp eax, byte 8
        jge short .2
        cmp byte [edx], 20h
        jne short .1
.2:
        mov esi, 3D02h
        mov ebp, CdRegs
        lea ecx, [byte esp+038h]
        mov edx, dword [CdDriveLetter]
        mov ebx, esp
        xor edi, edi
        mov byte [edx+eax], 0
        mov ax, word [CdRequestSelector]
        mov dword [CdRegEdx], esi
        mov dword [CdRegEdi], edi
        mov edx, ds
        mov esi, 300h
        mov word [CdRegSegs], ax
        lea eax, [byte esp+038h]
        mov edi, 21h
        call segread_
        xor eax, eax
        mov word [byte esp+01Ch], si
        mov word [byte esp+024h], ax
        mov eax, CdRegs
        mov word [byte esp+020h], di
        mov eax, 31h
        mov word [byte esp+038h], dx
        lea edx, [byte esp+01Ch]
        mov dword [byte esp+030h], ebp
        call int386x_
        test byte [CdRegFlags], 1
        je short .3
        xor eax, eax
        jmp near DetectMscdex_1FC
.3:
        mov ebx, 32h
        mov eax, dword [CdDriveLetter]
        mov esi, dword [CdRegEdx]
        xor edx, edx
        mov byte [eax], 6
        mov eax, ebp
        xor ecx, ecx
        call memset_
        mov eax, 4402h
        mov edx, 5
        mov dword [CdRegEbx], esi
        xor ebx, ebx
        mov dword [CdRegEdx], eax
        mov dword [CdRegEax], edx
        mov dword [CdRegEdi], ebx
        mov ax, word [CdRequestSelector]
        mov edx, 300h
        mov word [CdRegSegs], ax
        lea eax, [byte esp+038h]
        mov ebx, esp
        call segread_
        mov word [byte esp+01Ch], dx
        mov word [byte esp+020h], di
        mov word [byte esp+024h], cx
        mov eax, ebp
        lea ecx, [byte esp+038h]
        mov edx, ds
        mov edi, 3E00h
        mov eax, 31h
        mov word [byte esp+038h], dx
        lea edx, [byte esp+01Ch]
        mov dword [byte esp+030h], ebp
        call int386x_
        mov ecx, dword [CdDriveLetter]
        mov ebx, esp
        lea edx, [byte esp+01Ch]
        mov ecx, dword [byte ecx+01h]
        xor eax, eax
        and ecx, 80h
        mov word [byte esp+01Ch], di
        mov word [byte esp+024h], ax
        mov eax, 21h
        mov word [byte esp+020h], si
        call int386_
        mov eax, ecx
DetectMscdex_1FC:
        add esp, byte 44h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
;-----------------------------------------------------------------------------
; CdDeviceStatus                                 105B08  97 PC, low confidence
; Asks the CD driver for the device status
;-----------------------------------------------------------------------------
CdDeviceStatus:
        push ebx
        sub esp, byte 44h
        mov eax, dword [CdDriveLetter]
        mov byte [eax], 1Bh
        mov byte [byte eax+01h], 0
        mov byte [byte eax+02h], 82h
        mov byte [byte eax+0Dh], 0
        mov word [byte eax+0Eh], 0
        mov word [byte eax+010h], 0
        mov byte [byte eax+018h], 0
        mov byte [byte eax+019h], 0
        mov byte [byte eax+01Ah], 0
        mov edx, dword [byte esp+04Ch]
        mov word [byte eax+03h], 0
        mov dword [byte eax+014h], edx
        mov edx, dword [byte esp+050h]
        mov ebx, 32h
        mov word [byte eax+012h], dx
        mov eax, CdRegs
        xor edx, edx
        xor ecx, ecx
        call memset_
        mov edx, 1510h
        mov eax, dword [CdBufferSelector]
        xor ebx, ebx
        mov dword [CdRegEdx], edx
        mov dword [CdRegEbx], ebx
        mov dword [CdRegEax], eax
        mov ax, word [CdRequestSelector]
        mov edx, 300h
        mov word [CdRegEs], ax
        lea eax, [byte esp+038h]
        mov ebx, 2Fh
        call segread_
        mov eax, CdRegs
        mov word [byte esp+01Ch], dx
        mov word [byte esp+020h], bx
        mov word [byte esp+024h], cx
        mov ecx, CdRegs
        mov edx, ds
        mov ebx, esp
        mov eax, 31h
        mov word [byte esp+038h], dx
        mov dword [byte esp+030h], ecx
        lea ecx, [byte esp+038h]
        lea edx, [byte esp+01Ch]
        call int386x_
        add esp, byte 44h
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; CdReadLong                                     105BDC  97 PC, low confidence
; Reads sectors with the CD driver
;-----------------------------------------------------------------------------
CdReadLong:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 48h
        mov ebp, dword [byte esp+064h]
        mov eax, ebp
        mov edi, 5
        sar eax, 0Bh
        and ebp, 7FFh
        mov dword [byte esp+044h], eax
.1:
        mov esi, dword [CdDriveLetter]
        mov ax, word [CdBufferSegment]
        mov edx, dword [byte esp+044h]
        mov word [byte esi+010h], ax
        mov eax, dword [byte esp+060h]
        add eax, edx
        mov byte [esi], 1Bh
        mov dword [CdReadSector], eax
        mov dword [byte esi+014h], eax
        mov eax, dword [byte esp+068h]
        mov byte [byte esi+01h], 0
        add eax, ebp
        mov byte [byte esi+02h], 80h
        add eax, 7FFh
        mov byte [byte esi+0Dh], 0
        sar eax, 0Bh
        mov word [byte esi+012h], ax
        mov eax, dword [byte esi+010h]
        mov word [byte esi+0Eh], 0
        sar eax, 10h
        mov dx, word [byte esi+012h]
        mov dword [CdReadResult], eax
        test dx, dx
        je near .3
        mov byte [byte esi+018h], 0
        mov ebx, 32h
        mov byte [byte esi+019h], 0
        mov eax, CdRegs
        mov byte [byte esi+01Ah], 0
        xor edx, edx
        mov word [byte esi+03h], 0
        call memset_
        xor ecx, ecx
        mov ebx, 1510h
        mov eax, dword [CdBufferSelector]
        mov dword [CdRegEbx], ecx
        mov edx, ds
        mov ecx, 2Fh
        mov dword [CdRegEax], eax
        mov ax, word [CdRequestSelector]
        mov dword [CdRegEdx], ebx
        mov word [CdRegEs], ax
        lea eax, [byte esp+038h]
        mov ebx, 300h
        call segread_
        mov word [esp], bx
        mov word [byte esp+04h], cx
        xor eax, eax
        lea ecx, [byte esp+038h]
        mov word [byte esp+08h], ax
        mov eax, CdRegs
        lea ebx, [byte esp+01Ch]
        mov eax, CdRegs
        mov word [byte esp+038h], dx
        mov edx, esp
        mov dword [byte esp+014h], eax
        mov eax, 31h
        call int386x_
        mov eax, dword [byte esi+01h]
        sar eax, 10h
        test ah, 80h
        je short .2
        mov eax, edi
        dec edi
        test eax, eax
        jle near .1
        push byte 5
        call WaitTicks
        add esp, byte 4
        jmp near .1
.2:
        mov edx, dword [byte esp+068h]
        push edx
        mov ebx, dword [byte esp+060h]
        mov eax, dword [CdRequestSegment]
        push ebx
        add ebp, eax
        push ebp
        call bcopy
        mov ecx, dword [CdBufferAddr]
        add esp, byte 0Ch
        test ecx, ecx
        je short .3
        mov eax, dword [byte esi+010h]
        mov ebp, dword [byte esi+014h]
        sar eax, 10h
        push ecx
        add eax, ebp
        push eax
        call CdDeviceStatus
        add esp, byte 8
.3:
        add esp, byte 48h
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; CdSeekCmd                                      105D5C  97 PC, low confidence
; Sends a seek to the CD driver
;-----------------------------------------------------------------------------
CdSeekCmd:
        push ebx
        push esi
        push edi
        push ebp
        sub esp, byte 44h
        mov ebp, dword [byte esp+05Ch]
        mov edi, 5
        sar ebp, 0Bh
.1:
        mov esi, dword [CdDriveLetter]
        mov byte [esi], 1Bh
        mov byte [byte esi+01h], 0
        mov byte [byte esi+02h], 83h
        mov byte [byte esi+0Dh], 0
        mov word [byte esi+0Eh], 0
        mov word [byte esi+010h], 0
        mov word [byte esi+012h], 0
        mov eax, dword [byte esp+058h]
        mov byte [byte esi+018h], 0
        mov ebx, 32h
        mov byte [byte esi+019h], 0
        xor edx, edx
        mov byte [byte esi+01Ah], 0
        add eax, ebp
        xor ecx, ecx
        mov dword [byte esi+014h], eax
        mov eax, CdRegs
        mov word [byte esi+03h], 0
        call memset_
        mov edx, 1510h
        mov eax, dword [CdBufferSelector]
        xor ebx, ebx
        mov dword [CdRegEdx], edx
        mov dword [CdRegEbx], ebx
        mov dword [CdRegEax], eax
        mov ax, word [CdRequestSelector]
        mov edx, 300h
        mov word [CdRegEs], ax
        lea eax, [byte esp+038h]
        mov ebx, 2Fh
        call segread_
        mov eax, CdRegs
        mov word [byte esp+01Ch], dx
        mov word [byte esp+020h], bx
        mov word [byte esp+024h], cx
        mov ecx, CdRegs
        mov edx, ds
        mov ebx, esp
        mov eax, 31h
        mov word [byte esp+038h], dx
        mov dword [byte esp+030h], ecx
        lea ecx, [byte esp+038h]
        lea edx, [byte esp+01Ch]
        call int386x_
        mov eax, dword [byte esi+01h]
        sar eax, 10h
        test ah, 80h
        je near DetectMscdex_1FC
        mov eax, edi
        dec edi
        test eax, eax
        jle near .1
        push byte 5
        call WaitTicks
        add esp, byte 4
        jmp near .1
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; CdDirEntry                                     105E64  97 PC, low confidence
; Reads the directory entry of a CD file
;-----------------------------------------------------------------------------
CdDirEntry:
        push ebx
        push esi
        push edi
        sub esp, byte 44h
        mov esi, dword [byte esp+054h]
        cmp byte [byte esi+01h], 3Ah
        jne short .1
        add esi, byte 2
.1:
        mov edi, dword [CdRequestSegment]
        mov ebx, 32h
        push edi
.2:
        mov al, byte [esi]
        mov byte [edi], al
        cmp al, 0
        je short .3
        mov al, byte [byte esi+01h]
        add esi, byte 2
        mov byte [byte edi+01h], al
        add edi, byte 2
        cmp al, 0
        jne short .2
.3:
        pop edi
        xor edx, edx
        xor ecx, ecx
        mov eax, CdRegs
        mov esi, CdRegs
        call memset_
        mov edx, 150Fh
        mov eax, dword [CdBufferSelector]
        xor ebx, ebx
        mov dword [CdRegEdx], edx
        mov dword [CdRegEbx], ebx
        mov dword [CdRegEax], eax
        mov ax, word [CdBufferSegment]
        mov dword [CdRegs], ebx
        mov word [CdRegEs], ax
        mov eax, dword [CdRequestSelector]
        mov edx, 300h
        mov dword [CdDirEntryBuf], eax
        lea eax, [byte esp+038h]
        mov ebx, 2Fh
        call segread_
        mov eax, CdRegs
        mov word [esp], dx
        mov word [byte esp+04h], bx
        mov word [byte esp+08h], cx
        lea ecx, [byte esp+038h]
        mov edx, ds
        lea ebx, [byte esp+01Ch]
        mov eax, 31h
        mov word [byte esp+038h], dx
        mov edx, esp
        mov dword [byte esp+014h], esi
        call int386x_
        test byte [CdRegFlags], 1
        je short .4
        mov eax, dword [byte esp+058h]
        mov dword [eax], 0
        mov eax, dword [byte esp+05Ch]
        mov dword [eax], 0
        jmp short .5
.4:
        mov edx, dword [CdDriveLetter]
        mov ebx, dword [byte esp+058h]
        mov eax, dword [byte edx+02h]
        mov dword [ebx], eax
        mov eax, dword [byte edx+0Ah]
        mov edx, dword [byte esp+05Ch]
        mov dword [edx], eax
.5:
        add esp, byte 44h
        pop edi
        pop esi
        pop ebx
        ret
        ret
