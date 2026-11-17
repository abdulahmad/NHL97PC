; Data files: paths, loading from files and libraries, start-up data and the global settings file.
bits 32
%include "hockey.inc"
section s_4AB70 progbits alloc exec nowrite align=1
extern _dos_close_, _dos_open_, ArtArchiveIds, ArtArchivePaths, ArtArchiveSizes, AudioOptions, ClearLinkAbort, CurrentArchiveName
extern DataDirPath, DataFilePath, DetectCPU, DirPathTable, DosCloseFile, DosFileInfo, DosWriteFile, FreeMemBlock
extern GameOptionFlags, GameSettings, GlobalSetData, GlobalSetName, GlobalSetPad, GlobalSetVersion, LinkGameActive, LinkSettings
extern LoadDataFileErr, LoadDataFileNoErr, LoadFileAlloc, LoadFileAllocQuiet, LoadFileInto, LoadFileIntoQuiet, LoadFileToBlockPlain, LoadFileToBlockShared
extern LoadResourceBlock, LoadResourceBlockShared, LoadResourceData, LoadResourceDataShared, memcpy_, MusicStreamTick, OpenArtArchive, OpenArtArchiveErr
extern openhandle, OpenResourceArchive, printf_, ReadWholeFile, ServiceIdle, StartupFlag, str_BIGFILES, str_DIRECTORYS
extern str_Punct_MakeDataPath, str_S, str_X_SetArtArchive, strcat_, stricmp_, strlen_, strncpy_
global MakeArtPathJumpTable, MakeDataPathKindJumpTable, MakeDataPath, MakeDataPath_41, MakeDataPath_49, MakeDataPath_4F, MakeDataPath_62, MakeDataPath_111
global MakeDataPath_119, MakeDataPath_11F, MakeDataPath_132, MakeDataPathJumpTable, MakeDirPath, MakeDirPathJumpTable, MakeDirPath_177, LoadDataFileHandle
global LoadDataFileLib, LoadDataFile, LoadDataFileFlag0, OpenDataLibrary, SetArtArchive, LoadStartupData, WriteGlobalSet
MakeArtPathJumpTable:                           ; jump table for the switch cases of MakeDataPath
        dd MakeDataPath_62
        dd MakeDataPath_41
        dd MakeDataPath_49
        dd MakeDataPath_4F
MakeDataPathKindJumpTable:                      ; jump table for the switch cases of MakeDataPath
        dd MakeDataPath_132
        dd MakeDataPath_111
        dd MakeDataPath_119
        dd MakeDataPath_11F
;-----------------------------------------------------------------------------
; MakeDataPath                                 4AB90  96 PC, medium confidence
; (out, file id): the path of a game data file: the language prefix (optflags & 3) where the file has one,
; its directory (DirPathTable) and name (the name table at str_X_SetArtArchive, 15h-byte entries)
;-----------------------------------------------------------------------------
MakeDataPath:
        push ebx
        push ecx
        push esi
        mov ebx, eax
        mov ecx, edx
        imul esi, edx, byte 15h
        mov byte [eax], 0
        mov edx, dword [GameSettings]
        and edx, byte 3
        mov eax, edx
        add esi, str_X_SetArtArchive
        shl eax, 2
        cmp dword [byte esi+0Dh], byte 0
        jge near MakeDataPath_62.10
        imul ecx, dword [byte esi+0Dh], byte 0FFFFFFEBh
        add ecx, ArtArchivePaths
        cmp edx, byte 3
        ja short MakeDataPath_62
        jmp dword [dword cs:eax+MakeArtPathJumpTable]
MakeDataPath_41:
        test byte [byte ecx+011h], 1
.1:
        jne short MakeDataPath_62
        jmp short MakeDataPath_4F.2
MakeDataPath_49:
        test byte [byte ecx+011h], 2
        jmp short MakeDataPath_41.1
MakeDataPath_4F:
        test byte [byte ecx+011h], 4
        jne short MakeDataPath_62
.2:
        mov edx, dword [DirPathTable]
        mov eax, ebx
        call strcat_
MakeDataPath_62:
        mov eax, dword [byte ecx+0Dh]
        test eax, eax
        je short .3
        cmp eax, byte 5
        jg short .3
        imul eax, byte 0Fh
        mov edx, DataDirPath
        add edx, eax
        mov eax, ebx
        call strcat_
        mov edx, str_Punct_MakeDataPath
        mov eax, ebx
        call strcat_
.3:
        mov edx, ecx
        mov eax, ebx
        call strcat_
        xor edx, edx
        jmp short .8
.4:
        lea eax, [ebx+edx]
        cmp byte [eax], 24h
        jne short .7
        test byte [GameSettings], 0Ch
        jne short .5
        mov byte [eax], 45h
.5:
        mov eax, dword [GameSettings]
        and eax, byte 0Ch
        cmp eax, byte 4
        jne short .6
        mov byte [edx+ebx], 46h
.6:
        mov eax, dword [GameSettings]
        and eax, byte 0Ch
        cmp eax, byte 8
        jne short .7
        mov byte [edx+ebx], 47h
.7:
        inc edx
.8:
        mov eax, ebx
        call strlen_
        cmp edx, eax
        jb short .4
        call CurrentArchiveName
        mov ecx, eax
        call ServiceIdle
        mov edx, ebx
        mov eax, ecx
        call stricmp_
        test eax, eax
        je short .9
        push ebx
        call OpenResourceArchive
        add esp, byte 4
.9:
        mov edx, esi
        mov eax, ebx
        mov byte [ebx], 0
        jmp short MakeDataPath_132.14
.10:
        cmp edx, byte 3
        ja short MakeDataPath_132
        jmp dword [dword cs:eax+MakeDataPathKindJumpTable]
MakeDataPath_111:
        test byte [byte esi+011h], 1
.11:
        jne short MakeDataPath_132
        jmp short MakeDataPath_11F.12
MakeDataPath_119:
        test byte [byte esi+011h], 2
        jmp short MakeDataPath_111.11
MakeDataPath_11F:
        test byte [byte esi+011h], 4
        jne short MakeDataPath_132
.12:
        mov edx, dword [DirPathTable]
        mov eax, ebx
        call strcat_
MakeDataPath_132:
        mov eax, dword [byte esi+0Dh]
        test eax, eax
        je short .13
        cmp eax, byte 5
        jg short .13
        imul eax, byte 0Fh
        mov edx, DataDirPath
        add edx, eax
        mov eax, ebx
        call strcat_
        mov edx, str_Punct_MakeDataPath
        mov eax, ebx
        call strcat_
.13:
        test ecx, ecx
        je short .15
        mov edx, esi
        mov eax, ebx
.14:
        call strcat_
.15:
        xor edx, edx
        jmp short .20
.16:
        lea eax, [ebx+edx]
        cmp byte [eax], 24h
        jne short .19
        test byte [GameSettings], 0Ch
        jne short .17
        mov byte [eax], 45h
.17:
        mov eax, dword [GameSettings]
        and eax, byte 0Ch
        cmp eax, byte 4
        jne short .18
        mov byte [edx+ebx], 46h
.18:
        mov eax, dword [GameSettings]
        and eax, byte 0Ch
        cmp eax, byte 8
        jne short .19
        mov byte [edx+ebx], 47h
.19:
        inc edx
.20:
        mov eax, ebx
        call strlen_
        cmp edx, eax
        jb short .16
        pop esi
        pop ecx
        pop ebx
        ret
MakeDataPathJumpTable:                          ; jump table for the switch cases
        dd .6
        dd .1
        dd .3
        dd .4
        push ebx
        push ecx
        mov ebx, eax
        imul edx, byte 15h
        mov byte [eax], 0
        mov eax, dword [GameSettings]
        mov ecx, ArtArchivePaths
        and eax, byte 3
        add ecx, edx
        cmp eax, byte 3
        ja short .6
        jmp dword [nosplit cs:eax*4+MakeDataPathJumpTable]
.1:
        test byte [byte ecx+011h], 1
.2:
        jne short .6
        jmp short .5
.3:
        test byte [byte ecx+011h], 2
        jmp short .2
.4:
        test byte [byte ecx+011h], 4
        jne short .6
.5:
        mov edx, dword [DirPathTable]
        mov eax, ebx
        call strcat_
.6:
        mov eax, dword [byte ecx+0Dh]
        test eax, eax
        je short .7
        cmp eax, byte 5
        jg short .7
        imul eax, byte 0Fh
        mov edx, DataDirPath
        add edx, eax
        mov eax, ebx
        call strcat_
        mov edx, str_Punct_MakeDataPath
        mov eax, ebx
        call strcat_
.7:
        mov edx, ecx
        mov eax, ebx
        call strcat_
        xor ecx, ecx
        jmp short .12
.8:
        lea eax, [ebx+ecx]
        cmp byte [eax], 24h
        jne short .11
        test byte [GameSettings], 0Ch
        jne short .9
        mov byte [eax], 45h
.9:
        mov eax, dword [GameSettings]
        and eax, byte 0Ch
        cmp eax, byte 4
        jne short .10
        mov byte [ecx+ebx], 46h
.10:
        mov eax, dword [GameSettings]
        and eax, byte 0Ch
        cmp eax, byte 8
        jne short .11
        mov byte [ecx+ebx], 47h
.11:
        inc ecx
.12:
        mov eax, ebx
        call strlen_
        cmp ecx, eax
        jb short .8
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; MakeDirPath                                                     4AE14  96 PC
; (out, dir, language): a game directory path (language prefix, directory
; from DirPathTable, backslash)
;-----------------------------------------------------------------------------
MakeDirPath:
        push ecx
        push esi
        mov ecx, eax
        mov esi, edx
        mov byte [eax], 0
        test ebx, ebx
        je short .1
        test byte [GameSettings], 3
        je short .1
        mov edx, dword [DirPathTable]
        call strcat_
.1:
        imul edx, esi, byte 0Fh
        mov eax, ecx
        add edx, DataDirPath
        call strcat_
        mov edx, str_Punct_MakeDataPath
        mov eax, ecx
        call strcat_
        pop esi
        pop ecx
        ret
MakeDirPathJumpTable:                           ; jump table for the switch cases
        dd .7
        dd .2
        dd .4
        dd .5
        push ebx
        push ecx
        push edx
        enter 28h, 0
        mov edx, eax
        mov byte [byte ebp-028h], 0
        call ServiceIdle
        test edx, edx
        jne short .1
        push edx
        jmp near .9
.1:
        imul edx, byte 0FFFFFFEBh
        mov ebx, ArtArchivePaths
        add ebx, edx
        mov edx, dword [GameSettings]
        and edx, byte 3
        cmp edx, byte 3
        ja short .7
        jmp dword [nosplit cs:edx*4+MakeDirPathJumpTable]
.2:
        test byte [byte ebx+011h], 1
.3:
        jne short .7
        jmp short .6
.4:
        test byte [byte ebx+011h], 2
        jmp short .3
.5:
        test byte [byte ebx+011h], 4
        jne short .7
.6:
        lea eax, [byte ebp-028h]
        mov edx, dword [DirPathTable]
        call strcat_
.7:
        mov edx, dword [byte ebx+0Dh]
        test edx, edx
        je short .8
        cmp edx, byte 5
        jg short .8
        imul edx, byte 0Fh
        lea eax, [byte ebp-028h]
        add edx, DataDirPath
        call strcat_
        mov edx, str_Punct_MakeDataPath
        lea eax, [byte ebp-028h]
        call strcat_
.8:
        lea eax, [byte ebp-028h]
        mov edx, ebx
        call strcat_
        call CurrentArchiveName
        lea edx, [byte ebp-028h]
        mov ebx, eax
        call ServiceIdle
        mov eax, ebx
        call stricmp_
        test eax, eax
        je short .10
        lea eax, [byte ebp-028h]
        push eax
.9:
        call OpenResourceArchive
        add esp, byte 4
.10:
        xor edx, edx
        jmp short .15
.11:
        cmp byte [byte edx+ebp-028h], 24h
        jne short .14
        test byte [GameSettings], 0Ch
        jne short .12
        mov byte [byte edx+ebp-028h], 45h
.12:
        mov eax, dword [GameSettings]
        and eax, byte 0Ch
        cmp eax, byte 4
        jne short .13
        mov byte [byte edx+ebp-028h], 46h
.13:
        mov eax, dword [GameSettings]
        and eax, byte 0Ch
        cmp eax, byte 8
        jne short .14
        mov byte [byte edx+ebp-028h], 47h
.14:
        inc edx
.15:
        lea eax, [byte ebp-028h]
        call strlen_
        cmp edx, eax
        jb short .11
        leave
        pop edx
        pop ecx
        pop ebx
        ret
        push ebx
        push ecx
        mov ebx, edx
        mov edx, eax
        mov eax, DataFilePath
        call MakeDataPath
        call ServiceIdle
        push ebx
        push DataFilePath
        call LoadFileAlloc
MakeDirPath_177:
        add esp, byte 8
        mov edx, eax
        call MusicStreamTick
        call ServiceIdle
        mov eax, edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; LoadDataFileHandle                           4AF9F  96 PC, medium confidence
; LoadDataFile returning the loader's handle, for the sound banks
;-----------------------------------------------------------------------------
LoadDataFileHandle:
        push ebx
        push ecx
        mov ebx, edx
        mov edx, eax
        mov eax, DataFilePath
        call MakeDataPath
        call ServiceIdle
        push ebx
        push DataFilePath
        call LoadFileAllocQuiet
        jmp short MakeDirPath_177
        push ebx
        push ecx
        mov ebx, edx
        mov edx, eax
        mov eax, DataFilePath
        call MakeDataPath
        call ServiceIdle
        push ebx
        push DataFilePath
        call LoadFileInto
        jmp short MakeDirPath_177
        push ebx
        push ecx
        mov ebx, edx
        mov edx, eax
        mov eax, DataFilePath
        call MakeDataPath
        call ServiceIdle
        push ebx
        push DataFilePath
        call LoadFileIntoQuiet
        jmp short MakeDirPath_177
        push ebx
        push ecx
        mov ebx, edx
        mov edx, eax
        mov eax, DataFilePath
        call MakeDataPath
        call ServiceIdle
        push ebx
        push DataFilePath
        call LoadFileToBlockShared
        jmp near MakeDirPath_177
        push ebx
        push ecx
        mov ebx, edx
        mov edx, eax
        mov eax, DataFilePath
        call MakeDataPath
        call ServiceIdle
        push ebx
        push DataFilePath
        call LoadFileToBlockPlain
        jmp near MakeDirPath_177
        push ebx
        push ecx
        mov ebx, edx
        mov edx, eax
        mov eax, DataFilePath
        call MakeDataPath
        call ServiceIdle
        push ebx
        push DataFilePath
        call ReadWholeFile
        jmp near MakeDirPath_177
;-----------------------------------------------------------------------------
; LoadDataFileLib                                 4B074  96 PC, low confidence
; LoadDataFile through the other library loader (flag
; 1)
;-----------------------------------------------------------------------------
LoadDataFileLib:
        push ebx
        push ecx
        mov ebx, edx
        mov edx, eax
        mov eax, DataFilePath
        call MakeDataPath
        call ServiceIdle
        push ebx
        push DataFilePath
        call LoadResourceDataShared
        jmp near MakeDirPath_177
        push ebx
        push ecx
        mov ebx, edx
        mov edx, eax
        mov eax, DataFilePath
        call MakeDataPath
        call ServiceIdle
        push ebx
        push DataFilePath
        call LoadResourceData
        jmp near MakeDirPath_177
        push ebx
        push ecx
        mov ebx, edx
        mov edx, eax
        mov eax, DataFilePath
        call MakeDataPath
        call ServiceIdle
        push ebx
        push DataFilePath
        call LoadResourceBlockShared
        jmp near MakeDirPath_177
        push ebx
        push ecx
        mov ebx, edx
        mov edx, eax
        mov eax, DataFilePath
        call MakeDataPath
        call ServiceIdle
        push ebx
        push DataFilePath
        call LoadResourceBlock
        jmp near MakeDirPath_177
;-----------------------------------------------------------------------------
; LoadDataFile                                 4B108  96 PC, medium confidence
; (file id, flags): loads a game data file by id (MakeDataPath, then the
; loader)
;-----------------------------------------------------------------------------
LoadDataFile:
        push ebx
        push ecx
        mov ebx, edx
        mov edx, eax
        mov eax, DataFilePath
        call MakeDataPath
        call ServiceIdle
        push ebx
        push DataFilePath
        call OpenArtArchiveErr
        jmp near MakeDirPath_177
;-----------------------------------------------------------------------------
; LoadDataFileFlag0                            4B12D  96 PC, medium confidence
; LoadDataFile through the same loader with flag 0
;-----------------------------------------------------------------------------
LoadDataFileFlag0:
        push ebx
        push ecx
        mov ebx, edx
        mov edx, eax
        mov eax, DataFilePath
        call MakeDataPath
        call ServiceIdle
        push ebx
        push DataFilePath
        call OpenArtArchive
        jmp near MakeDirPath_177
        push ebx
        push ecx
        mov ebx, edx
        mov edx, eax
        mov eax, DataFilePath
        call MakeDataPath
        call ServiceIdle
        push ebx
        push DataFilePath
        call LoadDataFileErr
        jmp near MakeDirPath_177
        push ebx
        push ecx
        mov ebx, edx
        mov edx, eax
        mov eax, DataFilePath
        call MakeDataPath
        call ServiceIdle
        push ebx
        push DataFilePath
        call LoadDataFileNoErr
        jmp near MakeDirPath_177
;-----------------------------------------------------------------------------
; OpenDataLibrary                                 4B19C  97 PC, low confidence
; (file id): makes the data file the current library (OpenResourceArchive)
;-----------------------------------------------------------------------------
OpenDataLibrary:
        push ecx
        push edx
        mov edx, eax
        mov eax, DataFilePath
        call MakeDataPath
        call ServiceIdle
        push DataFilePath
        call OpenResourceArchive
        add esp, byte 4
        call ServiceIdle
        pop edx
        pop ecx
        ret
;-----------------------------------------------------------------------------
; SetArtArchive                                   4B1C4  97 PC, low confidence
; (file name): finds the data file by name (102h-entry table), builds its
; path and makes it the current art archive; a null name closes it
;-----------------------------------------------------------------------------
SetArtArchive:
        push ebx
        push ecx
        push edx
        push esi
        mov esi, eax
        xor ecx, ecx
        test eax, eax
        jne short .1
        push eax
        call OpenResourceArchive
        add esp, byte 4
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.1:
        xor ebx, ebx
        jmp short .4
.2:
        imul eax, ebx, byte 15h
        mov edx, esi
        add eax, str_X_SetArtArchive
        call stricmp_
        test eax, eax
        jne short .3
        mov eax, DataFilePath
        mov edx, ebx
        call MakeDataPath
        call ServiceIdle
        push DataFilePath
        call OpenResourceArchive
        add esp, byte 4
        call ServiceIdle
        mov edx, ebx
        mov eax, DataFilePath
        call MakeDataPath
        push DataFilePath
        call DosFileInfo
        mov ecx, 1
        add esp, byte 4
.3:
        inc ebx
.4:
        cmp ebx, 102h
        jge short .5
        test ecx, ecx
        je short .2
.5:
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        push ebx
        push ecx
        push edx
        xor ebx, ebx
.6:
        imul eax, ebx, byte 0Fh
        add eax, DataDirPath
        push eax
        push str_DIRECTORYS
        xor edx, edx
        call printf_
        add esp, byte 8
.7:
        imul eax, edx, byte 15h
        cmp ebx, dword [dword eax+ArtArchiveIds]
        jne short .8
        add eax, ArtArchivePaths
        push eax
        push str_S
        call printf_
        add esp, byte 8
.8:
        inc edx
        cmp edx, byte 0Bh
        jl short .7
        xor edx, edx
.9:
        imul eax, edx, byte 15h
        cmp ebx, dword [dword eax+ArtArchiveSizes]
        jne short .10
        add eax, str_X_SetArtArchive
        push eax
        push str_S
        call printf_
        add esp, byte 8
.10:
        inc edx
        cmp edx, 102h
        jl short .9
        inc ebx
        cmp ebx, byte 5
        jl short .6
        xor ebx, ebx
.11:
        imul eax, ebx, byte 15h
        add eax, ArtArchivePaths
        push eax
        push str_BIGFILES
        xor edx, edx
        call printf_
        add esp, byte 8
.12:
        imul eax, edx, byte 15h
        mov ecx, ebx
        neg ecx
        cmp ecx, dword [dword eax+ArtArchiveSizes]
        jne short .13
        add eax, str_X_SetArtArchive
        push eax
        push str_S
        call printf_
        add esp, byte 8
.13:
        inc edx
        cmp edx, 102h
        jl short .12
        inc ebx
        cmp ebx, byte 0Bh
        jl short .11
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; LoadStartupData                                 4B307  97 PC, low confidence
; Checks the CPU and loads the start-up data file
;-----------------------------------------------------------------------------
LoadStartupData:
        push ebx
        push ecx
        push edx
        push esi
        enter 38h, 0
        call DetectCPU
        mov byte [GlobalSetName], 0
        mov dword [DirPathTable], GlobalSetName
        mov dword [GameOptionFlags], GlobalSetVersion
        mov edx, 1
        lea eax, [byte ebp-038h]
        lea ebx, [byte ebp-04h]
        call MakeDataPath
        mov edx, 2
        lea eax, [byte ebp-038h]
        xor esi, esi
        call _dos_open_
        test eax, eax
        je short .1
        xor ecx, ecx
        jmp short .2
.1:
        mov eax, dword [byte ebp-04h]
        mov edx, 20h
        call _dos_close_
        mov eax, 1
        call LoadDataFileHandle
        mov ecx, eax
.2:
        test ecx, ecx
        je near .5
        mov ebx, 130h
        mov eax, GlobalSetData
        mov edx, ecx
        call memcpy_
        cmp dword [GlobalSetData], 16059h
        jne short .4
        cmp byte [StartupFlag], 0
        jne short .3
        and dword [AudioOptions], 0FFE9FFFDh
.3:
        mov ebx, 14h
        lea esi, [dword ecx+0130h]
        mov eax, GlobalSetName
        mov edx, esi
        call strncpy_
        mov eax, GlobalSetName
        mov byte [GlobalSetPad], 0
        call strlen_
        inc eax
        mov ebx, 1E7h
        lea edx, [esi+eax]
        mov eax, GlobalSetVersion
        mov esi, 1
        call memcpy_
.4:
        push ecx
        call FreeMemBlock
        add esp, byte 4
.5:
        mov eax, esi
        leave
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; WriteGlobalSet                               4B3F8  96 PC, medium confidence
; Writes GLOBAL.SET back (BCh header, the name, B9h options), the file
; ReadGlobalSet reads
;-----------------------------------------------------------------------------
WriteGlobalSet:
        push ecx
        push edx
        enter 40h, 0
        mov edx, 1
        lea eax, [byte ebp-040h]
        call MakeDataPath
        lea eax, [byte ebp-08h]
        push eax
        lea eax, [byte ebp-0Ch]
        push eax
        lea eax, [byte ebp-04h]
        push eax
        lea eax, [byte ebp-040h]
        push eax
        call openhandle
        add esp, byte 10h
        push dword 130h
        push GlobalSetData
        push dword [byte ebp-04h]
        call DosWriteFile
        add esp, byte 0Ch
        test eax, eax
        je short .4
        mov eax, GlobalSetName
        call strlen_
        inc eax
        push eax
        push GlobalSetName
        push dword [byte ebp-04h]
        call DosWriteFile
        add esp, byte 0Ch
        test eax, eax
        je short .4
        cmp dword [LinkGameActive], byte 0
        je short .1
        call ClearLinkAbort
        test eax, eax
        je short .2
.1:
        push dword 1E7h
        push GlobalSetVersion
        jmp short .3
.2:
        push dword 1E7h
        push LinkSettings
.3:
        push dword [byte ebp-04h]
        call DosWriteFile
        add esp, byte 0Ch
.4:
        push dword [byte ebp-04h]
        call DosCloseFile
        add esp, byte 4
        leave
        pop edx
        pop ecx
        ret
