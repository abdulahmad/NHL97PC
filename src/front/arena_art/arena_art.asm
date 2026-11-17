; Arena art: rink sides, the arena archive, board and team logos.
bits 32
%include "hockey.inc"
section s_51CB6 progbits alloc exec nowrite align=1
extern ArenaArchive, ArenaArchiveHandle, ArenaArchiveSize, ArtBankEntry, BenchDoorArt, BindModelShapes, CrowdCenter, FindInstanceGroup
extern FindInstancePart, FindInstanceShape, FindShape, FlashSpots, FreeMemBlock, GetInstanceGroupEntry, memcpy_, OpenArtArchiveErr
extern OpenResourceArchive, ReadWholeFile, RemapArtBank, RinkPartModels, RinkSideCount, RinkSideGeometry, RinkSidesData, RinkSidesModel
extern ServiceIdle, SetArtArchive, SetModelShape, sprintf_, StandsArt, StandsEndModel, StandsRowModel, str_ArenaViv2
extern str_BlogoDC, str_Botboards, str_CrowdD, str_EMPTYFSH, str_FatBlueLines, str_FatRedLines, str_Glass, str_Glassline
extern str_Gt002d, str_Gt102d, str_Gt202d, str_Gt302d, str_HALFFSH, str_Icelogo, str_L02da, str_L02db
extern str_L02dC, str_L02dc, str_SideD, str_Stands2, str_STANDSFSH, str_Topboards, str_WALL
global BuildRinkSides, OpenArenaArchiveJumpTable, OpenArenaArchive, OpenArenaArchive_2C, OpenArenaArchive_42, OpenArenaArchive_58, OpenArenaArchive_7D, LoadBoardLogo
global LoadTeamLogoShape, LoadTeamLogoCopy
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; BuildRinkSides                               51CB8  96 PC, medium confidence
; Finds the 18 rink sides (Side%d) in the rink and stands models with their
; glass, glassline, boards and ice line parts
;-----------------------------------------------------------------------------
BuildRinkSides:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, 0F0h
        push str_Glassline
        mov edx, dword [CrowdCenter]
        push edx
        call FindInstanceShape
        add esp, byte 8
        push str_Glass
        mov ebx, dword [CrowdCenter]
        push ebx
        mov dword [dword esp+0B8h], eax
        call FindInstanceShape
        add esp, byte 8
        push str_Topboards
        mov ecx, dword [CrowdCenter]
        push ecx
        mov dword [dword esp+0C4h], eax
        call FindInstanceShape
        add esp, byte 8
        push str_Botboards
        mov esi, dword [CrowdCenter]
        push esi
        mov dword [dword esp+0BCh], eax
        call FindInstanceShape
        add esp, byte 8
        xor edi, edi
        mov ebp, dword [CrowdCenter]
        push str_FatRedLines
        mov dword [dword esp+0ACh], eax
        mov dword [dword esp+0CCh], edi
        mov dword [dword esp+0D0h], edi
        mov dword [dword esp+0C4h], edi
        mov dword [dword esp+0C8h], edi
        mov dword [dword esp+0D4h], edi
        push ebp
        mov dword [dword esp+0DCh], edi
        mov dword [dword esp+0ACh], edi
        call FindInstanceShape
        add esp, byte 8
        push str_FatBlueLines
        mov dword [BenchDoorArt], eax
        mov eax, dword [CrowdCenter]
        push eax
        call FindInstanceShape
        mov dword [RinkPartModels+0Ch], eax
        mov eax, dword [RinkSidesData]
        add esp, byte 8
        mov eax, dword [byte eax+028h]
        mov dword [dword esp+0ACh], eax
        mov eax, dword [RinkSidesModel]
        mov esi, RinkSideGeometry+410h
        mov eax, dword [byte eax+028h]
        mov dword [dword esp+0A0h], edi
        mov dword [dword esp+0B8h], eax
.1:
        mov ebx, dword [dword esp+0A0h]
        push ebx
        push str_SideD
        lea eax, [dword esp+088h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [dword esp+080h]
        push eax
        mov ecx, dword [CrowdCenter]
        push ecx
        call FindInstanceGroup
        add esp, byte 8
        lea edx, [dword esp+094h]
        push edx
        lea edx, [dword esp+09Ch]
        push edx
        push eax
        mov ebp, dword [CrowdCenter]
        push ebp
        call GetInstanceGroupEntry
        mov dword [byte esi+010h], 0
        mov dword [byte esi+014h], 0
        mov dword [byte esi+060h], 0
        mov dword [byte esi+028h], 0
        mov dword [byte esi+02Ch], 0
        mov dword [byte esi+0Ch], 0
        mov dword [esi], 1
        mov dword [byte esi+024h], 0FFFFFFFFh
        add esp, byte 10h
        mov dword [byte esi+064h], edi
        mov eax, dword [dword esp+0C8h]
        mov ebx, dword [dword esp+0C8h]
        mov dword [byte esi+018h], eax
        mov eax, dword [dword esp+0CCh]
        mov ecx, dword [dword esp+0CCh]
        mov dword [byte esi+01Ch], eax
        mov eax, dword [dword esp+0C0h]
        shl ebx, 2
        mov dword [byte esi+020h], eax
        shl eax, 2
        shl ecx, 2
        mov dword [dword esp+0E0h], eax
.2:
        mov eax, dword [dword esp+098h]
        dec eax
        mov dword [dword esp+098h], eax
        cmp eax, byte 0FFFFFFFFh
        je near .9
        mov eax, dword [dword esp+094h]
        lea edx, [byte eax+04h]
        mov dword [dword esp+094h], edx
        mov eax, dword [eax]
        mov ebp, dword [dword esp+0ACh]
        shl eax, 4
        add eax, ebp
        mov edx, dword [eax]
        shl edx, 8
        mov ebp, dword [dword esp+0B0h]
        shr edx, 18h
        cmp edx, ebp
        jne short .3
        mov ebp, dword [dword esp+0CCh]
        mov edx, dword [byte esi+010h]
        add ecx, byte 4
        inc edx
        inc ebp
        mov dword [byte esi+010h], edx
        mov dword [dword esp+0CCh], ebp
        mov dword [dword ecx+RinkSideCount], eax
        jmp short .2
.3:
        cmp edx, dword [dword esp+0BCh]
        jne short .4
        inc dword [byte esi+014h]
        mov edx, dword [dword esp+0E0h]
        mov dword [dword edx+RinkSideGeometry+0E68h], eax
        mov eax, dword [dword esp+0C0h]
        lea ebp, [byte edx+04h]
        inc eax
        mov dword [dword esp+0E0h], ebp
        mov dword [dword esp+0C0h], eax
        jmp near .2
.4:
        cmp edx, dword [dword esp+0B4h]
        jne short .5
        mov edx, dword [byte eax+08h]
        mov dword [dword esp+09Ch], edx
        mov edx, dword [byte esi+028h]
        shl edx, 3
        lea ebp, [esi+edx]
        mov edx, dword [dword esp+09Ch]
        mov edx, dword [edx]
        mov dword [byte ebp+030h], edx
        mov eax, dword [byte eax+08h]
        mov edx, dword [byte esi+028h]
        mov eax, dword [byte eax+04h]
        mov dword [byte esi+edx*8+034h], eax
        mov eax, dword [byte esi+028h]
        inc eax
        mov dword [byte esi+028h], eax
        jmp near .2
.5:
        cmp edx, dword [dword esp+0A8h]
        jne short .6
        mov ebp, dword [byte esi+02Ch]
        shl ebp, 3
        mov edx, dword [byte eax+08h]
        add ebp, esi
        mov edx, dword [edx]
        mov dword [byte ebp+048h], edx
        mov eax, dword [byte eax+08h]
        mov edx, dword [byte esi+02Ch]
        mov eax, dword [byte eax+04h]
        mov dword [byte esi+edx*8+04Ch], eax
        inc dword [byte esi+02Ch]
        jmp near .2
.6:
        lea ebp, [nosplit edi*4+00h]
        mov dword [dword esp+0D8h], ebp
        lea ebp, [byte edi+01h]
        mov dword [dword esp+0DCh], ebp
        cmp edx, dword [BenchDoorArt]
        jne short .7
        mov edi, dword [byte esi+060h]
        inc edi
        mov edx, dword [dword esp+0D8h]
        mov dword [byte esi+060h], edi
        mov edi, dword [dword esp+0DCh]
        mov dword [dword edx+RinkSideGeometry+320h], eax
        jmp near .2
.7:
        cmp edx, dword [RinkPartModels+0Ch]
        jne short .8
        inc dword [byte esi+060h]
        mov edx, dword [dword esp+0D8h]
        mov edi, dword [dword esp+0DCh]
        mov dword [dword edx+RinkSideGeometry+320h], eax
        jmp near .2
.8:
        mov ebp, dword [dword esp+0C8h]
        mov edx, dword [byte esi+0Ch]
        add ebx, byte 4
        inc edx
        inc ebp
        mov dword [byte esi+0Ch], edx
        mov dword [dword esp+0C8h], ebp
        mov dword [dword ebx+RinkSideGeometry+0D9Ch], eax
        jmp near .2
.9:
        cmp dword [dword esp+0A0h], byte 10h
        jge near .19
        lea eax, [dword esp+080h]
        push eax
        mov ecx, dword [FlashSpots]
        push ecx
        call FindInstanceGroup
        add esp, byte 8
        lea edx, [dword esp+094h]
        push edx
        lea edx, [dword esp+09Ch]
        push edx
        push eax
        mov ebp, dword [FlashSpots]
        push ebp
        call GetInstanceGroupEntry
        add esp, byte 10h
        mov dword [byte esi+074h], 0
        mov eax, dword [dword esp+0C4h]
        mov dword [byte esi+068h], eax
        mov eax, dword [dword esp+0D4h]
        mov dword [byte esi+070h], eax
        mov eax, dword [dword esp+0D0h]
        mov dword [byte esi+078h], eax
        mov eax, dword [byte esi+074h]
        mov dword [byte esi+07Ch], eax
        mov dword [byte esi+06Ch], eax
        mov eax, dword [dword esp+0C4h]
        shl eax, 2
        mov dword [dword esp+0E8h], eax
        mov eax, dword [dword esp+0D0h]
        shl eax, 2
        mov dword [dword esp+0ECh], eax
        mov eax, dword [dword esp+0D4h]
        shl eax, 2
        mov dword [dword esp+0E4h], eax
.10:
        mov eax, dword [dword esp+098h]
        dec eax
        mov dword [dword esp+098h], eax
        cmp eax, byte 0FFFFFFFFh
        je near .19
        mov edx, dword [dword esp+094h]
        lea ebx, [byte edx+04h]
        mov dword [dword esp+094h], ebx
        mov edx, dword [edx]
        mov ebp, edx
        mov ecx, dword [dword esp+0B8h]
        shl ebp, 4
        mov eax, dword [RinkPartModels+110h]
        add ebp, ecx
        test eax, eax
        jle short .13
        mov ecx, dword [RinkPartModels+110h]
        mov ebx, dword [RinkPartModels+11Ch]
        xor eax, eax
        shl ecx, 2
.11:
        cmp edx, dword [ebx+eax]
        jne short .12
        mov ecx, dword [byte esi+06Ch]
        inc ecx
        mov eax, dword [dword esp+0E8h]
        mov dword [byte esi+06Ch], ecx
        mov dword [dword eax+RinkSideGeometry+258h], ebp
        lea ebp, [byte eax+04h]
        mov eax, dword [dword esp+0C4h]
        inc eax
        mov dword [dword esp+0E8h], ebp
        mov dword [dword esp+0C4h], eax
        jmp near .10
.12:
        add eax, byte 4
        cmp eax, ecx
        jl short .11
.13:
        mov ebx, dword [RinkPartModels+0ECh]
        test ebx, ebx
        jle short .16
        lea ecx, [nosplit ebx*4+00h]
        xor eax, eax
        mov ebx, dword [RinkPartModels+0F8h]
.14:
        cmp edx, dword [ebx+eax]
        jne short .15
        mov ecx, dword [byte esi+07Ch]
        inc ecx
        mov eax, dword [dword esp+0ECh]
        mov dword [byte esi+07Ch], ecx
        mov dword [dword eax+RinkSideGeometry+0FF8h], ebp
        lea ebp, [byte eax+04h]
        mov eax, dword [dword esp+0D0h]
        inc eax
        mov dword [dword esp+0ECh], ebp
        mov dword [dword esp+0D0h], eax
        jmp near .10
.15:
        add eax, byte 4
        cmp eax, ecx
        jl short .14
.16:
        mov ebx, dword [RinkPartModels+0E4h]
        test ebx, ebx
        jle near .10
        lea ecx, [nosplit ebx*4+00h]
        xor eax, eax
        mov ebx, dword [RinkPartModels+0E0h]
.17:
        cmp edx, dword [ebx+eax]
        jne short .18
        mov eax, dword [dword esp+0E4h]
        mov ecx, dword [dword esp+0D4h]
        mov edx, dword [byte esi+074h]
        lea ebx, [byte eax+04h]
        inc edx
        inc ecx
        mov dword [dword esp+0E4h], ebx
        mov dword [byte esi+074h], edx
        mov dword [dword esp+0D4h], ecx
        mov dword [dword eax+RinkSideGeometry+348h], ebp
        jmp near .10
.18:
        add eax, byte 4
        cmp eax, ecx
        jl short .17
        jmp near .10
.19:
        mov ebp, dword [dword esp+0A0h]
        inc ebp
        add esi, 88h
        mov dword [dword esp+0A0h], ebp
        cmp ebp, byte 12h
        jl near .1
        mov eax, dword [dword esp+0A4h]
        mov edi, RinkSideGeometry+410h
        xor edx, edx
        xor ebx, ebx
        mov dword [RinkSideGeometry+490h], eax
        mov dword [RinkSideGeometry+494h], edx
        lea esi, [nosplit eax*4+00h]
.20:
        push ebx
        push str_Gt002d
        lea eax, [byte esp+028h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte esp+020h]
        push eax
        mov ecx, dword [CrowdCenter]
        push ecx
        call FindInstancePart
        add esp, byte 8
        test eax, eax
        jl short .21
        imul eax, byte 0Ch
        inc dword [dword edi+084h]
        mov edx, dword [CrowdCenter]
        mov edx, dword [byte edx+074h]
        add eax, edx
        mov dword [dword esi+RinkSideGeometry+10C0h], eax
        mov eax, dword [dword esp+0A4h]
        add esi, byte 4
        inc eax
        inc ebx
        mov dword [dword esp+0A4h], eax
        cmp ebx, byte 14h
        jl short .20
.21:
        mov eax, dword [dword esp+0A4h]
        mov edi, RinkSideGeometry+498h
        xor edx, edx
        xor ebx, ebx
        mov dword [RinkSideGeometry+518h], eax
        mov dword [RinkSideGeometry+51Ch], edx
        lea esi, [nosplit eax*4+00h]
.22:
        push ebx
        push str_Gt102d
        lea eax, [byte esp+048h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte esp+040h]
        push eax
        mov ecx, dword [CrowdCenter]
        push ecx
        call FindInstancePart
        add esp, byte 8
        test eax, eax
        jl short .23
        imul ecx, eax, byte 0Ch
        inc dword [dword edi+084h]
        mov edx, dword [CrowdCenter]
        mov eax, dword [byte edx+074h]
        add eax, ecx
        mov dword [dword esi+RinkSideGeometry+10C0h], eax
        mov eax, dword [dword esp+0A4h]
        add esi, byte 4
        inc eax
        inc ebx
        mov dword [dword esp+0A4h], eax
        cmp ebx, byte 14h
        jl short .22
.23:
        mov eax, dword [dword esp+0A4h]
        mov edi, RinkSideGeometry+520h
        xor edx, edx
        xor ebx, ebx
        mov dword [RinkSideGeometry+5A0h], eax
        mov dword [RinkSideGeometry+5A4h], edx
        lea esi, [nosplit eax*4+00h]
.24:
        push ebx
        push str_Gt202d
        lea eax, [byte esp+08h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        mov eax, esp
        push eax
        mov ecx, dword [CrowdCenter]
        push ecx
        call FindInstancePart
        add esp, byte 8
        test eax, eax
        jl short .25
        imul eax, byte 0Ch
        inc dword [dword edi+084h]
        mov edx, dword [CrowdCenter]
        mov edx, dword [byte edx+074h]
        add eax, edx
        mov dword [dword esi+RinkSideGeometry+10C0h], eax
        mov eax, dword [dword esp+0A4h]
        add esi, byte 4
        inc eax
        inc ebx
        mov dword [dword esp+0A4h], eax
        cmp ebx, byte 14h
        jl short .24
.25:
        mov eax, dword [dword esp+0A4h]
        mov edi, RinkSideGeometry+5A8h
        xor edx, edx
        xor ebx, ebx
        mov dword [RinkSideGeometry+628h], eax
        mov dword [RinkSideGeometry+62Ch], edx
        lea esi, [nosplit eax*4+00h]
.26:
        push ebx
        push str_Gt302d
        lea eax, [byte esp+068h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte esp+060h]
        push eax
        mov ecx, dword [CrowdCenter]
        push ecx
        call FindInstancePart
        add esp, byte 8
        test eax, eax
        jl short .27
        imul eax, byte 0Ch
        inc dword [dword edi+084h]
        mov edx, dword [CrowdCenter]
        mov edx, dword [byte edx+074h]
        add eax, edx
        mov dword [dword esi+RinkSideGeometry+10C0h], eax
        mov eax, dword [dword esp+0A4h]
        add esi, byte 4
        inc eax
        inc ebx
        mov dword [dword esp+0A4h], eax
        cmp ebx, byte 14h
        jl short .26
.27:
        add esp, 0F0h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        push ebx
        push ecx
        push edx
        mov ebx, eax
        push str_Icelogo
        mov edx, dword [CrowdCenter]
        push edx
        call FindInstanceShape
        add esp, byte 8
        push ebx
        push eax
        mov ebx, dword [CrowdCenter]
        push ebx
        call SetModelShape
        add esp, byte 0Ch
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
        push ecx
        push edx
        mov edx, dword [ArenaArchiveHandle]
        test edx, edx
        je short .28
        push edx
        call FreeMemBlock
        xor ecx, ecx
        add esp, byte 4
        mov dword [ArenaArchiveHandle], ecx
.28:
        pop edx
        pop ecx
        ret
OpenArenaArchiveJumpTable:                      ; jump table for the switch cases of OpenArenaArchive
        dd OpenArenaArchive_58
        dd OpenArenaArchive_2C
        dd OpenArenaArchive_42
        dd OpenArenaArchive_7D
;-----------------------------------------------------------------------------
; OpenArenaArchive                             52494  97 PC, medium confidence
; SetArtArchive "arena.viv", from the game graphics set-up (InitGameGraphics)
;-----------------------------------------------------------------------------
OpenArenaArchive:
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 10h
        mov edx, eax
        mov eax, str_ArenaViv2
        call SetArtArchive
        inc edx
        call ServiceIdle
        cmp edx, byte 3
        ja near OpenArenaArchive_7D.2
        jmp dword [nosplit cs:edx*4+OpenArenaArchiveJumpTable]
OpenArenaArchive_2C:
        mov ecx, dword [ArenaArchiveHandle]
        push ecx
        push str_EMPTYFSH
        call ReadWholeFile
        add esp, byte 8
        jmp short OpenArenaArchive_7D.2
OpenArenaArchive_42:
        mov ebx, dword [ArenaArchiveHandle]
        push ebx
        push str_HALFFSH
        call ReadWholeFile
        add esp, byte 8
        jmp short OpenArenaArchive_7D.2
OpenArenaArchive_58:
        push byte 0
        push str_STANDSFSH
        call OpenArtArchiveErr
        mov edx, dword [ArenaArchive]
        add esp, byte 8
        mov dword [ArenaArchiveHandle], eax
        mov ebx, eax
        xor ecx, ecx
        mov eax, str_Stands2
        jmp short OpenArenaArchive_7D.1
OpenArenaArchive_7D:
        mov edx, dword [ArenaArchiveHandle]
        push edx
        push str_STANDSFSH
        call ReadWholeFile
        mov eax, str_Stands2
        mov ebx, dword [ArenaArchiveHandle]
        add esp, byte 8
        mov edx, dword [ArenaArchive]
        xor ecx, ecx
.1:
        call RemapArtBank
.2:
        mov esi, dword [ArenaArchiveHandle]
        push esi
        mov edi, dword [FlashSpots]
        push edi
        xor ebx, ebx
        call BindModelShapes
        xor esi, esi
        add esp, byte 8
.3:
        push ebx
        push str_CrowdD
        lea eax, [byte esp+08h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        mov eax, esp
        push eax
        mov ebp, dword [FlashSpots]
        push ebp
        call FindInstanceShape
        imul ecx, eax, byte 14h
        mov edx, dword [FlashSpots]
        mov eax, dword [byte edx+014h]
        add esi, byte 4
        inc ebx
        mov eax, dword [byte ecx+eax+0Ch]
        add esp, byte 8
        mov dword [dword esi+ArenaArchiveSize], eax
        cmp ebx, byte 9
        jl short .3
        push str_WALL
        mov eax, dword [StandsArt]
        push edx
        mov dword [StandsEndModel], eax
        call FindInstanceShape
        mov edx, eax
        shl eax, 2
        mov ebx, dword [FlashSpots]
        add eax, edx
        mov edx, dword [byte ebx+014h]
        add esp, byte 8
        mov eax, dword [byte edx+eax*4+0Ch]
        push byte 0
        mov dword [StandsRowModel], eax
        call OpenResourceArchive
        add esp, byte 4
        add esp, byte 10h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; LoadBoardLogo                                   525E0  97 PC, low confidence
; Loads a board logo shape "blogo%d%c"
;-----------------------------------------------------------------------------
LoadBoardLogo:
        push ecx
        push esi
        push edi
        sub esp, byte 0Ch
        mov edi, edx
        lea edx, [byte ebx+061h]
        push edx
        push eax
        push str_BlogoDC
        lea eax, [byte esp+0Ch]
        push eax
        call sprintf_
        add esp, byte 10h
        mov eax, esp
        push eax
        mov edx, dword [CrowdCenter]
        push edx
        call FindInstanceShape
        mov edx, edi
        mov esi, eax
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        add esp, byte 8
        add ebx, eax
        push ebx
        mov ebx, dword [RinkPartModels+144h]
        push ebx
        call ArtBankEntry
        add esp, byte 8
        push eax
        push esi
        mov ecx, dword [CrowdCenter]
        push ecx
        call SetModelShape
        add esp, byte 0Ch
        add esp, byte 0Ch
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; LoadTeamLogoShape                               52648  97 PC, low confidence
; Loads a team logo
;-----------------------------------------------------------------------------
LoadTeamLogoShape:
        push ebx
        push ecx
        push esi
        push edi
        sub esp, byte 0Ch
        mov esi, eax
        mov edi, edx
        push edx
        push str_L02da
        lea eax, [byte esp+08h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        mov eax, esp
        push eax
        push esi
        call FindShape
        mov edx, dword [byte eax+02h]
        mov ebx, dword [byte eax+04h]
        sar edx, 10h
        sar ebx, 10h
        imul ebx, edx
        add esp, byte 8
        push edi
        push str_L02db
        lea eax, [byte esp+08h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        mov eax, esp
        push eax
        push esi
        call FindShape
        mov edx, dword [byte eax+02h]
        mov eax, dword [byte eax+04h]
        sar edx, 10h
        sar eax, 10h
        imul eax, edx
        add esp, byte 8
        push edi
        add ebx, byte 4Bh
        push str_L02dc
        add ebx, eax
        lea eax, [byte esp+08h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        mov eax, esp
        push eax
        push esi
        call FindShape
        mov edx, dword [byte eax+02h]
        mov eax, dword [byte eax+04h]
        sar edx, 10h
        sar eax, 10h
        imul eax, edx
        add esp, byte 8
        add eax, ebx
        add esp, byte 0Ch
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; LoadTeamLogoCopy                                526EC  97 PC, low confidence
; Loads a copy of a team logo
;-----------------------------------------------------------------------------
LoadTeamLogoCopy:
        push esi
        sub esp, byte 10h
        mov esi, eax
        mov dword [byte esp+0Ch], edx
        xor eax, eax
        mov al, byte [byte esp+018h]
        push eax
        push ecx
        push str_L02dC
        lea eax, [byte esp+0Ch]
        push eax
        call sprintf_
        add esp, byte 10h
        mov eax, esp
        push eax
        push ebx
        call FindShape
        mov ebx, 4
        lea edx, [byte esp+08h]
        add esp, byte 8
        mov ecx, eax
        mov eax, esi
        call memcpy_
        mov ebx, 4
        lea edx, [byte esp+0Ch]
        lea eax, [byte esi+04h]
        call memcpy_
        mov edx, dword [byte ecx+02h]
        mov eax, dword [byte ecx+04h]
        sar edx, 10h
        sar eax, 10h
        imul eax, edx
        lea esi, [byte eax+010h]
        mov edx, dword [byte esp+0Ch]
        mov eax, dword [RinkPartModels+144h]
        mov ebx, esi
        add eax, edx
        mov edx, ecx
        call memcpy_
        mov eax, esi
        add esp, byte 10h
        pop esi
        ret 4
        db 08Bh,0C0h
