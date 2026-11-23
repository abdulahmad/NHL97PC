; Speech: banks, chained clips, play-by-play calls, the speech stream and the public address announcer.
bits 32
%include "hockey.inc"
section s_43578 progbits alloc exec nowrite align=1
extern __CHK, __CHP, AddStreamSample, AllocMemBlock, AllocMemData, AsyncClose, AsyncFreeRequest, AsyncInit
extern AsyncRequestOpen, AsyncRequestSection, AsyncStreamStep, AwayPlayerRecords, AwayRosterData, AwaySpeechLoaded, AwaySpeechNames, bcopy
extern CheckDiskSpace, CloseSpeechChannels, CommentaryClip, CommentaryCurrent, CommentaryDelay, CommentaryEventId, CommentaryLast, CommentaryOn
extern CommentaryPrev, CommentaryPriority, CommentarySpeaker, CommentaryTime, CreateMenuBitmap, CurrentArchiveName, DosCloseFile, DosOpenReadOnly
extern DosReadFile, DosSeekFile, F64_0p5_SayPlayerCall, F64_0p5_SayRandomFiller, F64_0p5_SaySaveCall, F64_0p5_SayShotCall, FileClose, FileExists
extern FileLength, FileOpen, FileReadRecord, FileSeek, FileSizePath, FileWriteRecord, FindShape, FindSpeechClip
extern FreeMemBlock, FreeMenuBitmap, FrontShapeFile, FrontTextFile, gameopts, GameSettings, GameSoundsOn, HideWorkingBox
extern HomeInjuredCount, HomePlayerRecords, HomeRosterData, HomeSpeechLoaded, HomeSpeechNames, HomeTeamRating, InitSpeechBank, InitSpeechChannels
extern LoadClipIfMissing, LoadDataFile, LoadDataFileLib, LoadFileToBlockPlain, LoadSpeechBlock, LoadTeamSpeech, MakeColor, MakeDataPath
extern MakeDirPath, MusicOptions, OpenResourceArchive, OpenSpeechBanks, OpenSpeechStreamFile, PaEventValue, PaNameRanges, PaQueueClip
extern PaQueueCount, PaQueueHead, PaQueuePrev, PaQueueTail, PaQueueTime, PeriodAwayTeam, PeriodHomeTeam, PlayerCallClip
extern PlayerCallClips, PlayerCallLast, PlayerCallStart, PlayerCallTime, PlayerCallTimes, PlayQueuedSpeech, QueueCarrySpeech, QueueDeflectSpeech
extern QueueFaceoffSpeech, QueueFinalSpeech, QueueHitSpeech, QueueLoosePuckSpeech, QueuePassSpeech, QueuePenaltyCallSpeech, QueuePenaltyEndSpeech, QueuePenaltySpeech
extern QueuePickupSpeech, QueuePositionSpeech, QueuePowerPlaySpeech, QueueReceiveSpeech, QueueShotSpeech, QueueSpeechClip, QueueSpeechRequest, QueueStoppageSpeech
extern QueueTeamSpeech, QueueTouchPuckSpeech, rand_, RegisterSpeechBank, RegisterStreamBank, ReleaseBankSample, ReplayPlaying, ReplaySoundAllowed
extern RequestSpeechEvent, ResetSpeechQueue, ResolveSpeechClips, RingBufferSpace, ServiceIdle, SetNormalText, SetSpeechEnabled, SetTextColor
extern SfxBankLoaded, SfxVolumeLevel, ShowLoadingBar, ShowMessageBoxNoWait, ShowWorkingBox, ShutdownSpeechQueue, SortIndices, SoundCardType
extern SoundDriverId, SpeechBankAway, SpeechBankAwaySize, SpeechBankBuffer, SpeechBankCountFront, SpeechBankHandle, SpeechBankHome, SpeechBankHomeSize
extern SpeechBankList, SpeechBanksLoaded, SpeechBanksReady, SpeechBufferSize, SpeechChainCount, SpeechChainLen, SpeechClipDefTable, SpeechClipIndex
extern SpeechClipTable, SpeechDataId, SpeechDataOpen, SpeechFileHandle, SpeechFileHeader, SpeechFileIds, SpeechPlaying, SpeechQueueGo
extern SpeechStreamBase, SpeechStreamBuf, SpeechStreamBytes, SpeechStreamClip, SpeechStreamEnd, SpeechStreamFile, SpeechStreamLen, SpeechStreamRead
extern SpeechStreamTimer, SpeechTableError, SpeechTableNames, sprintf_, StartSpeechQueue, str_03dDAT, str_03dHDR, str_CarrySS
extern str_CBANK03dHDR, str_DerAway, str_DerHome, str_EVENTDAT, str_GAMEDATAAUDPBP3TSF, str_GKSF, str_InstallingPlayByPlay, str_KTSF
extern str_Mous, str_PBP, str_PlayAway, str_PlayByPlayNeedsToBeInstal, str_PlayByPlayNeedsToBeInstal2, str_PlayHome, str_Remo, str_SPEECH
extern str_TEAM04dHDR, str_TEMP, str_TEMPBANK, strcat_, strcmp_, strcpy_, StreamTimerHandle, StreamTimerOn
extern SumRingRange, ThreeStarsCount, tickcount, UnregisterSoundBank, UpdateWorkingBox, vecdist, ZeroMem
global LoadSpeechBank, QueueSpeechChain, QueueSpeechChain_9C, InitSpeechBanks, CloseSpeechFile, SpeechClipLength, SayShotCall, SaySaveCall
global SayPassCall, SpeechTableEntry, SayPlayerCall, SayRandomFiller, SpeechClipExists, SpeechEventKind, CommentaryEventJumpTable, Commentary3000JumpTable
global Commentary4000JumpTable, Commentary5000JumpTable, Commentary6000JumpTable, Commentary7000JumpTable, CommentaryA000JumpTable, CommentaryD000JumpTable, CommentaryEvent, CommentaryEvent_66
global CommentaryEvent_135, CommentaryEvent_2DE, CommentaryEvent_36D, CommentaryEvent_3F6, CommentaryEvent_3FF, CommentaryEvent_408, CommentaryEvent_411, CommentaryEvent_41A
global CommentaryEvent_423, CommentaryEvent_48A, CommentaryEvent_4E4, CommentaryEvent_4ED, CommentaryEvent_4F6, CommentaryEvent_4FF, CommentaryEvent_508, CommentaryEvent_511
global CommentaryEvent_51A, CommentaryEvent_523, CommentaryEvent_52C, CommentaryEvent_535, CommentaryEvent_58C, CommentaryEvent_5E2, CommentaryEvent_5EB, CommentaryEvent_5F4
global CommentaryEvent_5FD, CommentaryEvent_654, CommentaryEvent_6D5, CommentaryEvent_6E7, CommentaryEvent_6F0, CommentaryEvent_6F9, CommentaryEvent_702, CommentaryEvent_726
global CommentaryEvent_7BF, CommentaryEvent_831, CommentaryEvent_83B, CommentaryEvent_847, CommentaryEvent_853, CommentaryEvent_85F, CommentaryEvent_868, CommentaryEvent_871
global CommentaryEvent_87A, CommentaryEvent_883, CommentaryEvent_88C, CommentaryEvent_895, CommentaryEvent_89E, CommentaryEvent_8A7, CommentaryEvent_8B0, CommentaryEvent_8B9
global CommentaryEvent_8D6, CommentaryEvent_96F, CommentaryEvent_A08, CommentaryEvent_A84, CommentaryEvent_B1D, CommentaryEvent_BB6, CommentaryEvent_C68, CommentaryEvent_D2A
global CommentaryEvent_D86, CommentaryEvent_E79, CommentaryEvent_F12, CommentaryEvent_F80, CommentaryEvent_F89, CommentaryEvent_F92, CommentaryEvent_F9B, CommentaryEvent_FB0
global CommentaryEvent_FB9, CommentaryEvent_FDD, CommentaryEvent_1084, CommentaryEvent_111C, CommentaryEvent_11C5, CommentaryEvent_1293, CommentaryEvent_1500, CommentaryEvent_16BA
global CommentaryEvent_1771, CommentaryEvent_17AA, CommentaryEvent_17E6, CommentaryEvent_1871, CommentaryEvent_189C, CommentaryEvent_18A1, CommentaryEvent_18AA, CommentaryEvent_18B3
global CommentaryEvent_18BC, CommentaryEvent_1931, CommentaryEvent_19C8, CommentaryEvent_1A44, CommentaryEvent_1B16, CommentaryEvent_1B57, CommentaryEvent_1B97, CommentaryEvent_1BF5
global CommentaryEvent_1C3D, CommentaryEvent_1CB2, CommentaryEvent_1DD1, CommentaryEvent_1E49, CommentaryEvent_1ECB, CommentaryEvent_1F28, CommentaryEvent_1F56, CommentaryEvent_1FE8
global OpenSpeechFile, FreeSpeechBuffers, PickPaClip, OpenSpeechData, InitSpeechStream, ShutdownSound, OpenPlayByPlay, OpenArenaSpeech
global ServiceSpeechStream, QueuePaClip, SayPaClip, PaPlayerName, CountRecordGame, RecordPctClip, RecordStreakClips, PaEventJumpTable
global PaEventArgJumpTable, PaEvent, PaEvent_4D6, PaEvent_4EC, PaEvent_502, PaEvent_518, PaEvent_536, PaEvent_572
global PaEvent_5AE, PaEvent_5D6, PaEvent_5FE, PaEvent_64E, PaEvent_69E, PaEvent_745, PaEvent_7FF, PaEvent_87E
global PaEvent_8CF, PaEvent_8F5, PaEvent_91B, PaEvent_941, PaEvent_967, PaEvent_14CD
%if VERSION = 11
extern LoadSpeechClips, str_CBANK03dDAT, str_KTSF_InitSpeechBanks, str_SAUDPBP2VIV
%endif
;-----------------------------------------------------------------------------
; LoadSpeechBank                                  43578  97 PC, low confidence
; From InitSpeechBanks: opens a speech bank's "%03d.DAT" / "%03d.HDR" pair
; (MakeDataPath) and reads its header
;-----------------------------------------------------------------------------
LoadSpeechBank:
        push dword 98h
        call __CHK
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 70h
        mov dword [byte esp+068h], eax
        mov edx, eax
        shl eax, 3
        mov ecx, dword [SpeechClipTable]
        sub eax, edx
        xor ebx, ebx
        add eax, eax
        xor edi, edi
        mov dword [byte esp+06Ch], eax
.1:
        mov eax, dword [SpeechClipTable]
        mov eax, dword [dword eax+02D2h]
        sar eax, 10h
        cmp edi, eax
        jge short .6
        imul eax, ebx, byte 0Ch
.2:
        lea edx, [ecx+eax]
        mov ebp, dword [dword edx+02D8h]
        lea esi, [byte ebx+01h]
        test ebp, ebp
        jge short .3
        mov ebx, esi
        add eax, byte 0Ch
        jmp short .2
.3:
        mov ebp, dword [byte esp+06Ch]
        mov eax, dword [SpeechBankBuffer]
        add eax, ebp
        mov edx, dword [dword edx+02D8h]
        cmp edx, dword [eax]
        jne short .4
        mov edi, dword [dword ecx+02D2h]
        sar edi, 10h
        jmp short .5
.4:
        mov ebx, esi
.5:
        inc edi
        jmp short .1
.6:
        mov edx, dword [byte esp+068h]
        lea esi, [nosplit edx*8+00h]
        sub esi, edx
        lea ecx, [byte eax+01h]
        add esi, esi
        cmp edi, ecx
        jne short .7
        mov eax, dword [SpeechBankBuffer]
        mov word [byte esi+eax+04h], bx
        jmp near .18
.7:
        mov edx, 57h
        mov eax, esp
        call MakeDataPath
        mov eax, esp
        push eax
        call OpenResourceArchive
        mov eax, dword [SpeechBankBuffer]
        add esp, byte 4
        mov edx, dword [esi+eax]
        push edx
        push str_03dDAT
        lea eax, [byte esp+058h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [byte esp+050h]
        push eax
        call FileSizePath
        add esp, byte 4
        mov ecx, eax
        test eax, eax
        jle near .19
        mov ebx, ecx
        xor edi, edi
.8:
        mov edx, dword [SpeechClipTable]
        mov eax, edi
.9:
        cmp ebx, dword [dword edx+eax+057Eh]
        jg short .10
        mov eax, 1
        jmp short .11
.10:
        add eax, byte 8
        cmp eax, 2A0h
        jl short .9
        mov eax, edi
.11:
        test eax, eax
        jne short .12
        call ResolveSpeechClips
        jmp short .8
.12:
        mov ebx, dword [SpeechClipTable]
        cmp word [dword ebx+02D6h], byte 0
        jl short .13
        mov ebx, dword [dword ebx+02D4h]
        sar ebx, 10h
        jmp short .14
.13:
        call ResolveSpeechClips
        mov ebx, eax
.14:
        mov edi, 1
        test ebx, ebx
        jl near .16
        lea esi, [nosplit ebx*4+00h]
        sub esi, ebx
        mov ebp, dword [SpeechClipTable]
        shl esi, 2
        mov ax, word [dword esi+ebp+02DCh]
        mov edx, dword [byte esp+068h]
        mov word [dword ebp+02D6h], ax
        lea ebp, [nosplit edx*8+00h]
        sub ebp, edx
        mov eax, dword [SpeechBankBuffer]
        add ebp, ebp
        add eax, ebp
        mov dword [byte esp+060h], eax
        mov eax, dword [SpeechClipTable]
        add eax, esi
        mov dword [byte esp+064h], eax
        mov eax, dword [byte esp+060h]
        mov edx, dword [byte esp+064h]
        mov eax, dword [eax]
        mov dword [dword edx+02D8h], eax
        mov eax, ecx
        call LoadClipIfMissing
        test eax, eax
        jl short .15
        mov edx, dword [SpeechClipTable]
        mov dword [dword edx+esi+02DCh], eax
        mov eax, dword [SpeechClipTable]
        mov edx, dword [dword esi+eax+02DCh]
        mov eax, dword [SpeechBankHandle]
        call FileSeek
        test eax, eax
        je short .15
        lea eax, [byte esp+050h]
        mov edx, dword [SpeechBankHandle]
        call LoadSpeechBlock
        mov edx, dword [SpeechClipTable]
        mov dword [dword edx+esi+02E0h], eax
        mov eax, dword [SpeechClipTable]
        cmp dword [dword esi+eax+02E0h], byte 0
        jbe short .15
        mov eax, dword [SpeechBankBuffer]
        mov word [byte eax+ebp+04h], bx
        mov eax, dword [SpeechClipTable]
        mov cx, word [dword eax+02D4h]
        inc ecx
        xor edi, edi
        mov word [dword eax+02D4h], cx
.15:
        test edi, edi
        je short .16
        lea eax, [nosplit ebx*4+00h]
        sub eax, ebx
        mov edx, dword [SpeechClipTable]
        shl eax, 2
        lea ecx, [edx+eax]
        mov ax, word [dword edx+02D6h]
        mov word [dword ecx+02DCh], ax
        mov eax, dword [SpeechClipTable]
        mov word [dword eax+02D6h], bx
.16:
        test edi, edi
        je short .17
        mov edx, dword [byte esp+068h]
        lea eax, [nosplit edx*8+00h]
        sub eax, edx
        mov edx, dword [SpeechBankBuffer]
        mov word [byte edx+eax*2+04h], 0FFFFh
.17:
        push byte 0
        call OpenResourceArchive
        add esp, byte 4
.18:
        mov edx, dword [byte esp+068h]
        lea ebx, [nosplit edx*8+00h]
        sub ebx, edx
        mov eax, dword [SpeechBankBuffer]
        add ebx, ebx
        cmp word [byte ebx+eax+04h], byte 0
        jl short .20
        mov edx, 56h
        mov eax, esp
        call MakeDataPath
        mov eax, esp
        push eax
        call OpenResourceArchive
        mov eax, dword [SpeechBankBuffer]
        add esp, byte 4
        mov ecx, dword [ebx+eax]
        push ecx
        push str_03dHDR
        lea eax, [byte esp+058h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        call ServiceIdle
        mov eax, dword [SpeechBankBuffer]
        mov esi, dword [byte ebx+eax+0Ah]
        push esi
        lea eax, [byte esp+054h]
        push eax
        call LoadFileToBlockPlain
        add esp, byte 8
        test eax, eax
        jne short .19
        mov eax, dword [SpeechBankBuffer]
        mov word [byte ebx+eax+04h], 0FFFFh
.19:
        push byte 0
        call OpenResourceArchive
        add esp, byte 4
.20:
        add esp, byte 70h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; QueueSpeechChain                                43884  97 PC, low confidence
; Queues a chain of speech clips
;-----------------------------------------------------------------------------
QueueSpeechChain:
        push dword 1Ch
        call __CHK
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov esi, eax
        cmp eax, dword [SpeechBankHome]
        jne short .1
        mov eax, dword [SpeechClipTable]
        mov eax, dword [dword eax+02C0h]
        jmp near .8
.1:
        cmp eax, dword [SpeechBankAway]
        jne short .2
        mov eax, dword [SpeechClipTable]
        mov eax, dword [dword eax+02CCh]
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.2:
        mov edx, dword [SpeechChainLen]
        xor ebx, ebx
        test edx, edx
        je short .7
        mov edi, dword [SpeechChainCount]
.3:
        lea eax, [ebx+edx]
        sar eax, 1
        lea ecx, [nosplit eax*4+00h]
        add ecx, edi
        mov ebp, dword [ecx]
        cmp esi, ebp
        jne short .4
        mov edx, dword [SpeechClipIndex]
        add eax, edx
        mov eax, dword [dword edi+eax*4+02BCh]
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.4:
        jle short .5
        mov edx, eax
        jmp short .6
.5:
        lea ebx, [byte eax+01h]
.6:
        cmp ebx, edx
        jne short .3
.7:
        mov eax, 0FFFFFFFFh
.8:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
QueueSpeechChain_9C:
        push ecx
        mov ecx, edx
        mov edx, ebx
        call QueueSpeechChain
        test eax, eax
        jl short .9
        add eax, ecx
        call QueueSpeechRequest
        test eax, eax
        je short .9
        mov eax, 1
        pop ecx
        ret
.9:
        xor eax, eax
        pop ecx
        ret
%if VERSION = 11
;-----------------------------------------------------------------------------
; InitSpeechBanks                                 43C58  97 PC, low confidence
; From InitGameAudio: sets up the speech banks (TEMPBANK, EVENT.DAT,
; CBANK%03d.HDR, TEAM%04d.HDR, PBP, AUDPBP3.TSF, KTSF)
;-----------------------------------------------------------------------------
InitSpeechBanks:
        push dword 19Ch
        call __CHK
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, 174h
        cmp dword [SoundCardType], byte 0
        jne near .114
        mov eax, dword [gameopts]
        mov edx, dword [byte eax+01h]
        mov eax, dword [byte eax+01h]
        shl edx, 0Ch
        shl eax, 6
        shr edx, 1Ah
        shr eax, 1Ah
        mov dword [dword esp+0170h], edx
        mov dword [dword esp+016Ch], eax
        cmp edx, byte 0Eh
        jne short .1
        cmp eax, byte 0Fh
        je short .2
.1:
        cmp dword [dword esp+016Ch], byte 0Eh
        jne short .6
        cmp dword [dword esp+0170h], byte 0Fh
        jne short .6
.2:
        mov ebp, dword [dword esp+0170h]
        cmp ebp, byte 0Eh
        jne short .3
        mov dword [dword esp+0170h], 23h
        jmp short .4
.3:
        cmp ebp, byte 0Fh
        jne short .4
        mov dword [dword esp+0170h], 24h
.4:
        mov ecx, dword [dword esp+016Ch]
        cmp ecx, byte 0Eh
        jne short .5
        mov dword [dword esp+016Ch], 23h
        jmp short .6
.5:
        cmp ecx, byte 0Fh
        jne short .6
        mov dword [dword esp+016Ch], 24h
.6:
        xor eax, eax
        mov dword [SpeechBankBuffer], eax
        call CurrentArchiveName
        test eax, eax
        je short .7
        call CurrentArchiveName
        cmp byte [eax], 0
        je short .7
        call CurrentArchiveName
        mov edx, eax
        lea eax, [dword esp+0B4h]
        call strcpy_
        jmp short .8
.7:
        xor dh, dh
        mov byte [dword esp+0B4h], dh
.8:
        xor eax, eax
        xor edx, edx
        xor ebx, ebx
        mov dword [dword esp+0164h], eax
        jmp short .11
.9:
        cmp byte [dword ebx+HomeSpeechLoaded], 1
        ja short .10
        cmp dword [dword ebx+HomePlayerRecords], byte 0
        jne short .10
        inc edx
.10:
        mov ecx, dword [dword esp+0164h]
        inc ecx
        add ebx, 125h
        mov dword [dword esp+0164h], ecx
.11:
        mov ecx, dword [ThreeStarsCount]
        mov esi, dword [dword esp+0164h]
        sar ecx, 10h
        cmp ecx, esi
        jg short .9
        xor edi, edi
        xor ebx, ebx
        mov dword [dword esp+0164h], edi
        jmp short .14
.12:
        cmp byte [dword ebx+HomeRosterData+01C52h], 1
        ja short .13
        cmp dword [dword ebx+HomeRosterData+01B94h], byte 0
        jne short .13
        inc edx
.13:
        mov ecx, dword [dword esp+0164h]
        inc ecx
        add ebx, 125h
        mov dword [dword esp+0164h], ecx
.14:
        mov ecx, dword [HomeRosterData+1B90h]
        mov esi, dword [dword esp+0164h]
        sar ecx, 10h
        cmp ecx, esi
        jg short .12
        xor edi, edi
        xor ebx, ebx
        mov dword [dword esp+0164h], edi
        jmp short .17
.15:
        cmp byte [dword ebx+AwaySpeechLoaded], 1
        ja short .16
        cmp dword [dword ebx+AwayPlayerRecords], byte 0
        jne short .16
        inc eax
.16:
        mov ecx, dword [dword esp+0164h]
        inc ecx
        add ebx, 125h
        mov dword [dword esp+0164h], ecx
.17:
        mov ecx, dword [HomeInjuredCount]
        mov esi, dword [dword esp+0164h]
        sar ecx, 10h
        cmp ecx, esi
        jg short .15
        xor edi, edi
        xor ebx, ebx
        mov dword [dword esp+0164h], edi
        jmp short .20
.18:
        cmp byte [dword ebx+AwayRosterData+01C52h], 1
        ja short .19
        cmp dword [dword ebx+AwayRosterData+01B94h], byte 0
        jne short .19
        inc eax
.19:
        mov esi, dword [dword esp+0164h]
        inc esi
        add ebx, 125h
        mov dword [dword esp+0164h], esi
.20:
        mov esi, dword [AwayRosterData+1B90h]
        mov edi, dword [dword esp+0164h]
        sar esi, 10h
        cmp esi, edi
        jg short .18
        lea esi, [eax+edx]
        push byte 20h
        lea eax, [dword esi*8+00h]
        push eax
        push dword str_TEMP
        call AllocMemData
        mov ebx, eax
        add esp, byte 0Ch
        mov ebp, eax
        test eax, eax
        je near .114
        shl esi, 2
        lea edi, [eax+esi]
        xor eax, eax
        mov esi, edi
        mov dword [dword esp+0164h], eax
        jmp short .29
.27:
        imul edx, ecx, dword 125h
        cmp byte [dword edx+HomeSpeechLoaded], 1
        ja short .28
        cmp dword [dword edx+HomePlayerRecords], byte 0
        jne short .28
        mov edx, dword [dword edx+HomeSpeechNames]
        add esi, byte 4
        mov dword [ebx], edx
        add ebx, byte 4
        mov dword [byte esi-04h], eax
        inc eax
.28:
        inc dword [dword esp+0164h]
.29:
        mov edx, dword [ThreeStarsCount]
        mov ecx, dword [dword esp+0164h]
        sar edx, 10h
        cmp edx, ecx
        jg short .27
        xor esi, esi
        lea edx, [dword eax*4+00h]
        mov dword [dword esp+0164h], esi
        lea esi, [edx+edi]
        lea ebx, [edx+ebp]
        jmp short .86
.84:
        imul edx, ecx, dword 125h
        cmp byte [dword edx+HomeRosterData+01C52h], 1
        ja short .85
        cmp dword [dword edx+HomeRosterData+01B94h], byte 0
        jne short .85
        mov edx, dword [dword edx+HomeRosterData+01B98h]
        add esi, byte 4
        mov dword [ebx], edx
        add ebx, byte 4
        mov dword [byte esi-04h], eax
        inc eax
.85:
        inc dword [dword esp+0164h]
.86:
        mov edx, dword [HomeRosterData+1B90h]
        mov ecx, dword [dword esp+0164h]
        sar edx, 10h
        cmp edx, ecx
        jg short .84
        xor esi, esi
        lea edx, [dword eax*4+00h]
        mov dword [dword esp+0164h], esi
        lea esi, [edx+edi]
        lea ebx, [edx+ebp]
        jmp short .89
.87:
        imul edx, ecx, dword 125h
        cmp byte [dword edx+AwaySpeechLoaded], 1
        ja short .88
        cmp dword [dword edx+AwayPlayerRecords], byte 0
        jne short .88
        mov edx, dword [dword edx+AwaySpeechNames]
        add esi, byte 4
        mov dword [ebx], edx
        add ebx, byte 4
        mov dword [byte esi-04h], eax
        inc eax
.88:
        inc dword [dword esp+0164h]
.89:
        mov edx, dword [HomeInjuredCount]
        mov ecx, dword [dword esp+0164h]
        sar edx, 10h
        cmp edx, ecx
        jg short .87
        lea edx, [dword eax*4+00h]
        xor esi, esi
        lea ebx, [edx+edi]
        mov dword [dword esp+0164h], esi
        lea esi, [edx+ebp]
        jmp short .32
.30:
        imul edx, ecx, dword 125h
        cmp byte [dword edx+AwayRosterData+01C52h], 1
        ja short .31
        cmp dword [dword edx+AwayRosterData+01B94h], byte 0
        jne short .31
        mov edx, dword [dword edx+AwayRosterData+01B98h]
        add ebx, byte 4
        mov dword [esi], edx
        add esi, byte 4
        mov dword [byte ebx-04h], eax
        inc eax
.31:
        inc dword [dword esp+0164h]
.32:
        mov edx, dword [AwayRosterData+1B90h]
        mov ecx, dword [dword esp+0164h]
        sar edx, 10h
        cmp edx, ecx
        jg short .30
        mov dword [SpeechClipIndex], eax
        mov eax, 13h
        call ShowLoadingBar
        push edi
        push ebp
        mov esi, dword [SpeechClipIndex]
        push esi
        call SortIndices
        add esp, byte 0Ch
        call ServiceIdle
        push byte 20h
        push dword 578h
        push dword str_TEMPBANK
        call AllocMemBlock
        mov dword [SpeechBankList], eax
        mov eax, dword [SpeechClipIndex]
        lea edi, [dword eax*8+00h]
        sub edi, eax
        imul eax, dword 307h
        mov edx, 56h
        add edi, edi
        add esp, byte 0Ch
        add edi, eax
        lea eax, [dword esp+0104h]
        call MakeDataPath
        lea eax, [dword esp+0104h]
        push eax
        call OpenResourceArchive
        add esp, byte 4
        push dword str_EVENTDAT
        call FileSizePath
        add esp, byte 4
        add edi, 81Ah
        mov dword [dword esp+0168h], eax
        test eax, eax
        je near .112
        xor ebx, ebx
        add edi, eax
        mov dword [dword esp+0164h], ebx
.33:
        mov ecx, dword [dword esp+0164h]
        push ecx
        push dword str_CBANK03dHDR
        lea eax, [dword esp+015Ch]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [dword esp+0154h]
        push eax
        call FileSizePath
        add esp, byte 4
        test eax, eax
        jle short .34
        mov esi, dword [dword esp+0164h]
        mov edx, dword [SpeechBankList]
        mov dword [edx+esi*8], 0FFFFFFFFh
        mov ecx, dword [dword esp+0164h]
        mov esi, dword [SpeechBankList]
        lea edx, [edi+ebx]
        add ebx, eax
        mov dword [byte esi+ecx*8+04h], edx
.34:
        mov esi, dword [dword esp+0164h]
        inc esi
        mov dword [dword esp+0164h], esi
        cmp esi, 0AFh
        jl short .33
        mov edx, dword [dword esp+0170h]
        push edx
        push dword str_TEAM04dHDR
        lea eax, [dword esp+015Ch]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [dword esp+0154h]
        push eax
        call FileSizePath
        add esp, byte 4
        test eax, eax
        jle short .90
        lea edx, [edi+ebx]
        mov ecx, 0FFFFFFFFh
        mov dword [SpeechBankHomeSize], edx
        mov dword [SpeechBankHome], ecx
        add ebx, eax
.90:
        mov esi, dword [dword esp+016Ch]
        push esi
        push dword str_TEAM04dHDR
        lea eax, [dword esp+015Ch]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [dword esp+0154h]
        push eax
        call FileSizePath
        add esp, byte 4
        test eax, eax
        jle short .36
        mov dword [SpeechBankAway], 0FFFFFFFFh
        lea edx, [edi+ebx]
        mov dword [SpeechBankAwaySize], edx
        add ebx, eax
.36:
        mov eax, dword [SpeechClipIndex]
        add edi, ebx
        add eax, 0AFh
        add edi, 8000h
        shl eax, 3
        add edi, eax
        call ServiceIdle
        mov eax, 14h
        call ShowLoadingBar
        push byte 0
        add edi, 578h
        push edi
        push dword str_PBP
        mov dword [SpeechBankCountFront], edi
        call AllocMemBlock
        mov esi, dword [SpeechClipIndex]
        add esp, byte 0Ch
        xor ecx, ecx
        mov dword [SpeechBankBuffer], eax
        mov dword [dword esp+0164h], ecx
        test esi, esi
        jle near .38
        mov edi, 0FFFFFFFFh
.37:
        mov eax, dword [SpeechClipIndex]
        mov edx, dword [dword esp+0164h]
        dec eax
        sub eax, edx
        imul edx, byte 0Eh
        shl eax, 2
        lea ecx, [eax+ebp]
        mov eax, dword [SpeechBankBuffer]
        add edx, eax
        mov eax, dword [ecx]
        mov dword [edx], eax
        imul edx, dword [dword esp+0164h], byte 0Eh
        mov eax, dword [SpeechBankBuffer]
        mov word [byte edx+eax+04h], di
        imul eax, dword [dword esp+0164h], byte 0Eh
        mov edx, dword [SpeechBankBuffer]
        mov dword [byte edx+eax+06h], edi
        imul edx, dword [SpeechClipIndex], byte 0Eh
        mov eax, dword [SpeechBankBuffer]
        mov ecx, dword [dword esp+0164h]
        lea esi, [eax+edx]
        imul edx, ecx, dword 307h
        add esi, edx
        imul edx, ecx, byte 0Eh
        mov dword [byte edx+eax+0Ah], esi
        mov esi, dword [dword esp+0164h]
        inc esi
        mov edx, dword [SpeechClipIndex]
        mov dword [dword esp+0164h], esi
        cmp esi, edx
        jl near .37
.38:
        imul eax, dword [SpeechClipIndex], dword 307h
        mov edx, dword [SpeechBankBuffer]
        mov edx, dword [byte edx+0Ah]
        xor esi, esi
        add edx, eax
        mov dword [dword esp+0164h], esi
        mov dword [SpeechClipTable], edx
        lea edi, [dword edx+081Ah]
.39:
        mov eax, dword [dword esp+0164h]
        mov edx, dword [SpeechBankList]
        shl eax, 3
        add eax, edx
        mov edx, dword [SpeechBankBuffer]
        add dword [byte eax+04h], edx
        mov esi, dword [dword esp+0164h]
        push esi
        push dword str_CBANK03dHDR
        lea eax, [dword esp+015Ch]
        push eax
        call sprintf_
        add esp, byte 0Ch
        call ServiceIdle
        mov edx, dword [dword esp+0164h]
        mov eax, dword [SpeechBankList]
        mov ecx, dword [byte eax+edx*8+04h]
        push ecx
        lea eax, [dword esp+0158h]
        push eax
        call LoadFileToBlockPlain
        add esp, byte 8
        test eax, eax
        je near .112
        mov esi, dword [dword esp+0164h]
        inc esi
        mov dword [dword esp+0164h], esi
        cmp esi, 0AFh
        jl short .39
        mov ecx, dword [dword esp+0170h]
        push ecx
        mov eax, dword [SpeechBankBuffer]
        mov edx, dword [SpeechBankHomeSize]
        push dword str_TEAM04dHDR
        add edx, eax
        lea eax, [dword esp+015Ch]
        push eax
        mov dword [SpeechBankHomeSize], edx
        call sprintf_
        add esp, byte 0Ch
        mov esi, dword [SpeechBankHomeSize]
        push esi
        lea eax, [dword esp+0158h]
        push eax
        call LoadFileToBlockPlain
        add esp, byte 8
        test eax, eax
        je near .112
        mov ecx, dword [dword esp+016Ch]
        call ServiceIdle
        push ecx
        mov eax, dword [SpeechBankBuffer]
        mov edx, dword [SpeechBankAwaySize]
        push dword str_TEAM04dHDR
        add edx, eax
        lea eax, [dword esp+015Ch]
        push eax
        mov dword [SpeechBankAwaySize], edx
        call sprintf_
        add esp, byte 0Ch
        mov esi, dword [SpeechBankAwaySize]
        push esi
        lea eax, [dword esp+0158h]
        push eax
        call LoadFileToBlockPlain
        add esp, byte 8
        test eax, eax
        je near .112
        call ServiceIdle
        add ebx, dword [dword esp+0168h]
        lea eax, [edi+ebx]
        mov dword [SpeechBanksLoaded], eax
        add eax, 8000h
        mov dword [SpeechChainCount], eax
        mov eax, dword [SpeechClipIndex]
        add eax, 0AFh
        mov ebx, dword [SpeechChainCount]
        shl eax, 3
        push dword 578h
        add ebx, eax
        push ebx
        mov edx, dword [SpeechBankList]
        push edx
        call bcopy
        add esp, byte 0Ch
        mov ecx, dword [SpeechBankList]
        push ecx
        call FreeMemBlock
        add esp, byte 4
        mov eax, 16h
        mov dword [SpeechBankList], ebx
        call ShowLoadingBar
        mov eax, str_GAMEDATAAUDPBP3TSF
        call FileExists
        test eax, eax
        jne short .91
        mov ecx, 1
        jmp near .93
.91:
        call ServiceIdle
        mov edx, SpeechBankHandle
        mov eax, str_GAMEDATAAUDPBP3TSF
        mov ecx, 1
        call FileOpen
        test eax, eax
        je near .43
        mov eax, dword [SpeechBankHandle]
        mov esi, 0CCh
        call FileLength
        mov dword [dword esp+0164h], esi
        cmp eax, 0F23056h
        jge short .41
        xor ecx, ecx
.41:
        test ecx, ecx
        je near .42
        mov ebx, 4
        lea edx, [dword esp+0154h]
        mov eax, dword [SpeechBankHandle]
        call FileReadRecord
        test eax, eax
        je near .43
        xor al, al
        mov edx, str_KTSF
        mov byte [dword esp+0158h], al
        lea eax, [dword esp+0154h]
        call strcmp_
        test eax, eax
        jne near .92
        mov ebx, 4
        lea edx, [dword esp+0164h]
        mov eax, dword [SpeechBankHandle]
        call FileReadRecord
        test eax, eax
        je near .43
        cmp dword [dword esp+0164h], 81Ah
        jne near .43
        mov ebx, 4
        lea edx, [dword esp+0164h]
        mov eax, dword [SpeechBankHandle]
        call FileReadRecord
        test eax, eax
        je near .43
        cmp dword [dword esp+0164h], 0AFh
        jne near .43
        mov ebx, 81Ah
        mov edx, dword [SpeechClipTable]
        mov eax, dword [SpeechBankHandle]
        call FileReadRecord
        test eax, eax
        je near .43
        xor ecx, ecx
        jmp near .43
.92:
        mov edx, str_KTSF_InitSpeechBanks
        lea eax, [dword esp+0154h]
        call strcmp_
        test eax, eax
        jne near .43
        mov ebx, 4
        lea edx, [dword esp+0164h]
        mov eax, dword [SpeechBankHandle]
        call FileReadRecord
        test eax, eax
        je short .43
        cmp dword [dword esp+0164h], 81Ah
        jne short .43
        mov ebx, 4
        lea edx, [dword esp+0164h]
        mov eax, dword [SpeechBankHandle]
        call FileReadRecord
        test eax, eax
        je short .43
        cmp dword [dword esp+0164h], 0AFh
        jne short .43
        mov ebx, 81Ah
        mov edx, dword [SpeechClipTable]
        mov eax, dword [SpeechBankHandle]
        call FileReadRecord
        test eax, eax
        je short .43
        mov ecx, 0FFFFFFFFh
        jmp short .43
.42:
        mov ecx, 1
.43:
        test ecx, ecx
        jle short .93
        mov eax, SpeechBankHandle
        call FileClose
.93:
        test ecx, ecx
        jle near .94
        mov eax, 2Eh
        xor edx, edx
        call LoadDataFile
        mov dword [FrontShapeFile], eax
        xor edx, edx
        mov eax, 2Fh
        call LoadDataFileLib
        push dword str_Remo
        mov edx, dword [FrontShapeFile]
        push edx
        mov dword [FrontTextFile], eax
        call FindShape
        add esp, byte 8
        push dword str_Mous
        mov ecx, dword [FrontShapeFile]
        push ecx
        mov ebx, eax
        call FindShape
        add esp, byte 8
        mov edx, ebx
        call CreateMenuBitmap
        call SetNormalText
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        call SetTextColor
        mov dword [dword esp+0164h], 408Ch
        call CheckDiskSpace
        mov edx, eax
        mov eax, dword [GameSettings]
        mov esi, 0CCh
        shl eax, 1Ch
        mov ebx, dword [dword esp+0164h]
        shr eax, 1Eh
        cmp edx, ebx
        jge near .48
        cmp eax, byte 1
        jb short .46
        jbe short .45
        cmp eax, byte 2
        jne short .46
        call CheckDiskSpace
        mov edx, dword [dword esp+0164h]
        sub edx, eax
        push edx
        push dword str_DerHome
        jmp short .47
.45:
        call CheckDiskSpace
        mov edx, dword [dword esp+0164h]
        sub edx, eax
        push edx
        push dword str_PlayHome
        jmp short .47
.46:
        call CheckDiskSpace
        mov edx, dword [dword esp+0164h]
        sub edx, eax
        push edx
        push dword str_PlayByPlayNeedsToBeInstal
.47:
        lea eax, [byte esp+08h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        push byte 0
        mov ecx, 1
        lea eax, [byte esp+04h]
        xor ebx, ebx
        mov edx, ecx
        call ShowMessageBoxNoWait
        mov dl, byte [MusicOptions]
        and dl, 0F7h
        xor esi, esi
        mov byte [MusicOptions], dl
        jmp near .53
.48:
        cmp eax, byte 1
        jb short .50
        lea edx, [dword ebx-0400h]
        jbe short .49
        cmp eax, byte 2
        jne short .50
        push edx
        push dword str_DerAway
        jmp short .51
.49:
        push edx
        push dword str_PlayAway
        jmp short .51
.50:
        mov eax, dword [dword esp+0164h]
        sub eax, 400h
        push eax
        push dword str_PlayByPlayNeedsToBeInstal2
.51:
        lea eax, [byte esp+08h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        push byte 1
        mov ecx, 1
        mov edx, 2
        lea eax, [byte esp+04h]
        xor ebx, ebx
        call ShowMessageBoxNoWait
        test eax, eax
        je near .52
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        call SetTextColor
        mov edx, esi
        mov eax, str_InstallingPlayByPlay
        mov ebx, 1
        call ShowWorkingBox
        mov edx, 4
        lea eax, [dword esp+0B4h]
        call MakeDirPath
        mov edx, 4
        lea eax, [dword esp+0104h]
        xor ebx, ebx
        call MakeDirPath
        mov ebx, UpdateWorkingBox
        lea edx, [dword esp+0104h]
        lea eax, [dword esp+0B4h]
        call OpenSpeechBanks
        mov edx, eax
        mov esi, eax
        call HideWorkingBox
        test edx, edx
        je short .53
        mov edx, SpeechBankHandle
        mov eax, str_GAMEDATAAUDPBP3TSF
        call FileOpen
        mov esi, eax
        jmp short .53
.52:
        mov ah, byte [MusicOptions]
        and ah, 0F7h
        xor esi, esi
        mov byte [MusicOptions], ah
.53:
        call FreeMenuBitmap
        mov ecx, dword [FrontShapeFile]
        push ecx
        call FreeMemBlock
        add esp, byte 4
        mov edx, dword [FrontTextFile]
        xor eax, eax
        push edx
        xor ebx, ebx
        mov dword [FrontShapeFile], eax
        call FreeMemBlock
        add esp, byte 4
        mov dword [FrontTextFile], ebx
        test esi, esi
        je near .112
.54:
        mov eax, 18h
        mov edx, dword [dword esp+016Ch]
        call ShowLoadingBar
        call ServiceIdle
        mov eax, dword [dword esp+0170h]
        call LoadTeamSpeech
        call ServiceIdle
        mov eax, 1Ah
        xor ebx, ebx
        call ShowLoadingBar
        mov ecx, dword [SpeechClipIndex]
        mov dword [dword esp+0164h], ebx
        test ecx, ecx
        jle short .56
.55:
        call ServiceIdle
        mov eax, dword [dword esp+0164h]
        call LoadSpeechBank
        imul edx, dword [dword esp+0164h], byte 14h
        mov ebx, dword [SpeechClipIndex]
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        add eax, byte 1Ah
        call ShowLoadingBar
        mov ecx, dword [dword esp+0164h]
        inc ecx
        mov esi, dword [SpeechClipIndex]
        mov dword [dword esp+0164h], ecx
        cmp ecx, esi
        jl short .55
.56:
        mov eax, 2Eh
        mov edx, 0Ch
        call ShowLoadingBar
        mov eax, dword [SpeechBankHandle]
        call FileSeek
        test eax, eax
        jne near .99
        mov eax, SpeechBankHandle
        call FileClose
        jmp near .112
.94:
        jge near .54
        mov eax, dword [SpeechClipTable]
        mov word [dword eax+02D4h], 0
        mov eax, dword [SpeechClipTable]
        mov word [dword eax+02D6h], 0
        xor eax, eax
        mov dword [dword esp+0164h], eax
.95:
        imul eax, dword [dword esp+0164h], byte 0Ch
        mov edx, dword [SpeechClipTable]
        mov dword [dword edx+eax+02D8h], 0FFFFFFFFh
        imul eax, dword [dword esp+0164h], byte 0Ch
        mov ebx, dword [dword esp+0164h]
        mov edx, dword [SpeechClipTable]
        inc ebx
        mov word [dword edx+eax+02DCh], bx
        imul eax, dword [dword esp+0164h], byte 0Ch
        mov edx, dword [SpeechClipTable]
        mov dword [dword edx+eax+02E0h], 0
        mov ecx, dword [dword esp+0164h]
        inc ecx
        mov dword [dword esp+0164h], ecx
        cmp ecx, byte 38h
        jl short .95
        mov eax, dword [SpeechClipTable]
        mov word [dword eax+0570h], 0FFFFh
        mov eax, dword [SpeechClipTable]
        mov word [dword eax+0578h], 0
        xor eax, eax
        mov dword [dword esp+0164h], eax
.96:
        mov eax, dword [dword esp+0164h]
        mov edx, dword [SpeechClipTable]
        shl eax, 3
        add edx, eax
        mov eax, dword [dword esp+0164h]
        inc eax
        mov dword [dword edx+057Ah], eax
        mov eax, dword [dword esp+0164h]
        mov edx, dword [SpeechClipTable]
        mov dword [dword edx+eax*8+057Eh], 0
        mov edx, dword [dword esp+0164h]
        inc edx
        mov dword [dword esp+0164h], edx
        cmp edx, byte 54h
        jl short .96
        mov eax, dword [SpeechClipTable]
        mov ebx, 1
        mov edx, 4
        mov dword [dword eax+0812h], 0FFFFFFFFh
        lea eax, [dword esp+0B4h]
        call MakeDirPath
        lea eax, [dword esp+0B4h]
        push eax
        push dword str_SAUDPBP2VIV
        lea eax, [dword esp+010Ch]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [dword esp+0104h]
        push eax
        call OpenResourceArchive
        add esp, byte 4
        xor ecx, ecx
        mov ebx, 826h
        mov dword [dword esp+0164h], ecx
.97:
        mov esi, dword [dword esp+0164h]
        push esi
        push dword str_CBANK03dDAT
        lea eax, [dword esp+015Ch]
        push eax
        call sprintf_
        add esp, byte 0Ch
        call ServiceIdle
        lea eax, [dword esp+0154h]
        push eax
        call FileSizePath
        add esp, byte 4
        mov edx, eax
        call ServiceIdle
        test edx, edx
        jne short .98
        mov eax, SpeechBankHandle
        call FileClose
        jmp near .112
.98:
        mov eax, dword [dword esp+0164h]
        inc eax
        add ebx, edx
        mov dword [dword esp+0164h], eax
        cmp eax, 0AFh
        jl short .97
        mov edx, 3405C0h
        mov eax, ebx
        call LoadSpeechClips
        mov eax, dword [SpeechClipTable]
        mov dword [dword eax+02C8h], 0FFFFFFFFh
        mov edx, dword [dword eax+02C8h]
        mov eax, dword [SpeechClipTable]
        mov dword [dword eax+02BCh], edx
        call ServiceIdle
        mov edx, 0Ch
        mov eax, dword [SpeechBankHandle]
        call FileSeek
        test eax, eax
        jne short .57
        mov eax, SpeechBankHandle
        call FileClose
        jmp near .112
.57:
        mov ebx, 81Ah
        mov edx, dword [SpeechClipTable]
        mov eax, dword [SpeechBankHandle]
        call FileWriteRecord
        test eax, eax
        jne near .54
        mov eax, SpeechBankHandle
        call FileClose
        jmp near .112
.99:
        mov ebx, 81Ah
        mov edx, dword [SpeechClipTable]
        mov eax, dword [SpeechBankHandle]
        call FileWriteRecord
        test eax, eax
        jne short .58
        mov eax, SpeechBankHandle
        call FileClose
        jmp near .112
.58:
        mov eax, SpeechBankHandle
        call FileClose
        call ServiceIdle
        mov eax, 30h
        call ShowLoadingBar
        mov eax, QueueSpeechChain_9C
        call InitSpeechChannels
        test eax, eax
        jl near .111
        mov edx, 56h
        lea eax, [dword esp+0104h]
        call MakeDataPath
        lea eax, [dword esp+0104h]
        push eax
        call OpenResourceArchive
        add esp, byte 4
        call ServiceIdle
        push edi
        push dword str_EVENTDAT
        call LoadFileToBlockPlain
        add esp, byte 8
        test eax, eax
        jne short .100
        call CloseSpeechChannels
        jmp near .112
.100:
        call ServiceIdle
        mov eax, edi
        call InitSpeechBank
        test eax, eax
        jne short .101
        call CloseSpeechChannels
        jmp near .112
.101:
        call ServiceIdle
        xor edi, edi
        mov ebx, 2
        mov dword [dword esp+0164h], edi
.61:
        mov eax, dword [dword esp+0164h]
        mov eax, dword [dword eax*8+SpeechBankHomeSize]
        call RegisterSpeechBank
        mov edx, eax
        mov eax, dword [dword esp+0164h]
        mov dword [dword eax*8+SpeechBankHome], edx
        test edx, edx
        jge short .62
        mov dword [dword esp+0164h], ebx
.62:
        mov ecx, dword [dword esp+0164h]
        inc ecx
        mov dword [dword esp+0164h], ecx
        cmp ebx, ecx
        jg short .61
        cmp ecx, byte 2
        je short .63
        mov dword [dword esp+0164h], 0B0h
        jmp short .64
.63:
        xor eax, eax
        mov dword [dword esp+0164h], eax
.64:
        mov ecx, 0AFh
.65:
        mov ebx, dword [dword esp+0164h]
        cmp ecx, ebx
        jle short .102
        mov eax, dword [SpeechBankList]
        mov edx, ebx
        mov eax, dword [byte eax+edx*8+04h]
        call RegisterSpeechBank
        mov edx, dword [dword esp+0164h]
        mov ebx, dword [SpeechBankList]
        mov dword [ebx+edx*8], eax
        mov edx, dword [SpeechChainCount]
        mov ebx, eax
        mov eax, dword [dword esp+0164h]
        mov dword [edx+eax*4], ebx
        mov ebx, dword [dword esp+0164h]
        mov eax, dword [SpeechClipIndex]
        add eax, ebx
        lea edx, [dword eax*4+00h]
        mov eax, dword [SpeechChainCount]
        add edx, eax
        mov dword [dword edx+02BCh], ebx
        mov eax, ebx
        mov edx, dword [SpeechBankList]
        cmp dword [edx+eax*8], byte 0
        jge short .66
        mov dword [dword esp+0164h], ecx
.66:
        inc dword [dword esp+0164h]
        jmp short .65
.102:
        call ServiceIdle
        mov eax, 31h
        call ShowLoadingBar
        cmp dword [dword esp+0164h], 0AFh
        jne near .110
        mov edx, GameSoundsOn
        mov eax, str_GAMEDATAAUDPBP3TSF
        call FileOpen
        test eax, eax
        je near .110
        call ResetSpeechQueue
        mov esi, 1
        mov edx, dword [SpeechClipIndex]
        xor edi, edi
        mov dword [SoundCardType], esi
        mov dword [SpeechBanksReady], edi
        mov dword [dword esp+0164h], edi
        test edx, edx
        jle near .71
        mov ecx, 0FFFFFFFFh
.103:
        imul edx, dword [dword esp+0164h], byte 0Eh
        mov eax, dword [SpeechBankBuffer]
        add eax, edx
        mov edx, dword [byte eax+02h]
        sar edx, 10h
        cmp edx, byte 0FFFFFFFFh
        je short .104
        mov eax, dword [byte eax+0Ah]
        call RegisterSpeechBank
        imul ebx, dword [dword esp+0164h], byte 0Eh
        mov edx, dword [SpeechBankBuffer]
        mov dword [byte edx+ebx+06h], eax
        mov edx, dword [SpeechChainCount]
        mov ebx, eax
        mov eax, dword [dword esp+0164h]
        mov dword [dword edx+eax*4+02BCh], ebx
        jmp short .105
.104:
        mov edx, dword [dword esp+0164h]
        mov eax, dword [SpeechChainCount]
        mov dword [dword eax+edx*4+02BCh], ecx
.105:
        mov ebx, dword [dword esp+0164h]
        mov eax, dword [SpeechClipIndex]
        add eax, ebx
        mov edx, dword [SpeechChainCount]
        shl eax, 2
        add eax, edx
        lea edx, [dword ebx+0AFh]
        mov dword [dword eax+0578h], edx
        mov esi, dword [dword esp+0164h]
        inc esi
        mov edi, dword [SpeechClipIndex]
        mov dword [dword esp+0164h], esi
        cmp esi, edi
        jl near .103
.71:
        mov edx, dword [SpeechClipIndex]
        add edx, 0AFh
        mov eax, dword [SpeechChainCount]
        lea ebx, [dword edx*4+00h]
        add ebx, eax
        push ebx
        push eax
        push edx
        call SortIndices
        mov ebx, dword [SpeechClipIndex]
        add esp, byte 0Ch
        add ebx, 0AFh
        xor eax, eax
        shl ebx, 2
        mov dword [SpeechChainLen], eax
        test ebx, ebx
        jle short .107
.106:
        mov edx, dword [SpeechChainCount]
.72:
        cmp dword [edx+eax], byte 0
        jl short .107
        mov edx, dword [SpeechChainLen]
        inc edx
        add eax, byte 4
        mov dword [SpeechChainLen], edx
        cmp eax, ebx
        jl short .106
.107:
        call ServiceIdle
        xor esi, esi
        mov edi, dword [SpeechChainLen]
        mov dword [dword esp+0164h], esi
        test edi, edi
        jle near .77
.108:
        mov edx, dword [dword esp+0164h]
        mov eax, dword [SpeechClipIndex]
        add eax, edx
        mov edx, dword [SpeechChainCount]
        shl eax, 2
        add eax, edx
        mov ebx, dword [dword eax+02BCh]
        cmp ebx, 0AFh
        jge short .109
        mov edx, ebx
        mov ebx, dword [SpeechClipTable]
        mov edx, dword [ebx+edx*4]
        jmp short .76
.109:
        lea edx, [dword ebx-0AFh]
        imul ebx, edx, byte 0Eh
        mov edx, dword [SpeechBankBuffer]
        mov edx, dword [byte edx+ebx+02h]
        sar edx, 10h
        imul edx, byte 0Ch
        mov ebx, dword [SpeechClipTable]
        mov edx, dword [dword edx+ebx+02DCh]
.76:
        mov dword [dword eax+02BCh], edx
        mov ecx, dword [dword esp+0164h]
        inc ecx
        mov esi, dword [SpeechChainLen]
        mov dword [dword esp+0164h], ecx
        cmp ecx, esi
        jl short .108
.77:
        mov eax, 32h
        call ShowLoadingBar
        jmp short .111
.110:
        call CloseSpeechChannels
.111:
        call ServiceIdle
.112:
        mov edi, dword [SoundCardType]
        test edi, edi
        jne short .113
        mov eax, dword [SpeechBankBuffer]
        test eax, eax
        je short .113
        push eax
        call FreeMemBlock
        add esp, byte 4
        mov dword [SpeechBankBuffer], edi
.113:
        push ebp
        call FreeMemBlock
        add esp, byte 4
        cmp byte [dword esp+0B4h], 0
        je short .82
        lea eax, [dword esp+0B4h]
        push eax
        jmp short .83
.82:
        push byte 0
.83:
        call OpenResourceArchive
        add esp, byte 4
        call ServiceIdle
.114:
        add esp, 174h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        LD mov, eax, eax
%else
;-----------------------------------------------------------------------------
; InitSpeechBanks                                 43944  97 PC, low confidence
; From InitGameAudio: sets up the speech banks (TEMPBANK, EVENT.DAT,
; CBANK%03d.HDR, TEAM%04d.HDR, PBP, AUDPBP3.TSF, KTSF)
;-----------------------------------------------------------------------------
InitSpeechBanks:
        push dword 1A0h
        call __CHK
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, 178h
        cmp dword [SoundCardType], byte 0
        jne near .84
        mov eax, dword [gameopts]
        mov edx, dword [byte eax+01h]
        mov eax, dword [byte eax+01h]
        shl edx, 0Ch
        shl eax, 6
        shr edx, 1Ah
        shr eax, 1Ah
        mov dword [dword esp+0170h], edx
        mov dword [dword esp+016Ch], eax
        cmp edx, byte 0Eh
        jne short .1
        cmp eax, byte 0Fh
        je short .2
.1:
        cmp dword [dword esp+016Ch], byte 0Eh
        jne short .6
        cmp dword [dword esp+0170h], byte 0Fh
        jne short .6
.2:
        mov ebp, dword [dword esp+0170h]
        cmp ebp, byte 0Eh
        jne short .3
        mov dword [dword esp+0170h], 23h
        jmp short .4
.3:
        cmp ebp, byte 0Fh
        jne short .4
        mov dword [dword esp+0170h], 24h
.4:
        mov ecx, dword [dword esp+016Ch]
        cmp ecx, byte 0Eh
        jne short .5
        mov dword [dword esp+016Ch], 23h
        jmp short .6
.5:
        cmp ecx, byte 0Fh
        jne short .6
        mov dword [dword esp+016Ch], 24h
.6:
        xor eax, eax
        mov dword [SpeechBankBuffer], eax
        call CurrentArchiveName
        test eax, eax
        je short .7
        call CurrentArchiveName
        cmp byte [eax], 0
        je short .7
        call CurrentArchiveName
        mov edx, eax
        lea eax, [dword esp+0B4h]
        call strcpy_
        jmp short .8
.7:
        xor dh, dh
        mov byte [dword esp+0B4h], dh
.8:
        xor eax, eax
        xor edx, edx
        xor ebx, ebx
        mov dword [dword esp+0164h], eax
        jmp short .11
.9:
        cmp byte [dword ebx+HomeSpeechLoaded], 1
        ja short .10
        cmp dword [dword ebx+HomePlayerRecords], byte 0
        jne short .10
        inc edx
.10:
        mov ebp, dword [dword esp+0164h]
        inc ebp
        add ebx, 125h
        mov dword [dword esp+0164h], ebp
.11:
        mov esi, dword [ThreeStarsCount]
        mov ecx, dword [dword esp+0164h]
        sar esi, 10h
        cmp esi, ecx
        jg short .9
        xor esi, esi
        xor ebx, ebx
        mov dword [dword esp+0164h], esi
        jmp short .14
.12:
        cmp byte [dword ebx+HomeRosterData+1C52h], 1
        ja short .13
        cmp dword [dword ebx+HomeRosterData+1B94h], byte 0
        jne short .13
        inc edx
.13:
        mov ebp, dword [dword esp+0164h]
        inc ebp
        add ebx, 125h
        mov dword [dword esp+0164h], ebp
.14:
        mov esi, dword [HomeRosterData+1B90h]
        mov ecx, dword [dword esp+0164h]
        sar esi, 10h
        cmp esi, ecx
        jg short .12
        xor esi, esi
        xor ebx, ebx
        mov dword [dword esp+0164h], esi
        jmp short .17
.15:
        cmp byte [dword ebx+AwaySpeechLoaded], 1
        ja short .16
        cmp dword [dword ebx+AwayPlayerRecords], byte 0
        jne short .16
        inc eax
.16:
        mov ecx, dword [dword esp+0164h]
        inc ecx
        add ebx, 125h
        mov dword [dword esp+0164h], ecx
.17:
        mov ecx, dword [HomeInjuredCount]
        mov esi, dword [dword esp+0164h]
        sar ecx, 10h
        cmp ecx, esi
        jg short .15
        xor edi, edi
        xor ebx, ebx
        mov dword [dword esp+0164h], edi
        jmp short .20
.18:
        cmp byte [dword ebx+AwayRosterData+1C52h], 1
        ja short .19
        cmp dword [dword ebx+AwayRosterData+1B94h], byte 0
        jne short .19
        inc eax
.19:
        mov esi, dword [dword esp+0164h]
        inc esi
        add ebx, 125h
        mov dword [dword esp+0164h], esi
.20:
        mov ecx, dword [AwayRosterData+1B90h]
        mov esi, dword [dword esp+0164h]
        sar ecx, 10h
        cmp ecx, esi
        jg short .18
        lea esi, [eax+edx]
        push byte 20h
        lea eax, [nosplit esi*8+00h]
        push eax
        push str_TEMP
        call AllocMemData
        add esp, byte 0Ch
        mov ebx, eax
        mov dword [dword esp+0174h], eax
        test eax, eax
        je near .84
        shl esi, 2
        lea edi, [eax+esi]
        xor eax, eax
        mov esi, edi
        mov dword [dword esp+0164h], eax
        jmp short .23
.21:
        imul edx, ebp, dword 125h
        cmp byte [dword edx+HomeSpeechLoaded], 1
        ja short .22
        cmp dword [dword edx+HomePlayerRecords], byte 0
        jne short .22
        mov edx, dword [dword edx+HomeSpeechNames]
        add esi, byte 4
        mov dword [ebx], edx
        add ebx, byte 4
        mov dword [byte esi-04h], eax
        inc eax
.22:
        inc dword [dword esp+0164h]
.23:
        mov edx, dword [ThreeStarsCount]
        mov ebp, dword [dword esp+0164h]
        sar edx, 10h
        cmp edx, ebp
        jg short .21
        xor edx, edx
        mov dword [dword esp+0164h], edx
        lea edx, [nosplit eax*4+00h]
        mov ebx, dword [dword esp+0174h]
        lea esi, [edx+edi]
        add ebx, edx
        jmp short .26
.24:
        imul edx, ecx, dword 125h
        cmp byte [dword edx+HomeRosterData+1C52h], 1
        ja short .25
        cmp dword [dword edx+HomeRosterData+1B94h], byte 0
        jne short .25
        mov edx, dword [dword edx+HomeRosterData+1B98h]
        add esi, byte 4
        mov dword [ebx], edx
        add ebx, byte 4
        mov dword [byte esi-04h], eax
        inc eax
.25:
        inc dword [dword esp+0164h]
.26:
        mov edx, dword [HomeRosterData+1B90h]
        mov ecx, dword [dword esp+0164h]
        sar edx, 10h
        cmp edx, ecx
        jg short .24
        mov ebx, dword [dword esp+0174h]
        xor esi, esi
        lea edx, [nosplit eax*4+00h]
        mov dword [dword esp+0164h], esi
        lea esi, [edx+edi]
        add ebx, edx
        jmp short .29
.27:
        imul edx, ecx, dword 125h
        cmp byte [dword edx+AwaySpeechLoaded], 1
        ja short .28
        cmp dword [dword edx+AwayPlayerRecords], byte 0
        jne short .28
        mov edx, dword [dword edx+AwaySpeechNames]
        add esi, byte 4
        mov dword [ebx], edx
        add ebx, byte 4
        mov dword [byte esi-04h], eax
        inc eax
.28:
        inc dword [dword esp+0164h]
.29:
        mov edx, dword [HomeInjuredCount]
        mov ecx, dword [dword esp+0164h]
        sar edx, 10h
        cmp edx, ecx
        jg short .27
        xor esi, esi
        lea edx, [nosplit eax*4+00h]
        mov dword [dword esp+0164h], esi
        lea ebx, [edx+edi]
        mov esi, dword [dword esp+0174h]
        add esi, edx
        jmp short .32
.30:
        imul edx, ecx, dword 125h
        cmp byte [dword edx+AwayRosterData+1C52h], 1
        ja short .31
        cmp dword [dword edx+AwayRosterData+1B94h], byte 0
        jne short .31
        mov edx, dword [dword edx+AwayRosterData+1B98h]
        add ebx, byte 4
        mov dword [esi], edx
        add esi, byte 4
        mov dword [byte ebx-04h], eax
        inc eax
.31:
        inc dword [dword esp+0164h]
.32:
        mov edx, dword [AwayRosterData+1B90h]
        mov ecx, dword [dword esp+0164h]
        sar edx, 10h
        cmp edx, ecx
        jg short .30
        mov dword [SpeechClipIndex], eax
        mov eax, 13h
        call ShowLoadingBar
        push edi
        mov esi, dword [dword esp+0178h]
        push esi
        mov edi, dword [SpeechClipIndex]
        push edi
        call SortIndices
        add esp, byte 0Ch
        call ServiceIdle
        push byte 20h
        push dword 578h
        push str_TEMPBANK
        call AllocMemBlock
        mov dword [SpeechBankList], eax
        mov eax, dword [SpeechClipIndex]
        lea edi, [nosplit eax*8+00h]
        sub edi, eax
        imul eax, dword 307h
        mov edx, 56h
        add edi, edi
        add esp, byte 0Ch
        add edi, eax
        lea eax, [dword esp+0104h]
        call MakeDataPath
        lea eax, [dword esp+0104h]
        push eax
        call OpenResourceArchive
        add esp, byte 4
        push str_EVENTDAT
        call FileSizePath
        add esp, byte 4
        add edi, 81Ah
        mov dword [dword esp+0168h], eax
        test eax, eax
        je near .80
        xor ebx, ebx
        add edi, eax
        mov dword [dword esp+0164h], ebx
.33:
        mov ecx, dword [dword esp+0164h]
        push ecx
        push str_CBANK03dHDR
        lea eax, [dword esp+015Ch]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [dword esp+0154h]
        push eax
        call FileSizePath
        add esp, byte 4
        test eax, eax
        jle short .34
        mov edx, dword [dword esp+0164h]
        mov esi, dword [SpeechBankList]
        mov dword [esi+edx*8], 0FFFFFFFFh
        mov edx, dword [dword esp+0164h]
        mov esi, dword [SpeechBankList]
        lea ecx, [edi+ebx]
        add ebx, eax
        mov dword [byte esi+edx*8+04h], ecx
.34:
        mov esi, dword [dword esp+0164h]
        inc esi
        mov dword [dword esp+0164h], esi
        cmp esi, 0AFh
        jl short .33
        mov eax, dword [dword esp+0170h]
        push eax
        push str_TEAM04dHDR
        lea eax, [dword esp+015Ch]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [dword esp+0154h]
        push eax
        call FileSizePath
        add esp, byte 4
        test eax, eax
        jle short .35
        mov dword [SpeechBankHome], 0FFFFFFFFh
        lea edx, [edi+ebx]
        mov dword [SpeechBankHomeSize], edx
        add ebx, eax
.35:
        mov ecx, dword [dword esp+016Ch]
        push ecx
        push str_TEAM04dHDR
        lea eax, [dword esp+015Ch]
        push eax
        call sprintf_
        add esp, byte 0Ch
        lea eax, [dword esp+0154h]
        push eax
        call FileSizePath
        add esp, byte 4
        test eax, eax
        jle short .36
        lea edx, [edi+ebx]
        mov esi, 0FFFFFFFFh
        mov dword [SpeechBankAwaySize], edx
        mov dword [SpeechBankAway], esi
        add ebx, eax
.36:
        mov eax, dword [SpeechClipIndex]
        add edi, ebx
        add eax, 0AFh
        add edi, 8000h
        shl eax, 3
        add edi, eax
        call ServiceIdle
        mov eax, 14h
        call ShowLoadingBar
        push byte 0
        add edi, 578h
        push edi
        push str_PBP
        mov dword [SpeechBankCountFront], edi
        call AllocMemBlock
        xor edi, edi
        mov ebp, dword [SpeechClipIndex]
        add esp, byte 0Ch
        mov dword [SpeechBankBuffer], eax
        mov dword [dword esp+0164h], edi
        test ebp, ebp
        jle near .38
        mov esi, 0FFFFFFFFh
.37:
        mov eax, dword [SpeechClipIndex]
        mov edx, dword [dword esp+0164h]
        dec eax
        sub eax, edx
        imul edx, byte 0Eh
        mov ecx, dword [dword esp+0174h]
        shl eax, 2
        add ecx, eax
        mov eax, dword [SpeechBankBuffer]
        add edx, eax
        mov eax, dword [ecx]
        mov dword [edx], eax
        imul edx, dword [dword esp+0164h], byte 0Eh
        mov eax, dword [SpeechBankBuffer]
        mov word [byte edx+eax+04h], si
        imul eax, dword [dword esp+0164h], byte 0Eh
        mov edx, dword [SpeechBankBuffer]
        mov dword [byte edx+eax+06h], esi
        imul edx, dword [SpeechClipIndex], byte 0Eh
        mov eax, dword [SpeechBankBuffer]
        mov edi, dword [dword esp+0164h]
        lea ecx, [eax+edx]
        imul edx, edi, dword 307h
        add edx, ecx
        imul ecx, edi, byte 0Eh
        mov dword [byte ecx+eax+0Ah], edx
        mov eax, dword [dword esp+0164h]
        inc eax
        mov edx, dword [SpeechClipIndex]
        mov dword [dword esp+0164h], eax
        cmp eax, edx
        jl near .37
.38:
        imul eax, dword [SpeechClipIndex], dword 307h
        mov edx, dword [SpeechBankBuffer]
        mov edx, dword [byte edx+0Ah]
        xor esi, esi
        add edx, eax
        mov dword [dword esp+0164h], esi
        mov dword [SpeechClipTable], edx
        lea edi, [dword edx+081Ah]
.39:
        mov eax, dword [dword esp+0164h]
        mov edx, dword [SpeechBankList]
        shl eax, 3
        add eax, edx
        mov edx, dword [SpeechBankBuffer]
        add dword [byte eax+04h], edx
        mov eax, dword [dword esp+0164h]
        push eax
        push str_CBANK03dHDR
        lea eax, [dword esp+015Ch]
        push eax
        call sprintf_
        add esp, byte 0Ch
        call ServiceIdle
        mov eax, dword [dword esp+0164h]
        mov edx, dword [SpeechBankList]
        mov ecx, dword [byte edx+eax*8+04h]
        push ecx
        lea eax, [dword esp+0158h]
        push eax
        call LoadFileToBlockPlain
        add esp, byte 8
        test eax, eax
        je near .80
        mov esi, dword [dword esp+0164h]
        inc esi
        mov dword [dword esp+0164h], esi
        cmp esi, 0AFh
        jl short .39
        mov ecx, dword [dword esp+0170h]
        push ecx
        mov eax, dword [SpeechBankBuffer]
        mov edx, dword [SpeechBankHomeSize]
        push str_TEAM04dHDR
        add edx, eax
        lea eax, [dword esp+015Ch]
        push eax
        mov dword [SpeechBankHomeSize], edx
        call sprintf_
        add esp, byte 0Ch
        mov esi, dword [SpeechBankHomeSize]
        push esi
        lea eax, [dword esp+0158h]
        push eax
        call LoadFileToBlockPlain
        add esp, byte 8
        test eax, eax
        je near .80
        call ServiceIdle
        mov eax, dword [SpeechBankBuffer]
        mov ebp, dword [SpeechBankAwaySize]
        add ebp, eax
        mov eax, dword [dword esp+016Ch]
        push eax
        push str_TEAM04dHDR
        lea eax, [dword esp+015Ch]
        push eax
        mov dword [SpeechBankAwaySize], ebp
        call sprintf_
        add esp, byte 0Ch
        mov edx, dword [SpeechBankAwaySize]
        push edx
        lea eax, [dword esp+0158h]
        push eax
        call LoadFileToBlockPlain
        add esp, byte 8
        test eax, eax
        je near .80
        add ebx, dword [dword esp+0168h]
        call ServiceIdle
        lea eax, [edi+ebx]
        mov dword [SpeechBanksLoaded], eax
        add eax, 8000h
        mov dword [SpeechChainCount], eax
        mov eax, dword [SpeechClipIndex]
        add eax, 0AFh
        mov ebx, dword [SpeechChainCount]
        shl eax, 3
        push dword 578h
        add ebx, eax
        push ebx
        mov esi, dword [SpeechBankList]
        push esi
        call bcopy
        add esp, byte 0Ch
        mov ebp, dword [SpeechBankList]
        push ebp
        call FreeMemBlock
        add esp, byte 4
        mov eax, 16h
        mov dword [SpeechBankList], ebx
        call ShowLoadingBar
        mov eax, str_GAMEDATAAUDPBP3TSF
        call FileExists
        test eax, eax
        jne short .40
        mov ecx, 1
        jmp near .44
.40:
        call ServiceIdle
        mov edx, SpeechBankHandle
        mov eax, str_GAMEDATAAUDPBP3TSF
        mov ecx, 1
        call FileOpen
        test eax, eax
        je near .43
        mov eax, dword [SpeechBankHandle]
        call FileLength
        mov edx, eax
        lea eax, [dword esp+0164h]
        call SpeechFileHeader
        cmp edx, eax
        je short .41
        xor ecx, ecx
.41:
        test ecx, ecx
        je near .42
        mov ebx, 4
        lea edx, [dword esp+0154h]
        mov eax, dword [SpeechBankHandle]
        call FileReadRecord
        test eax, eax
        je near .43
        xor al, al
        mov edx, str_KTSF
        mov byte [dword esp+0158h], al
        lea eax, [dword esp+0154h]
        call strcmp_
        test eax, eax
        jne near .43
        mov ebx, 4
        lea edx, [dword esp+0164h]
        mov eax, dword [SpeechBankHandle]
        call FileReadRecord
        test eax, eax
        je short .43
        cmp dword [dword esp+0164h], 81Ah
        jne short .43
        mov ebx, 4
        lea edx, [dword esp+0164h]
        mov eax, dword [SpeechBankHandle]
        call FileReadRecord
        test eax, eax
        je short .43
        cmp dword [dword esp+0164h], 0AFh
        jne short .43
        mov ebx, 81Ah
        mov edx, dword [SpeechClipTable]
        mov eax, dword [SpeechBankHandle]
        call FileReadRecord
        test eax, eax
        je short .43
        xor ecx, ecx
        jmp short .43
.42:
        mov ecx, 1
.43:
        test ecx, ecx
        je short .44
        mov eax, SpeechBankHandle
        call FileClose
.44:
        test ecx, ecx
        je near .54
        mov eax, 2Eh
        xor edx, edx
        call LoadDataFile
        mov dword [FrontShapeFile], eax
        xor edx, edx
        mov eax, 2Fh
        call LoadDataFileLib
        push str_Remo
        mov ebx, dword [FrontShapeFile]
        push ebx
        mov dword [FrontTextFile], eax
        call FindShape
        add esp, byte 8
        push str_Mous
        mov ecx, dword [FrontShapeFile]
        push ecx
        mov ebx, eax
        call FindShape
        add esp, byte 8
        mov edx, ebx
        call CreateMenuBitmap
        call SetNormalText
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        mov ebp, 408Ch
        call SetTextColor
        mov dword [dword esp+0164h], ebp
        call CheckDiskSpace
        mov edx, eax
        mov eax, dword [GameSettings]
        mov esi, 0CCh
        shl eax, 1Ch
        mov ebx, dword [dword esp+0164h]
        shr eax, 1Eh
        cmp edx, ebx
        jge near .48
        cmp eax, byte 1
        jb short .46
        jbe short .45
        cmp eax, byte 2
        jne short .46
        call CheckDiskSpace
        mov edx, dword [dword esp+0164h]
        sub edx, eax
        push edx
        push str_DerHome
        jmp short .47
.45:
        call CheckDiskSpace
        mov edx, dword [dword esp+0164h]
        sub edx, eax
        push edx
        push str_PlayHome
        jmp short .47
.46:
        call CheckDiskSpace
        mov edx, dword [dword esp+0164h]
        sub edx, eax
        push edx
        push str_PlayByPlayNeedsToBeInstal
.47:
        lea eax, [byte esp+08h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        push byte 0
        mov ecx, 1
        lea eax, [byte esp+04h]
        xor ebx, ebx
        mov edx, ecx
        call ShowMessageBoxNoWait
        mov dl, byte [MusicOptions]
        and dl, 0F7h
        xor esi, esi
        mov byte [MusicOptions], dl
        jmp near .53
.48:
        cmp eax, byte 1
        jb short .50
        lea edx, [dword ebx-0400h]
        jbe short .49
        cmp eax, byte 2
        jne short .50
        push edx
        push str_DerAway
        jmp short .51
.49:
        push edx
        push str_PlayAway
        jmp short .51
.50:
        mov eax, dword [dword esp+0164h]
        sub eax, 400h
        push eax
        push str_PlayByPlayNeedsToBeInstal2
.51:
        lea eax, [byte esp+08h]
        push eax
        call sprintf_
        add esp, byte 0Ch
        push byte 1
        mov ecx, 1
        mov edx, 2
        lea eax, [byte esp+04h]
        xor ebx, ebx
        call ShowMessageBoxNoWait
        test eax, eax
        je near .52
        push byte 0FFFFFFFFh
        call MakeColor
        add esp, byte 4
        call SetTextColor
        mov edx, esi
        mov eax, str_InstallingPlayByPlay
        mov ebx, 1
        call ShowWorkingBox
        mov edx, 4
        lea eax, [dword esp+0B4h]
        call MakeDirPath
        mov edx, 4
        lea eax, [dword esp+0104h]
        xor ebx, ebx
        call MakeDirPath
        mov ebx, UpdateWorkingBox
        lea edx, [dword esp+0104h]
        lea eax, [dword esp+0B4h]
        call OpenSpeechBanks
        mov edx, eax
        mov esi, eax
        call HideWorkingBox
        test edx, edx
        je short .53
        mov edx, SpeechBankHandle
        mov eax, str_GAMEDATAAUDPBP3TSF
        call FileOpen
        mov esi, eax
        jmp short .53
.52:
        mov ah, byte [MusicOptions]
        and ah, 0F7h
        xor esi, esi
        mov byte [MusicOptions], ah
.53:
        call FreeMenuBitmap
        mov ecx, dword [FrontShapeFile]
        push ecx
        call FreeMemBlock
        add esp, byte 4
        mov eax, dword [FrontTextFile]
        xor ebp, ebp
        push eax
        mov dword [FrontShapeFile], ebp
        call FreeMemBlock
        add esp, byte 4
        mov dword [FrontTextFile], ebp
        test esi, esi
        je near .80
.54:
        mov eax, 18h
        mov edx, dword [dword esp+016Ch]
        call ShowLoadingBar
        call ServiceIdle
        mov eax, dword [dword esp+0170h]
        call LoadTeamSpeech
        call ServiceIdle
        mov eax, 1Ah
        xor ebx, ebx
        call ShowLoadingBar
        mov ecx, dword [SpeechClipIndex]
        mov dword [dword esp+0164h], ebx
        test ecx, ecx
        jle short .56
.55:
        call ServiceIdle
        mov eax, dword [dword esp+0164h]
        call LoadSpeechBank
        imul edx, dword [dword esp+0164h], byte 14h
        mov ebp, dword [SpeechClipIndex]
        mov eax, edx
        sar edx, 1Fh
        idiv ebp
        add eax, byte 1Ah
        call ShowLoadingBar
        mov eax, dword [dword esp+0164h]
        inc eax
        mov edx, dword [SpeechClipIndex]
        mov dword [dword esp+0164h], eax
        cmp eax, edx
        jl short .55
.56:
        mov eax, 2Eh
        mov edx, 0Ch
        call ShowLoadingBar
        mov eax, dword [SpeechBankHandle]
        call FileSeek
        test eax, eax
        jne short .57
        mov eax, SpeechBankHandle
        call FileClose
        jmp near .80
.57:
        mov ebx, 81Ah
        mov edx, dword [SpeechClipTable]
        mov eax, dword [SpeechBankHandle]
        call FileWriteRecord
        test eax, eax
        jne short .58
        mov eax, SpeechBankHandle
        call FileClose
        jmp near .80
.58:
        mov eax, SpeechBankHandle
        call FileClose
        call ServiceIdle
        mov eax, 30h
        call ShowLoadingBar
        mov eax, QueueSpeechChain_9C
        call InitSpeechChannels
        test eax, eax
        jl near .79
        mov edx, 56h
        lea eax, [dword esp+0104h]
        call MakeDataPath
        lea eax, [dword esp+0104h]
        push eax
        call OpenResourceArchive
        add esp, byte 4
        call ServiceIdle
        push edi
        push str_EVENTDAT
        call LoadFileToBlockPlain
        add esp, byte 8
        test eax, eax
        jne short .59
        call CloseSpeechChannels
        jmp near .80
.59:
        call ServiceIdle
        mov eax, edi
        call InitSpeechBank
        test eax, eax
        jne short .60
        call CloseSpeechChannels
        jmp near .80
.60:
        xor ebx, ebx
        call ServiceIdle
        mov dword [dword esp+0164h], ebx
        mov ebx, 2
.61:
        mov eax, dword [dword esp+0164h]
        mov eax, dword [nosplit eax*8+SpeechBankHomeSize]
        call RegisterSpeechBank
        mov edx, eax
        mov eax, dword [dword esp+0164h]
        mov ecx, edx
        mov dword [nosplit eax*8+SpeechBankHome], edx
        test ecx, ecx
        jge short .62
        mov dword [dword esp+0164h], ebx
.62:
        mov esi, dword [dword esp+0164h]
        inc esi
        mov dword [dword esp+0164h], esi
        cmp ebx, esi
        jg short .61
        cmp esi, byte 2
        je short .63
        mov dword [dword esp+0164h], 0B0h
        jmp short .64
.63:
        xor eax, eax
        mov dword [dword esp+0164h], eax
.64:
        mov ecx, 0AFh
.65:
        mov ebx, dword [dword esp+0164h]
        cmp ecx, ebx
        jle short .67
        mov eax, dword [SpeechBankList]
        mov edx, ebx
        mov eax, dword [byte eax+edx*8+04h]
        call RegisterSpeechBank
        mov ebx, dword [SpeechBankList]
        mov edx, eax
        mov eax, dword [dword esp+0164h]
        mov dword [ebx+eax*8], edx
        mov eax, dword [dword esp+0164h]
        mov ebx, edx
        mov edx, dword [SpeechChainCount]
        mov dword [edx+eax*4], ebx
        mov edx, dword [dword esp+0164h]
        mov eax, dword [SpeechClipIndex]
        add eax, edx
        mov edx, dword [SpeechChainCount]
        shl eax, 2
        add edx, eax
        mov eax, dword [dword esp+0164h]
        mov dword [dword edx+02BCh], eax
        mov edx, dword [SpeechBankList]
        cmp dword [edx+eax*8], byte 0
        jge short .66
        mov dword [dword esp+0164h], ecx
.66:
        inc dword [dword esp+0164h]
        jmp near .65
.67:
        call ServiceIdle
        mov eax, 31h
        call ShowLoadingBar
        cmp dword [dword esp+0164h], 0AFh
        jne near .78
        mov edx, GameSoundsOn
        mov eax, str_GAMEDATAAUDPBP3TSF
        call FileOpen
        test eax, eax
        je near .78
        call ResetSpeechQueue
        mov esi, 1
        mov eax, dword [SpeechClipIndex]
        xor edi, edi
        mov dword [SoundCardType], esi
        mov dword [SpeechBanksReady], edi
        mov dword [dword esp+0164h], edi
        test eax, eax
        jle near .71
        mov ecx, 0FFFFFFFFh
.68:
        mov edi, dword [dword esp+0164h]
        imul edx, edi, byte 0Eh
        mov eax, dword [SpeechBankBuffer]
        add eax, edx
        mov edx, dword [byte eax+02h]
        sar edx, 10h
        cmp edx, byte 0FFFFFFFFh
        je short .69
        mov eax, dword [byte eax+0Ah]
        call RegisterSpeechBank
        mov ebp, dword [dword esp+0164h]
        mov edx, eax
        imul eax, ebp, byte 0Eh
        mov ebx, dword [SpeechBankBuffer]
        mov dword [byte ebx+eax+06h], edx
        mov ebx, dword [dword esp+0164h]
        mov eax, dword [SpeechChainCount]
        mov dword [dword eax+ebx*4+02BCh], edx
        jmp short .70
.69:
        mov edx, dword [SpeechChainCount]
        mov eax, edi
        mov dword [dword edx+eax*4+02BCh], ecx
.70:
        mov edx, dword [dword esp+0164h]
        mov eax, dword [SpeechClipIndex]
        add eax, edx
        mov edx, dword [SpeechChainCount]
        shl eax, 2
        add eax, edx
        mov edx, dword [dword esp+0164h]
        add edx, 0AFh
        mov dword [dword eax+0578h], edx
        mov ebx, dword [dword esp+0164h]
        inc ebx
        mov esi, dword [SpeechClipIndex]
        mov dword [dword esp+0164h], ebx
        cmp ebx, esi
        jl near .68
.71:
        mov edx, dword [SpeechClipIndex]
        add edx, 0AFh
        mov eax, dword [SpeechChainCount]
        lea ebx, [nosplit edx*4+00h]
        add ebx, eax
        push ebx
        push eax
        push edx
        xor edi, edi
        call SortIndices
        mov ebx, dword [SpeechClipIndex]
        add esp, byte 0Ch
        add ebx, 0AFh
        mov dword [SpeechChainLen], edi
        shl ebx, 2
        xor eax, eax
        test ebx, ebx
        jle short .73
        mov edx, dword [SpeechChainCount]
.72:
        cmp dword [edx+eax], byte 0
        jl short .73
        mov ebp, dword [SpeechChainLen]
        inc ebp
        add eax, byte 4
        mov dword [SpeechChainLen], ebp
        cmp eax, ebx
        jl short .72
.73:
        call ServiceIdle
        xor esi, esi
        mov edi, dword [SpeechChainLen]
        mov dword [dword esp+0164h], esi
        test edi, edi
        jle near .77
.74:
        mov ebp, dword [dword esp+0164h]
        mov eax, dword [SpeechClipIndex]
        add eax, ebp
        mov edx, dword [SpeechChainCount]
        shl eax, 2
        add eax, edx
        mov edx, dword [dword eax+02BCh]
        cmp edx, 0AFh
        jge short .75
        mov ebx, dword [SpeechClipTable]
        mov edx, dword [ebx+edx*4]
        jmp short .76
.75:
        sub edx, 0AFh
        imul edx, byte 0Eh
        mov ebx, dword [SpeechBankBuffer]
        mov edx, dword [byte edx+ebx+02h]
        sar edx, 10h
        imul edx, byte 0Ch
        mov ebx, dword [SpeechClipTable]
        mov edx, dword [dword edx+ebx+02DCh]
.76:
        mov dword [dword eax+02BCh], edx
        mov ebx, dword [dword esp+0164h]
        inc ebx
        mov ecx, dword [SpeechChainLen]
        mov dword [dword esp+0164h], ebx
        cmp ebx, ecx
        jl short .74
.77:
        mov eax, 32h
        call ShowLoadingBar
        jmp short .79
.78:
        call CloseSpeechChannels
.79:
        call ServiceIdle
.80:
        mov esi, dword [SoundCardType]
        test esi, esi
        jne short .81
        mov edi, dword [SpeechBankBuffer]
        test edi, edi
        je short .81
        push edi
        call FreeMemBlock
        add esp, byte 4
        mov dword [SpeechBankBuffer], esi
.81:
        mov edx, dword [dword esp+0174h]
        push edx
        call FreeMemBlock
        add esp, byte 4
        cmp byte [dword esp+0B4h], 0
        je short .82
        lea eax, [dword esp+0B4h]
        push eax
        jmp short .83
.82:
        push byte 0
.83:
        call OpenResourceArchive
        add esp, byte 4
        call ServiceIdle
.84:
        add esp, 178h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
%endif
;-----------------------------------------------------------------------------
; CloseSpeechFile                                 44998  97 PC, low confidence
; Closes the speech file
;-----------------------------------------------------------------------------
CloseSpeechFile:
        push dword 1Ch
        call __CHK
        push ebx
        push ecx
        push edx
        push esi
        push edi
        cmp dword [SoundCardType], byte 0
        je short .2
        mov eax, GameSoundsOn
        call FileClose
        mov ebx, dword [SpeechBankBuffer]
        test ebx, ebx
        je short .1
        push ebx
        call FreeMemBlock
        xor esi, esi
        add esp, byte 4
        mov dword [SpeechBankBuffer], esi
.1:
        call CloseSpeechChannels
.2:
        xor edi, edi
        mov dword [SoundCardType], edi
        call ServiceIdle
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; SpeechClipLength                                449F0  97 PC, low confidence
; Returns the length of a speech clip
;-----------------------------------------------------------------------------
SpeechClipLength:
        push dword 28h
        call __CHK
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 4
        mov edi, edx
        mov ebp, ebx
        shl eax, 2
        xor ebx, ebx
        xor esi, esi
        mov dword [esp], eax
        jmp short .3
.1:
        mov eax, dword [byte eax+04h]
        mov eax, dword [ebx+eax]
        mov ecx, dword [byte eax+04h]
        push ecx
        mov edx, dword [eax]
        push edx
        push ebp
        push edi
        call SumRingRange
        add esp, byte 10h
        test eax, eax
        je short .2
        mov eax, 1
        jmp short .4
.2:
        inc esi
        add ebx, byte 4
.3:
        mov eax, dword [esp]
        mov eax, dword [dword eax+SpeechClipDefTable]
        cmp esi, dword [eax]
        jl short .1
        xor eax, eax
.4:
        add esp, byte 4
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; SayShotCall                                     44A50  97 PC, low confidence
; Picks the play-by-play call for a shot
;-----------------------------------------------------------------------------
SayShotCall:
        push dword 50h
        call __CHK
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 2Ch
        mov ebp, dword [byte esp+058h]
        mov dword [byte esp+024h], eax
        fld dword [byte esp+048h]
        fld dword [byte esp+04Ch]
        fld dword [byte esp+050h]
        fld dword [byte esp+054h]
        mov esi, 12C0h
        mov ecx, dword [byte esp+024h]
        fxch st3
        fadd qword [F64_0p5_SayShotCall]
        fxch st2
        fadd qword [F64_0p5_SayShotCall]
        fxch
        fadd qword [F64_0p5_SayShotCall]
        fxch st3
        fadd qword [F64_0p5_SayShotCall]
        fxch st2
        call __CHP
        fxch
        call __CHP
        fxch st3
        call __CHP
        fxch st2
        call __CHP
        fxch
        fistp dword [esp]
        fxch st2
        fistp dword [byte esp+04h]
        fistp dword [byte esp+08h]
        fistp dword [byte esp+028h]
        mov eax, dword [esp]
        mov edx, dword [byte esp+04h]
        mov edi, dword [byte esp+08h]
        add eax, 7F8h
        mov ebx, dword [byte esp+028h]
        mov dword [byte esp+01Ch], eax
        mov eax, 12C0h
        add edi, 7F8h
        sub eax, edx
        sub esi, ebx
        mov dword [byte esp+020h], eax
        test ecx, ecx
        je short .1
        cmp esi, 1830h
        jg short .2
.1:
        cmp dword [byte esp+024h], byte 0
        jne short .3
        cmp esi, 0D50h
        jge short .3
.2:
        mov dword [byte esp+014h], 1
        jmp short .4
.3:
        xor edx, edx
        mov dword [byte esp+014h], edx
.4:
        cmp dword [byte esp+024h], byte 0
        je short .5
        cmp esi, 0D50h
        jl short .6
.5:
        cmp dword [byte esp+024h], byte 0
        jne short .7
        cmp esi, 1830h
        jle short .7
.6:
        mov dword [byte esp+018h], 1
        jmp short .8
.7:
        xor edx, edx
        mov dword [byte esp+018h], edx
.8:
        cmp dword [byte esp+024h], byte 0
        je short .9
        cmp dword [byte esp+020h], 0D50h
        jl short .10
.9:
        cmp dword [byte esp+024h], byte 0
        jne short .11
        cmp dword [byte esp+020h], 1830h
        jle short .11
.10:
        mov dword [byte esp+010h], 1
        jmp short .12
.11:
        xor ecx, ecx
        mov dword [byte esp+010h], ecx
.12:
        mov edx, dword [byte esp+020h]
        mov ebx, esi
        mov ecx, dword [byte esp+01Ch]
        sub ebx, edx
        mov eax, edi
        push ebx
        sub eax, ecx
        push eax
        mov dword [byte ebp+00h], 0FFFFFFFFh
        call vecdist
        add esp, byte 8
        mov ecx, eax
        mov dword [byte esp+0Ch], eax
        call rand_
        mov edx, eax
        mov dword [byte esp+028h], 0Ah
        mov eax, edx
        sar edx, 1Fh
        idiv dword [byte esp+028h]
        cmp edx, byte 7
        jge near .23
        cmp ecx, 0F0h
        jle near .23
        test ebx, ebx
        jg short .13
        neg ebx
.13:
        mov ecx, dword [byte esp+01Ch]
        mov edx, edi
        sub edx, ecx
        test edx, edx
        jg short .14
        neg edx
.14:
        cmp ebx, edx
        jle short .18
        cmp dword [byte esp+024h], byte 0
        je short .15
        cmp esi, dword [byte esp+020h]
        jl short .16
.15:
        cmp dword [byte esp+024h], byte 0
        jne short .17
        cmp esi, dword [byte esp+020h]
        jle short .17
.16:
        mov eax, dword [byte esp+060h]
        mov dword [eax], 1
        jmp near .24
.17:
        mov eax, dword [byte esp+060h]
        mov dword [eax], 3
        jmp short .24
.18:
        call rand_
        mov edx, eax
        mov ebx, 0Ah
        sar edx, 1Fh
        idiv ebx
        cmp edx, byte 4
        jge short .19
        mov eax, dword [byte esp+060h]
        mov dword [eax], 2
        jmp short .24
.19:
        cmp dword [byte esp+024h], byte 0
        je short .20
        cmp edi, dword [byte esp+01Ch]
        jl short .21
.20:
        cmp dword [byte esp+024h], byte 0
        jne short .22
        cmp edi, dword [byte esp+01Ch]
        jle short .22
.21:
        mov eax, dword [byte esp+060h]
        mov dword [eax], 4
        jmp short .24
.22:
        mov eax, dword [byte esp+060h]
        mov dword [eax], 5
        jmp short .24
.23:
        mov eax, dword [byte esp+060h]
        mov dword [eax], 0
.24:
        cmp dword [byte esp+0Ch], 4B0h
        jge short .25
        mov eax, dword [byte esp+064h]
        mov dword [eax], 1
        jmp short .26
.25:
        mov eax, dword [byte esp+064h]
        mov dword [eax], 0
        call rand_
        mov edx, eax
        mov ebx, 0Ah
        sar edx, 1Fh
        idiv ebx
        cmp edx, byte 5
        jge short .26
        mov eax, dword [byte esp+064h]
        mov dword [eax], 2
.26:
        cmp dword [byte esp+014h], byte 0
        jne near .33
        cmp dword [byte esp+018h], byte 0
        jne near .33
        mov eax, 5
        mov ebx, esi
        mov edx, edi
        mov dword [byte ebp+00h], 9
        call SpeechClipLength
        test eax, eax
        je short .30
        call rand_
        mov edx, eax
        mov ebx, 2
        sar edx, 1Fh
        idiv ebx
        test edx, edx
        je short .30
        cmp dword [byte esp+024h], byte 0
        je short .27
        cmp esi, 12C0h
        jl short .28
.27:
        cmp dword [byte esp+024h], byte 0
        jne short .29
        cmp esi, 12C0h
        jle short .29
.28:
        mov dword [byte ebp+00h], 2
        jmp near .33
.29:
        mov dword [byte ebp+00h], 4
        jmp short .33
.30:
        mov eax, 0Ah
        mov ebx, esi
        mov edx, edi
        call SpeechClipLength
        test eax, eax
        je short .31
        call rand_
        mov edx, eax
        mov ebx, 0Ah
        sar edx, 1Fh
        idiv ebx
        cmp edx, byte 6
        jle short .31
        mov dword [byte ebp+00h], 0Bh
        jmp short .33
.31:
        mov eax, 3
        mov ebx, esi
        mov edx, edi
        call SpeechClipLength
        test eax, eax
        je short .33
        mov eax, 4
        mov ebx, esi
        mov edx, edi
        call SpeechClipLength
        test eax, eax
        je short .32
        mov dword [byte ebp+00h], 1
        jmp short .33
.32:
        mov dword [byte ebp+00h], eax
.33:
        cmp dword [byte ebp+00h], byte 0
        jge near .48
        cmp dword [byte esp+014h], byte 0
        je near .38
        mov eax, 5
        mov ebx, esi
        mov edx, edi
        mov dword [byte ebp+00h], 7
        call SpeechClipLength
        test eax, eax
        je short .34
        call rand_
        mov edx, eax
        mov ebx, 14h
        sar edx, 1Fh
        idiv ebx
        cmp edx, byte 8
        jge short .34
        mov dword [byte ebp+00h], 4
        jmp near .48
.34:
        mov eax, 8
        mov ebx, esi
        mov edx, edi
        call SpeechClipLength
        test eax, eax
        je short .35
        mov dword [byte ebp+00h], 8
        jmp near .48
.35:
        mov eax, 0Bh
        mov ebx, esi
        mov edx, edi
        call SpeechClipLength
        test eax, eax
        je short .36
        mov dword [byte ebp+00h], 0Ch
        jmp near .48
.36:
        mov eax, 0Ch
        mov ebx, esi
        mov edx, edi
        call SpeechClipLength
        test eax, eax
        je short .37
        mov dword [byte ebp+00h], 0Dh
        jmp near .48
.37:
        call rand_
        mov edx, eax
        mov ebx, 2
        sar edx, 1Fh
        idiv ebx
        test edx, edx
        je near .48
        mov eax, 0Ah
        mov ebx, esi
        mov edx, edi
        call SpeechClipLength
        test eax, eax
        jne near .47
        mov eax, 7
        mov ebx, esi
        mov edx, edi
        call SpeechClipLength
        test eax, eax
        je near .48
        mov dword [byte ebp+00h], 5
        jmp near .48
.38:
        mov eax, 5
        mov ebx, esi
        mov edx, edi
        mov dword [byte ebp+00h], 0Eh
        call SpeechClipLength
        test eax, eax
        je short .39
        mov eax, dword [byte esp+060h]
        cmp dword [eax], byte 3
        jne short .39
        call rand_
        mov edx, eax
        mov ebx, 14h
        sar edx, 1Fh
        idiv ebx
        cmp edx, byte 8
        jge short .39
        mov dword [byte ebp+00h], 2
        jmp near .48
.39:
        mov eax, 9
        mov ebx, esi
        mov edx, edi
        call SpeechClipLength
        test eax, eax
        je short .40
        mov dword [byte ebp+00h], 0Ah
        jmp near .48
.40:
        mov eax, 7
        mov ebx, esi
        mov edx, edi
        call SpeechClipLength
        test eax, eax
        je short .42
        call rand_
        mov edx, eax
        mov ebx, 2
        sar edx, 1Fh
        idiv ebx
        test edx, edx
        je short .41
        mov dword [byte ebp+00h], 5
        jmp near .48
.41:
        mov dword [byte ebp+00h], 6
        jmp near .48
.42:
        mov eax, 6
        mov ebx, esi
        mov edx, edi
        call SpeechClipLength
        test eax, eax
        je short .43
        mov eax, dword [byte esp+060h]
        mov edx, dword [eax]
        cmp edx, byte 3
        jne short .43
        mov dword [byte ebp+00h], edx
        jmp near .48
.43:
        mov eax, 8
        mov ebx, esi
        mov edx, edi
        call SpeechClipLength
        test eax, eax
        je short .44
        mov dword [byte ebp+00h], 8
        jmp short .48
.44:
        mov eax, 0Bh
        mov ebx, esi
        mov edx, edi
        call SpeechClipLength
        test eax, eax
        je short .45
        mov dword [byte ebp+00h], 0Ch
        jmp short .48
.45:
        mov eax, 0Ch
        mov ebx, esi
        mov edx, edi
        call SpeechClipLength
        test eax, eax
        je short .46
        mov dword [byte ebp+00h], 0Dh
        jmp short .48
.46:
        mov eax, 0Ah
        mov ebx, esi
        mov edx, edi
        call SpeechClipLength
        test eax, eax
        je short .48
        mov eax, dword [byte esp+060h]
        cmp dword [eax], byte 3
        je short .48
.47:
        mov dword [byte ebp+00h], 0Bh
.48:
        mov eax, dword [byte esp+05Ch]
        cmp dword [eax], 2000h
        jne near .55
        mov ebx, dword [byte esp+020h]
        mov edx, dword [byte esp+01Ch]
        mov dword [eax], 0
        xor eax, eax
        call SpeechClipLength
        test eax, eax
        je short .49
        mov ebx, esi
        mov edx, edi
        xor eax, eax
        call SpeechClipLength
        test eax, eax
        jne short .50
.49:
        mov ebx, dword [byte esp+020h]
        mov edx, dword [byte esp+01Ch]
        mov eax, 1
        call SpeechClipLength
        test eax, eax
        je short .51
        mov eax, 1
        mov ebx, esi
        mov edx, edi
        call SpeechClipLength
        test eax, eax
        je short .51
.50:
        mov eax, dword [byte esp+05Ch]
        mov dword [eax], 5
        jmp near .58
.51:
        cmp dword [byte esp+018h], byte 0
        je short .52
        cmp dword [byte esp+010h], byte 0
        jne short .52
        call rand_
        mov edx, eax
        mov ebx, 14h
        sar edx, 1Fh
        idiv ebx
        cmp edx, byte 6
        jle short .52
        mov eax, dword [byte esp+05Ch]
        mov dword [eax], 1
        add esp, byte 2Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 20h
.52:
        mov eax, 0Ah
        mov ebx, esi
        mov edx, edi
        call SpeechClipLength
        test eax, eax
        je short .53
        mov ebx, dword [byte esp+020h]
        mov edx, dword [byte esp+01Ch]
        mov eax, 0Ah
        call SpeechClipLength
        test eax, eax
        je short .53
        mov eax, dword [byte esp+060h]
        cmp dword [eax], byte 1
        jne short .53
        mov eax, dword [byte esp+05Ch]
        mov dword [eax], 4
        add esp, byte 2Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 20h
.53:
        mov eax, dword [byte esp+060h]
        cmp dword [eax], byte 1
        jne near .58
        call rand_
        mov edx, eax
        mov ebx, 14h
        sar edx, 1Fh
        idiv ebx
        cmp edx, byte 0Dh
        jle near .58
        call rand_
        mov edx, eax
        mov ebx, 2
        sar edx, 1Fh
        idiv ebx
        test edx, edx
        je short .54
        mov eax, dword [byte esp+05Ch]
        mov dword [eax], 6
        add esp, byte 2Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 20h
.54:
        mov eax, dword [byte esp+05Ch]
        mov dword [eax], 3
        add esp, byte 2Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 20h
.55:
        mov eax, dword [byte esp+060h]
        mov dword [eax], 0
        mov eax, dword [byte esp+064h]
        mov dword [eax], 0
        mov eax, dword [byte esp+05Ch]
        mov esi, dword [eax]
        cmp esi, 2001h
        jne short .56
        mov dword [eax], 2
        add esp, byte 2Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 20h
.56:
        cmp esi, 2002h
        jne short .57
        mov dword [eax], 7
        add esp, byte 2Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 20h
.57:
        mov dword [eax], 0
.58:
        add esp, byte 2Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 20h
;-----------------------------------------------------------------------------
; SaySaveCall                                     4518C  97 PC, low confidence
; Picks the play-by-play call for a save
;-----------------------------------------------------------------------------
SaySaveCall:
        push dword 28h
        call __CHK
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 0Ch
        mov edi, eax
        fld dword [byte esp+028h]
        fld dword [byte esp+02Ch]
        mov ecx, 12C0h
        fxch
        fadd qword [F64_0p5_SaySaveCall]
        fxch
        fadd qword [F64_0p5_SaySaveCall]
        fxch
        call __CHP
        fxch
        call __CHP
        fxch
        fistp dword [esp]
        fistp dword [byte esp+04h]
        mov esi, dword [esp]
        mov edx, dword [byte esp+04h]
        add esi, 7F8h
        sub ecx, edx
        test eax, eax
        je short .1
        cmp ecx, 1830h
        jg short .2
.1:
        test edi, edi
        jne short .3
        cmp ecx, 0D50h
        jge short .3
.2:
        mov ebp, 1
        jmp short .4
.3:
        xor ebp, ebp
.4:
        test edi, edi
        je short .5
        cmp ecx, 0D50h
        jl short .6
.5:
        test edi, edi
        jne short .7
        cmp ecx, 1830h
        jle short .7
.6:
        mov dword [byte esp+08h], 1
        jmp short .8
.7:
        xor ebx, ebx
        mov dword [byte esp+08h], ebx
.8:
        mov eax, 3
        mov ebx, ecx
        mov edx, esi
        call SpeechClipLength
        test eax, eax
        je short .11
        call rand_
        mov edx, eax
        mov ecx, 2
        sar edx, 1Fh
        idiv ecx
        test edx, edx
        je short .10
.9:
        mov eax, 9
        jmp near .27
.10:
        xor eax, eax
        jmp near .27
.11:
        test ebp, ebp
        je short .12
        mov eax, 7
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 8
.12:
        cmp dword [byte esp+08h], byte 0
        jne short .15
        test edi, edi
        je short .13
        cmp ecx, 12C0h
        jl short .14
.13:
        test edi, edi
        jne short .9
        cmp ecx, 12C0h
        jle short .9
.14:
        mov eax, 5
        mov ebx, ecx
        mov edx, esi
        call SpeechClipLength
        test eax, eax
        je short .9
        mov eax, 2
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 8
.15:
        mov eax, 7
        mov ebx, ecx
        mov edx, esi
        call SpeechClipLength
        test eax, eax
        je short .17
        mov eax, 9
        mov ebx, ecx
        mov edx, esi
        call SpeechClipLength
        test eax, eax
        je short .16
        call rand_
        mov edx, eax
        mov ecx, 0Ah
        sar edx, 1Fh
        idiv ecx
        cmp edx, byte 4
        jge short .16
        mov eax, ecx
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 8
.16:
        mov eax, 13h
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 8
.17:
        mov eax, 9
        mov ebx, ecx
        mov edx, esi
        call SpeechClipLength
        test eax, eax
        je short .18
        mov eax, 0Ah
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 8
.18:
        mov eax, 6
        mov ebx, ecx
        mov edx, esi
        call SpeechClipLength
        test eax, eax
        je near .25
        call rand_
        mov edx, eax
        mov ebp, 3
        sar edx, 1Fh
        idiv ebp
        cmp edx, byte 2
        jne near .24
        mov eax, 5
        mov ebx, ecx
        mov edx, esi
        call SpeechClipLength
        test eax, eax
        je short .19
        call rand_
        mov edx, eax
        mov ecx, 2
        sar edx, 1Fh
        idiv ecx
        test edx, edx
        je short .19
        mov eax, ecx
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 8
.19:
        lea eax, [dword esi-07F8h]
        test eax, eax
        jg short .20
        neg eax
.20:
        cmp eax, 1E0h
        jle short .24
        cmp esi, 7F8h
        jge short .21
        test edi, edi
        jne short .22
.21:
        cmp esi, 7F8h
        jle short .23
        test edi, edi
        jne short .23
.22:
        mov eax, 12h
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 8
.23:
        mov eax, 11h
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 8
.24:
        mov eax, 3
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 8
.25:
        mov eax, 5
        mov ebx, ecx
        mov edx, esi
        call SpeechClipLength
        test eax, eax
        je short .26
        mov eax, 2
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 8
.26:
        mov eax, 10h
.27:
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret 8
        db 090h
;-----------------------------------------------------------------------------
; SayPassCall                                     45430  97 PC, low confidence
; Picks the play-by-play call for a pass
;-----------------------------------------------------------------------------
SayPassCall:
        push dword 14h
        call __CHK
        push ecx
        push esi
        push edi
        push ebp
        mov ebp, eax
        mov esi, edx
        mov ecx, ebx
        test eax, eax
        je short .1
        cmp ebx, 1830h
        jg short .2
.1:
        test ebp, ebp
        jne short .3
        cmp ecx, 0D50h
        jge short .3
.2:
        mov eax, 1
        jmp short .4
.3:
        xor eax, eax
.4:
        test ebp, ebp
        je short .5
        cmp ecx, 0D50h
        jl short .6
.5:
        test ebp, ebp
        jne short .7
        cmp ecx, 1830h
        jle short .7
.6:
        mov edi, 1
        jmp short .8
.7:
        xor edi, edi
.8:
        test eax, eax
        jne near .13
        test edi, edi
        jne near .13
        mov eax, 5
        mov ebx, ecx
        mov edx, esi
        mov edi, 9
        call SpeechClipLength
        test eax, eax
        je short .11
        test ebp, ebp
        je short .9
        cmp ecx, 12C0h
        jl short .10
.9:
        test ebp, ebp
        jne near .20
        cmp ecx, 12C0h
        jle near .20
.10:
        mov edi, 2
        jmp near .23
.11:
        mov eax, 0Ah
        mov ebx, ecx
        mov edx, esi
        call SpeechClipLength
        test eax, eax
        jne near .22
        mov eax, 3
        mov ebx, ecx
        mov edx, esi
        call SpeechClipLength
        test eax, eax
        je near .23
        mov eax, 4
        mov ebx, ecx
        mov edx, esi
        call SpeechClipLength
        test eax, eax
        je short .12
        mov edi, 1
        mov eax, edi
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.12:
        xor edi, edi
        mov eax, edi
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.13:
        mov eax, 8
        mov ebx, ecx
        mov edx, esi
        call SpeechClipLength
        test eax, eax
        je short .14
        mov edi, 8
        mov eax, edi
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.14:
        mov eax, 0Bh
        mov ebx, ecx
        mov edx, esi
        call SpeechClipLength
        test eax, eax
        je short .15
        mov edi, 0Ch
        mov eax, edi
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.15:
        mov eax, 0Ch
        mov ebx, ecx
        mov edx, esi
        call SpeechClipLength
        test eax, eax
        je short .16
        mov edi, 0Dh
        mov eax, edi
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.16:
        mov eax, 7
        mov ebx, ecx
        mov edx, esi
        call SpeechClipLength
        test eax, eax
        je short .17
        mov edi, 5
        mov eax, edi
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.17:
        test edi, edi
        je short .19
        mov eax, 9
        mov ebx, ecx
        mov edx, esi
        mov edi, 0Eh
        call SpeechClipLength
        test eax, eax
        je short .18
        mov edi, 0Ah
        mov eax, edi
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.18:
        mov eax, 6
        mov ebx, ecx
        mov edx, esi
        call SpeechClipLength
        test eax, eax
        je short .23
        mov edi, 3
        mov eax, edi
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.19:
        mov eax, 5
        mov ebx, ecx
        mov edx, esi
        mov edi, 7
        call SpeechClipLength
        test eax, eax
        je short .21
.20:
        mov edi, 4
        mov eax, edi
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
.21:
        mov eax, 0Ah
        mov ebx, ecx
        mov edx, esi
        call SpeechClipLength
        test eax, eax
        je short .23
.22:
        mov edi, 0Bh
.23:
        mov eax, edi
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
;-----------------------------------------------------------------------------
; SpeechTableEntry                                45628  97 PC, low confidence
; Returns a speech table entry
;-----------------------------------------------------------------------------
SpeechTableEntry:
        push dword 4
        call __CHK
        test eax, eax
        jl short .1
        cmp eax, byte 16h
        jge short .1
        mov eax, dword [nosplit eax*4+SpeechTableNames]
        ret
.1:
        mov eax, dword [SpeechTableError]
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; SayPlayerCall                                   4564C  97 PC, low confidence
; Picks the play-by-play call for a player
;-----------------------------------------------------------------------------
SayPlayerCall:
        push dword 2Ch
        call __CHK
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 0Ch
        mov edi, eax
        mov ecx, edx
        fld dword [byte esp+024h]
        fld dword [byte esp+028h]
        xor edx, edx
        mov esi, 12C0h
        mov dword [byte esp+08h], edx
        fxch
        fadd qword [F64_0p5_SayPlayerCall]
        fxch
        fadd qword [F64_0p5_SayPlayerCall]
        fxch
        call __CHP
        fxch
        call __CHP
        fxch
        fistp dword [esp]
        fistp dword [byte esp+04h]
        mov ebx, dword [byte esp+04h]
        mov ebp, dword [esp]
        sub esi, ebx
        add ebp, 7F8h
        mov ebx, esi
        mov edx, ebp
        call SayPassCall
        mov edx, dword [byte esp+030h]
        mov dword [edx], eax
        mov edx, dword [byte esp+03Ch]
        mov dword [edx], 0
        mov edx, dword [PlayerCallLast]
        mov ebx, eax
        cmp ecx, edx
        je short .1
        mov dword [PlayerCallTime], eax
        mov dword [PlayerCallLast], ecx
        mov dword [nosplit eax*4+PlayerCallClips], ebp
        mov dword [nosplit eax*4+PlayerCallTimes], esi
        mov eax, dword [tickcount]
        xor edi, edi
        mov dword [PlayerCallStart], eax
        mov dword [byte esp+08h], edi
        mov dword [PlayerCallClip], edi
        jmp near .15
.1:
        mov ecx, dword [PlayerCallTime]
        cmp eax, ecx
        je near .15
        mov edx, dword [byte esp+02Ch]
        mov dword [edx], ecx
        mov eax, dword [tickcount]
        sub eax, dword [PlayerCallStart]
        cmp eax, 8Ch
        jle short .2
        mov eax, dword [PlayerCallTime]
        mov ecx, esi
        sub ecx, dword [nosplit eax*4+PlayerCallTimes]
        mov edx, dword [nosplit eax*4+PlayerCallClips]
        mov eax, ebp
        push ecx
        sub eax, edx
        push eax
        call vecdist
        add esp, byte 8
        cmp eax, 300h
        jle short .2
        mov eax, dword [tickcount]
        mov ecx, 1
        mov dword [PlayerCallStart], eax
        mov eax, dword [PlayerCallClip]
        add eax, ecx
        mov dword [byte esp+08h], ecx
        mov dword [PlayerCallClip], eax
        cmp eax, byte 3
        jle short .2
        mov eax, dword [byte esp+03Ch]
        mov dword [eax], ecx
.2:
        cmp dword [byte esp+08h], byte 0
        je near .15
        mov eax, dword [byte esp+034h]
        mov dword [eax], 0
        mov eax, dword [PlayerCallTime]
        mov edx, dword [nosplit eax*4+PlayerCallTimes]
        mov eax, esi
        sub eax, edx
        test eax, eax
        jle short .3
        mov ecx, eax
        jmp short .4
.3:
        mov ecx, eax
        neg ecx
.4:
        mov eax, dword [PlayerCallTime]
        mov edx, ebp
        sub edx, dword [nosplit eax*4+PlayerCallClips]
        mov eax, edx
        test edx, edx
        jg short .5
        neg eax
.5:
        cmp ecx, eax
        jle near .11
        test edi, edi
        je short .6
        mov eax, dword [PlayerCallTime]
        cmp esi, dword [nosplit eax*4+PlayerCallTimes]
        jg short .7
.6:
        test edi, edi
        jne near .10
        mov eax, dword [PlayerCallTime]
        cmp esi, dword [nosplit eax*4+PlayerCallTimes]
        jge short .10
.7:
        mov eax, dword [byte esp+034h]
        mov dword [eax], 1
        test edi, edi
        je short .8
        mov eax, dword [PlayerCallTime]
        cmp dword [nosplit eax*4+PlayerCallTimes], 0D50h
        jle short .8
        cmp esi, 0D50h
        jl short .9
.8:
        test edi, edi
        jne short .12
        mov eax, dword [PlayerCallTime]
        cmp dword [nosplit eax*4+PlayerCallTimes], 1830h
        jge short .12
        cmp esi, 1830h
        jle short .12
.9:
        mov eax, dword [byte esp+034h]
        mov dword [eax], 6
        jmp short .12
.10:
        mov eax, dword [byte esp+034h]
        mov dword [eax], 3
        jmp short .12
.11:
        mov eax, dword [byte esp+034h]
        mov dword [eax], 2
.12:
        mov eax, dword [byte esp+038h]
        mov dword [eax], 4
        mov eax, dword [byte esp+030h]
        cmp dword [eax], byte 0Eh
        jne near .15
        test edi, edi
        je short .13
        cmp esi, 210h
        jle short .13
        lea eax, [dword esi-0210h]
        push eax
        mov eax, 7F8h
        sub eax, ebp
        push eax
        call vecdist
        mov edi, eax
        mov eax, dword [PlayerCallTime]
        mov ecx, dword [nosplit eax*4+PlayerCallTimes]
        add esp, byte 8
        sub ecx, 210h
        mov edx, 7F8h
        push ecx
        mov ecx, dword [nosplit eax*4+PlayerCallClips]
        mov eax, edx
        sub eax, ecx
        push eax
        call vecdist
        add esp, byte 8
        cmp edi, eax
        jae short .15
        jmp short .14
.13:
        test edi, edi
        jne short .15
        cmp esi, 2370h
        jge short .15
        mov eax, 2370h
        sub eax, esi
        push eax
        lea eax, [dword ebp-07F8h]
        push eax
        call vecdist
        mov edi, eax
        mov eax, dword [PlayerCallTime]
        mov ecx, 2370h
        mov edx, dword [nosplit eax*4+PlayerCallTimes]
        add esp, byte 8
        sub ecx, edx
        mov eax, dword [nosplit eax*4+PlayerCallClips]
        push ecx
        sub eax, 7F8h
        push eax
        call vecdist
        add esp, byte 8
        cmp edi, eax
        jae short .15
.14:
        mov eax, dword [byte esp+030h]
        mov dword [eax], 14h
.15:
        cmp dword [byte esp+08h], byte 0
        je short .16
        mov dword [PlayerCallTime], ebx
        mov dword [nosplit ebx*4+PlayerCallClips], ebp
        mov dword [nosplit ebx*4+PlayerCallTimes], esi
.16:
        mov eax, dword [byte esp+08h]
        add esp, byte 0Ch
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret 1Ch
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; SayRandomFiller                                 45954  97 PC, low confidence
; Picks a random filler call
;-----------------------------------------------------------------------------
SayRandomFiller:
        push dword 14h
        call __CHK
        push ebx
        push edx
        sub esp, byte 8
        fld dword [byte esp+014h]
        fld dword [byte esp+018h]
        mov edx, 12C0h
        fxch
        fadd qword [F64_0p5_SayRandomFiller]
        fxch
        fadd qword [F64_0p5_SayRandomFiller]
        fxch
        call __CHP
        fxch
        call __CHP
        fxch
        fistp dword [esp]
        fistp dword [byte esp+04h]
        mov eax, dword [esp]
        mov ebx, dword [byte esp+04h]
        add eax, 7F8h
        sub edx, ebx
        cmp eax, 7F8h
        jge short .3
        cmp edx, 1350h
        jle short .1
        cmp edx, 17D0h
        jl short .2
.1:
        cmp edx, 1230h
        jge short .3
        cmp edx, 0DB0h
        jle short .3
.2:
        mov eax, 1
        jmp short .5
.3:
        call rand_
        mov edx, eax
        mov ebx, 3
        sar edx, 1Fh
        idiv ebx
        cmp edx, byte 1
        jle short .4
        mov eax, ebx
        add esp, byte 8
        pop edx
        pop ebx
        ret 8
.4:
        mov eax, 2
.5:
        add esp, byte 8
        pop edx
        pop ebx
        ret 8
;-----------------------------------------------------------------------------
; SpeechClipExists                                45A00  97 PC, low confidence
; Returns whether a speech clip exists
;-----------------------------------------------------------------------------
SpeechClipExists:
        push dword 8
        call __CHK
        push edx
        test eax, eax
        je short .1
        cmp dword [eax], byte 0
        je short .2
.1:
        mov eax, 0FFFFFFFFh
        pop edx
        ret
.2:
        mov eax, dword [byte eax+04h]
        call FindSpeechClip
        mov edx, eax
        test eax, eax
        jl short .3
        shl eax, 3
        sub eax, edx
        mov edx, dword [SpeechBankBuffer]
        mov eax, dword [byte edx+eax*2+06h]
.3:
        pop edx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; SpeechEventKind                                 45A3C  97 PC, low confidence
; Returns the kind of a speech event
;-----------------------------------------------------------------------------
SpeechEventKind:
        push dword 4
        call __CHK
        cmp eax, 1000h
        je short .2
        cmp eax, 1002h
        jne short .1
        mov eax, 2
        ret
.1:
        mov eax, 1
        ret
.2:
        xor eax, eax
        ret
        db 090h
CommentaryEventJumpTable:                       ; jump table for the switch cases of CommentaryEvent
        dd CommentaryEvent_135
        dd CommentaryEvent_135
        dd CommentaryEvent_2DE
        dd CommentaryEvent_36D
        dd CommentaryEvent_66
        dd CommentaryEvent_48A
        dd CommentaryEvent_58C
        dd CommentaryEvent_654
        dd CommentaryEvent_726
        dd CommentaryEvent_7BF
        dd CommentaryEvent_8D6
        dd CommentaryEvent_96F
        dd CommentaryEvent_A08
        dd CommentaryEvent_A84
        dd CommentaryEvent_B1D
        dd CommentaryEvent_BB6
        dd CommentaryEvent_C68
        dd CommentaryEvent_D2A
        dd CommentaryEvent_D86
        dd CommentaryEvent_E79
        dd CommentaryEvent_F12
        dd CommentaryEvent_FDD
        dd CommentaryEvent_1084
        dd CommentaryEvent_111C
        dd CommentaryEvent_11C5
        dd CommentaryEvent_1293
        dd CommentaryEvent_1500
        dd CommentaryEvent_16BA
        dd CommentaryEvent_1771
        dd CommentaryEvent_17AA
        dd CommentaryEvent_17E6
        dd CommentaryEvent_1871
        dd CommentaryEvent_1931
        dd CommentaryEvent_19C8
        dd CommentaryEvent_1A44
        dd CommentaryEvent_1B16
        dd CommentaryEvent_1B57
        dd CommentaryEvent_1B97
        dd CommentaryEvent_1BF5
        dd CommentaryEvent_1C3D
        dd CommentaryEvent_1CB2
        dd CommentaryEvent_1DD1
        dd CommentaryEvent_1E49
        dd CommentaryEvent_1ECB
        dd CommentaryEvent_1F28
        dd CommentaryEvent_1F56
        dd CommentaryEvent_1FE8
Commentary3000JumpTable:                        ; jump table for the switch cases of CommentaryEvent
        dd CommentaryEvent_423
        dd CommentaryEvent_3F6
        dd CommentaryEvent_3FF
        dd CommentaryEvent_408
        dd CommentaryEvent_411
        dd CommentaryEvent_41A
Commentary4000JumpTable:                        ; jump table for the switch cases of CommentaryEvent
        dd CommentaryEvent_4E4
        dd CommentaryEvent_4ED
        dd CommentaryEvent_4F6
        dd CommentaryEvent_4FF
        dd CommentaryEvent_508
        dd CommentaryEvent_511
        dd CommentaryEvent_51A
        dd CommentaryEvent_523
        dd CommentaryEvent_52C
        dd CommentaryEvent_535
Commentary5000JumpTable:                        ; jump table for the switch cases of CommentaryEvent
        dd CommentaryEvent_5E2
        dd CommentaryEvent_5EB
        dd CommentaryEvent_5F4
        dd CommentaryEvent_5FD
Commentary6000JumpTable:                        ; jump table for the switch cases of CommentaryEvent
        dd CommentaryEvent_6D5
        dd CommentaryEvent_6E7
        dd CommentaryEvent_6F0
        dd CommentaryEvent_6F9
        dd CommentaryEvent_702
Commentary7000JumpTable:                        ; jump table for the switch cases of CommentaryEvent
        dd CommentaryEvent_831
        dd CommentaryEvent_83B
        dd CommentaryEvent_847
        dd CommentaryEvent_853
        dd CommentaryEvent_85F
        dd CommentaryEvent_868
        dd CommentaryEvent_871
        dd CommentaryEvent_87A
        dd CommentaryEvent_883
        dd CommentaryEvent_88C
        dd CommentaryEvent_895
        dd CommentaryEvent_89E
        dd CommentaryEvent_8A7
        dd CommentaryEvent_8B0
        dd CommentaryEvent_8B9
CommentaryA000JumpTable:                        ; jump table for the switch cases of CommentaryEvent
        dd CommentaryEvent_F80
        dd CommentaryEvent_F89
        dd CommentaryEvent_F92
        dd CommentaryEvent_F9B
        dd CommentaryEvent_FB0
        dd CommentaryEvent_FB9
CommentaryD000JumpTable:                        ; jump table for the switch cases of CommentaryEvent
        dd CommentaryEvent_189C
        dd CommentaryEvent_18A1
        dd CommentaryEvent_18AA
        dd CommentaryEvent_18BC
        dd CommentaryEvent_18B3
;-----------------------------------------------------------------------------
; CommentaryEvent                                 45BEC  97 PC, low confidence
;
; The play-by-play commentary: (event 0A0000001h-0A000002Fh, args...) with speech on, not in a replay
; (ReplayPlaying); jump table CommentaryEventJumpTable by event, each case queues commentary clips. The
; arena PA announcer is PaEvent (B/C events)
;-----------------------------------------------------------------------------
CommentaryEvent:
        push dword 66Ch
        call __CHK
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        mov ebp, esp
        sub esp, 630h
        sub ebp, byte 7Ah
        cmp word [SfxBankLoaded], byte 0
        je near CommentaryEvent_1FE8.273
        mov edx, dword [ReplayPlaying]
        test edx, edx
        jne near CommentaryEvent_1FE8.273
        cmp dword [SoundCardType], byte 0
        je near CommentaryEvent_1FE8.273
        mov eax, dword [dword ebp+096h]
        add eax, 5FFFFFFFh
        lea ebx, [dword ebp+09Ah]
        cmp eax, byte 2Eh
        ja near CommentaryEvent_1FE8.272
        jmp dword [nosplit cs:eax*4+CommentaryEventJumpTable]
CommentaryEvent_66:
        add ebx, byte 4
        mov ecx, dword [byte ebx-04h]
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+06Eh], eax
        lea eax, [nosplit edx*4+00h]
.1:
        add eax, byte 4
        mov edx, dword [ebx]
        add ebx, byte 4
        mov dword [byte eax+ebp+05Ah], edx
        cmp eax, byte 8
        jne short .1
        mov eax, dword [ebx]
        add ebx, byte 4
        cmp eax, 1000h
        je short .3
        cmp eax, 1002h
        jne short .2
        mov eax, 2
        jmp short .4
.2:
        mov eax, 1
        jmp short .4
.3:
        xor eax, eax
.4:
        mov dword [byte ebp+046h], eax
        lea eax, [byte ebp+076h]
        push eax
        lea eax, [byte ebp+04Eh]
        push eax
        lea eax, [byte ebp+04Ah]
        push eax
        lea eax, [byte ebp+042h]
        push eax
        lea eax, [byte ebp+03Eh]
        push eax
        mov eax, dword [byte ebp+062h]
        push dword [eax]
        mov eax, dword [byte ebp+05Eh]
        mov edx, dword [byte ebp+06Eh]
        push dword [eax]
        mov eax, ecx
        call SayPlayerCall
        test eax, eax
        je near CommentaryEvent_1FE8.272
        mov eax, dword [byte ebp+06Eh]
        call SpeechClipExists
        mov dword [byte ebp+03Ah], eax
        mov eax, dword [byte ebp+042h]
        call SpeechTableEntry
        push eax
        mov eax, dword [byte ebp+03Eh]
        call SpeechTableEntry
        push eax
        push str_CarrySS
        lea eax, [dword ebp-05B6h]
        push eax
        call sprintf_
        add esp, byte 10h
        mov eax, dword [byte ebp+076h]
        push eax
        mov edx, dword [byte ebp+04Eh]
        mov ebx, dword [byte ebp+04Ah]
        push edx
        mov ecx, dword [byte ebp+046h]
        mov eax, dword [byte ebp+03Ah]
        push ebx
        mov edx, dword [byte ebp+03Eh]
        mov ebx, dword [byte ebp+042h]
        call QueuePositionSpeech
        jmp near CommentaryEvent_1FE8.272
CommentaryEvent_135:
        add ebx, byte 4
        mov ecx, dword [byte ebx-04h]
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+06Eh], eax
        xor eax, eax
.5:
        add eax, byte 4
        mov edx, dword [ebx]
        add ebx, byte 4
        mov dword [byte eax+ebp+05Ah], edx
        cmp eax, byte 8
        jne short .5
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+072h], eax
        mov eax, 8
.6:
        add eax, byte 4
        mov edx, dword [ebx]
        add ebx, byte 4
        mov dword [byte eax+ebp+05Ah], edx
        cmp eax, byte 10h
        jne short .6
        xor edx, edx
.7:
        mov eax, dword [byte edx+ebp+06Eh]
        add edx, byte 4
        call SpeechClipExists
        mov dword [byte edx+ebp+036h], eax
        cmp edx, byte 8
        jne short .7
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+046h], eax
        cmp eax, 2000h
        jne short .8
        mov eax, dword [tickcount]
        cmp eax, dword [CommentaryCurrent]
        jge short .8
        mov eax, dword [byte ebp+03Eh]
        cmp eax, dword [CommentaryPrev]
        jne short .8
        call rand_
        mov edx, eax
        mov esi, 2
        sar edx, 1Fh
        idiv esi
        test edx, edx
        je short .8
        mov dword [byte ebp+046h], 8
.8:
        lea eax, [byte ebp+052h]
        push eax
        lea eax, [byte ebp+04Eh]
        push eax
        lea eax, [byte ebp+046h]
        push eax
        lea eax, [byte ebp+042h]
        push eax
        mov eax, dword [byte ebp+06Ah]
        push dword [eax]
        mov eax, dword [byte ebp+066h]
        push dword [eax]
        mov eax, dword [byte ebp+062h]
        push dword [eax]
        mov eax, dword [byte ebp+05Eh]
        push dword [eax]
        mov eax, ecx
        call SayShotCall
        cmp dword [byte ebp+052h], byte 1
        jne short .9
        mov dword [byte ebp+042h], 0FFFFFFFFh
.9:
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+04Ah], eax
        cmp eax, 2003h
        jne short .11
        call rand_
        mov edx, eax
        mov ecx, 2
        sar edx, 1Fh
        idiv ecx
        test edx, edx
        je short .10
        mov dword [byte ebp+04Ah], 4
        jmp short .14
.10:
        mov dword [byte ebp+04Ah], edx
        jmp short .14
.11:
        cmp eax, 2004h
        jne short .12
        mov dword [byte ebp+04Ah], 5
        jmp short .14
.12:
        cmp eax, 2005h
        jne short .13
        mov dword [byte ebp+04Ah], 1
        jmp short .14
.13:
        mov dword [byte ebp+04Ah], 2
.14:
        mov edx, dword [ebx]
        add ebx, byte 4
        cmp edx, 1000h
        je short .16
        cmp edx, 1002h
        jne short .15
        mov edx, 2
        jmp short .17
.15:
        mov edx, 1
        jmp short .17
.16:
        xor edx, edx
.17:
        mov eax, dword [byte ebp+03Ah]
        mov edi, dword [byte ebp+03Eh]
        mov dword [byte ebp+056h], edx
        cmp eax, edi
        je short .18
        cmp dword [dword ebp+096h], 0A0000002h
        sete al
        and eax, 0FFh
        push eax
        push edx
        mov ecx, dword [byte ebp+052h]
        push ecx
        mov esi, dword [byte ebp+04Eh]
        mov edi, dword [byte ebp+04Ah]
        push esi
        mov ebx, dword [byte ebp+042h]
        mov eax, dword [byte ebp+03Ah]
        push edi
        mov edx, dword [byte ebp+03Eh]
        mov ecx, dword [byte ebp+046h]
        call QueuePassSpeech
.18:
        mov eax, dword [tickcount]
        add eax, 96h
        mov dword [CommentaryCurrent], eax
        mov eax, dword [byte ebp+03Ah]
        mov dword [CommentaryPrev], eax
        jmp near CommentaryEvent_1FE8.272
CommentaryEvent_2DE:
        add ebx, byte 4
        mov edi, 5
        mov ecx, dword [byte ebx-04h]
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+06Eh], eax
        call SpeechClipExists
        mov dword [byte ebp+03Ah], eax
        mov dword [byte ebp+03Eh], edx
        mov dword [byte ebp+046h], edi
        lea eax, [nosplit edx*4+00h]
.19:
        add eax, byte 4
        mov edx, dword [ebx]
        add ebx, byte 4
        mov dword [byte eax+ebp+05Ah], edx
        cmp eax, byte 8
        jne short .19
        mov eax, dword [byte ebp+062h]
        push dword [eax]
        mov eax, dword [byte ebp+05Eh]
        push dword [eax]
        mov eax, ecx
        add ebx, byte 4
        call SaySaveCall
        mov dword [byte ebp+04Ah], eax
        mov ebx, dword [byte ebx-04h]
        cmp ebx, 1000h
        je short .21
        cmp ebx, 1002h
        jne short .20
        mov ebx, 2
        jmp short .22
.20:
        mov ebx, 1
        jmp short .22
.21:
        xor ebx, ebx
.22:
        push byte 0
        mov ecx, dword [byte ebp+04Ah]
        mov edx, dword [byte ebp+03Eh]
        mov eax, dword [byte ebp+03Ah]
        push ecx
        mov ecx, dword [byte ebp+046h]
        mov dword [byte ebp+042h], ebx
        call QueueShotSpeech
        jmp near CommentaryEvent_1FE8.272
CommentaryEvent_36D:
        add ebx, byte 4
        mov ecx, dword [byte ebx-04h]
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+06Eh], eax
        call SpeechClipExists
        mov dword [byte ebp+03Ah], eax
        lea eax, [nosplit edx*4+00h]
.23:
        add eax, byte 4
        mov edx, dword [ebx]
        add ebx, byte 4
        mov dword [byte eax+ebp+05Ah], edx
        cmp eax, byte 8
        jne short .23
        mov eax, dword [byte ebp+062h]
        push dword [eax]
        mov eax, dword [byte ebp+05Eh]
        push dword [eax]
        mov eax, ecx
        call SaySaveCall
        mov dword [byte ebp+04Ah], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+03Eh], eax
        cmp eax, 3000h
        jne short .24
        mov dword [byte ebp+03Eh], 1
        jmp short .26
.24:
        cmp eax, 3002h
        jne short .25
        mov dword [byte ebp+03Eh], 2
        jmp short .26
.25:
        xor edi, edi
        mov dword [byte ebp+03Eh], edi
.26:
        mov eax, dword [ebx]
        mov dword [byte ebp+046h], eax
        sub eax, 3003h
        add ebx, byte 4
        cmp eax, byte 5
        ja short CommentaryEvent_423.27
        jmp dword [nosplit cs:eax*4+Commentary3000JumpTable]
CommentaryEvent_3F6:
        mov dword [byte ebp+046h], 1
        jmp short CommentaryEvent_423.28
CommentaryEvent_3FF:
        mov dword [byte ebp+046h], 2
        jmp short CommentaryEvent_423.28
CommentaryEvent_408:
        mov dword [byte ebp+046h], 3
        jmp short CommentaryEvent_423.28
CommentaryEvent_411:
        mov dword [byte ebp+046h], 4
        jmp short CommentaryEvent_423.28
CommentaryEvent_41A:
        mov dword [byte ebp+046h], 6
        jmp short CommentaryEvent_423.28
CommentaryEvent_423:
        mov dword [byte ebp+046h], 7
        jmp short .28
.27:
        xor ecx, ecx
        mov dword [byte ebp+046h], ecx
.28:
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+04Eh], eax
        test eax, eax
        setne al
        and eax, 0FFh
        add ebx, byte 4
        mov dword [byte ebp+04Eh], eax
        mov ebx, dword [byte ebx-04h]
        cmp ebx, 1000h
        je short .30
        cmp ebx, 1002h
        jne short .29
        mov ebx, 2
        jmp short .31
.29:
        mov ebx, 1
        jmp short .31
.30:
        xor ebx, ebx
.31:
        mov eax, dword [byte ebp+04Eh]
        mov edx, dword [byte ebp+04Ah]
        push eax
        mov ecx, dword [byte ebp+046h]
        mov eax, dword [byte ebp+03Ah]
        push edx
        mov edx, dword [byte ebp+03Eh]
        mov dword [byte ebp+042h], ebx
        call QueueShotSpeech
        jmp near CommentaryEvent_1FE8.272
CommentaryEvent_48A:
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+06Eh], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+03Eh], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        cmp eax, 1000h
        je short .33
        cmp eax, 1002h
        jne short .32
        mov eax, 2
        jmp short .34
.32:
        mov eax, 1
        jmp short .34
.33:
        xor eax, eax
.34:
        mov dword [byte ebp+042h], eax
        mov eax, dword [byte ebp+06Eh]
        call SpeechClipExists
        mov dword [byte ebp+03Ah], eax
        mov eax, dword [byte ebp+03Eh]
        sub eax, 4001h
        cmp eax, byte 9
        ja near CommentaryEvent_535.35
        jmp dword [nosplit cs:eax*4+Commentary4000JumpTable]
CommentaryEvent_4E4:
        mov dword [byte ebp+03Eh], 1
        jmp short CommentaryEvent_535.36
CommentaryEvent_4ED:
        mov dword [byte ebp+03Eh], 2
        jmp short CommentaryEvent_535.36
CommentaryEvent_4F6:
        mov dword [byte ebp+03Eh], 3
        jmp short CommentaryEvent_535.36
CommentaryEvent_4FF:
        mov dword [byte ebp+03Eh], 4
        jmp short CommentaryEvent_535.36
CommentaryEvent_508:
        mov dword [byte ebp+03Eh], 5
        jmp short CommentaryEvent_535.36
CommentaryEvent_511:
        mov dword [byte ebp+03Eh], 6
        jmp short CommentaryEvent_535.36
CommentaryEvent_51A:
        mov dword [byte ebp+03Eh], 7
        jmp short CommentaryEvent_535.36
CommentaryEvent_523:
        mov dword [byte ebp+03Eh], 8
        jmp short CommentaryEvent_535.36
CommentaryEvent_52C:
        mov dword [byte ebp+03Eh], 9
        jmp short CommentaryEvent_535.36
CommentaryEvent_535:
        mov dword [byte ebp+03Eh], 0Ah
        jmp short .36
.35:
        xor edi, edi
        mov dword [byte ebp+03Eh], edi
.36:
        mov edx, dword [byte ebp+042h]
        mov ecx, dword [byte ebp+03Eh]
        mov ebx, dword [byte ebp+03Ah]
        xor eax, eax
.37:
        add eax, byte 4
        xor esi, esi
        mov dword [dword eax+ebp-047Ah], esi
        cmp eax, byte 30h
        jne short .37
        mov edi, 3
        lea eax, [dword ebp-0476h]
        mov dword [dword ebp-0472h], ebx
        mov dword [dword ebp-046Eh], edx
        mov dword [dword ebp-046Ah], ecx
        mov dword [dword ebp-0476h], edi
        call RequestSpeechEvent
        jmp near CommentaryEvent_1FE8.272
CommentaryEvent_58C:
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+06Eh], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+03Eh], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        cmp eax, 1000h
        je short .39
        cmp eax, 1002h
        jne short .38
        mov eax, 2
        jmp short .40
.38:
        mov eax, 1
        jmp short .40
.39:
        xor eax, eax
.40:
        mov dword [byte ebp+042h], eax
        mov eax, dword [byte ebp+06Eh]
        call SpeechClipExists
        mov dword [byte ebp+03Ah], eax
        mov eax, dword [byte ebp+03Eh]
        sub eax, 5001h
        cmp eax, byte 3
        ja short CommentaryEvent_5FD.41
        jmp dword [nosplit cs:eax*4+Commentary5000JumpTable]
CommentaryEvent_5E2:
        mov dword [byte ebp+03Eh], 1
        jmp short CommentaryEvent_5FD.42
CommentaryEvent_5EB:
        mov dword [byte ebp+03Eh], 2
        jmp short CommentaryEvent_5FD.42
CommentaryEvent_5F4:
        mov dword [byte ebp+03Eh], 3
        jmp short CommentaryEvent_5FD.42
CommentaryEvent_5FD:
        mov dword [byte ebp+03Eh], 4
        jmp short .42
.41:
        xor eax, eax
        mov dword [byte ebp+03Eh], eax
.42:
        mov edx, dword [byte ebp+042h]
        mov ebx, dword [byte ebp+03Eh]
        mov ecx, dword [byte ebp+03Ah]
        xor eax, eax
.43:
        add eax, byte 4
        xor edi, edi
        mov dword [dword eax+ebp-056Ah], edi
        cmp eax, byte 30h
        jne short .43
        mov eax, 4
        mov dword [dword ebp-0562h], ecx
        mov dword [dword ebp-055Eh], edx
        mov dword [dword ebp-0566h], eax
        lea eax, [dword ebp-0566h]
        mov dword [dword ebp-055Ah], ebx
        call RequestSpeechEvent
        jmp near CommentaryEvent_1FE8.272
CommentaryEvent_654:
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+06Eh], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+072h], eax
        lea eax, [nosplit edx*4+00h]
.44:
        add eax, byte 4
        mov edx, dword [ebx]
        add ebx, byte 4
        mov dword [byte eax+ebp+05Ah], edx
        cmp eax, byte 8
        jne short .44
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+042h], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        cmp eax, 1000h
        je short .46
        cmp eax, 1002h
        jne short .45
        mov eax, 2
        jmp short .47
.45:
        mov eax, 1
        jmp short .47
.46:
        xor eax, eax
.47:
        mov dword [byte ebp+046h], eax
        mov eax, dword [byte ebp+06Eh]
        call SpeechClipExists
        mov dword [byte ebp+03Ah], eax
        mov eax, dword [byte ebp+072h]
        call SpeechClipExists
        mov dword [byte ebp+03Eh], eax
        mov eax, dword [byte ebp+042h]
        sub eax, 6001h
        cmp eax, byte 4
        ja short CommentaryEvent_702.48
        jmp dword [nosplit cs:eax*4+Commentary6000JumpTable]
CommentaryEvent_6D5:
        mov eax, dword [byte ebp+062h]
        push dword [eax]
        mov eax, dword [byte ebp+05Eh]
        push dword [eax]
        call SayRandomFiller
        mov dword [byte ebp+042h], eax
CommentaryEvent_6E7:
        mov dword [byte ebp+042h], 4
        jmp short CommentaryEvent_702.49
CommentaryEvent_6F0:
        mov dword [byte ebp+042h], 5
        jmp short CommentaryEvent_702.49
CommentaryEvent_6F9:
        mov dword [byte ebp+042h], 6
        jmp short CommentaryEvent_702.49
CommentaryEvent_702:
        mov dword [byte ebp+042h], 7
        jmp short .49
.48:
        xor eax, eax
        mov dword [byte ebp+042h], eax
.49:
        mov ecx, dword [byte ebp+042h]
        mov ebx, dword [byte ebp+046h]
        mov edx, dword [byte ebp+03Eh]
        mov eax, dword [byte ebp+03Ah]
        call QueueHitSpeech
        jmp near CommentaryEvent_1FE8.272
CommentaryEvent_726:
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+06Eh], eax
        call SpeechClipExists
        mov dword [byte ebp+03Ah], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+03Eh], eax
        test eax, eax
        je short .50
        mov eax, dword [SpeechBankAway]
        jmp short .51
.50:
        mov eax, dword [SpeechBankHome]
.51:
        mov dword [byte ebp+03Eh], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        cmp eax, 1000h
        je short .53
        cmp eax, 1002h
        jne short .52
        mov eax, 2
        jmp short .54
.52:
        mov eax, 1
        jmp short .54
.53:
        xor eax, eax
.54:
        mov ebx, dword [byte ebp+03Ah]
        mov edx, dword [byte ebp+03Eh]
        mov ecx, eax
        mov dword [byte ebp+042h], eax
        xor eax, eax
.55:
        add eax, byte 4
        xor esi, esi
        mov dword [dword eax+ebp-03EAh], esi
        cmp eax, byte 30h
        jne short .55
        mov edi, 6
        lea eax, [dword ebp-03E6h]
        mov dword [dword ebp-03E2h], ebx
        mov dword [dword ebp-03DEh], edx
        mov dword [dword ebp-03DAh], ecx
        mov dword [dword ebp-03E6h], edi
        call RequestSpeechEvent
        jmp near CommentaryEvent_1FE8.272
CommentaryEvent_7BF:
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+06Eh], eax
        call SpeechClipExists
        mov dword [byte ebp+03Ah], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+03Eh], eax
        test eax, eax
        je short .56
        mov eax, dword [SpeechBankAway]
        jmp short .57
.56:
        mov eax, dword [SpeechBankHome]
.57:
        mov dword [byte ebp+03Eh], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+042h], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        cmp eax, 1000h
        je short .59
        cmp eax, 1002h
        jne short .58
        mov eax, 2
        jmp short .60
.58:
        mov eax, 1
        jmp short .60
.59:
        xor eax, eax
.60:
        mov dword [byte ebp+046h], eax
        mov eax, dword [byte ebp+042h]
        sub eax, 7000h
        cmp eax, byte 0Eh
        ja near CommentaryEvent_8B9.61
        jmp dword [nosplit cs:eax*4+Commentary7000JumpTable]
CommentaryEvent_831:
        xor esi, esi
        mov dword [byte ebp+042h], esi
        jmp near CommentaryEvent_8B9.61
CommentaryEvent_83B:
        mov dword [byte ebp+042h], 1
        jmp near CommentaryEvent_8B9.61
CommentaryEvent_847:
        mov dword [byte ebp+042h], 2
        jmp near CommentaryEvent_8B9.61
CommentaryEvent_853:
        mov dword [byte ebp+042h], 3
        jmp near CommentaryEvent_8B9.61
CommentaryEvent_85F:
        mov dword [byte ebp+042h], 4
        jmp short CommentaryEvent_8B9.61
CommentaryEvent_868:
        mov dword [byte ebp+042h], 5
        jmp short CommentaryEvent_8B9.61
CommentaryEvent_871:
        mov dword [byte ebp+042h], 6
        jmp short CommentaryEvent_8B9.61
CommentaryEvent_87A:
        mov dword [byte ebp+042h], 8
        jmp short CommentaryEvent_8B9.61
CommentaryEvent_883:
        mov dword [byte ebp+042h], 9
        jmp short CommentaryEvent_8B9.61
CommentaryEvent_88C:
        mov dword [byte ebp+042h], 0Ah
        jmp short CommentaryEvent_8B9.61
CommentaryEvent_895:
        mov dword [byte ebp+042h], 0Bh
        jmp short CommentaryEvent_8B9.61
CommentaryEvent_89E:
        mov dword [byte ebp+042h], 0Ch
        jmp short CommentaryEvent_8B9.61
CommentaryEvent_8A7:
        mov dword [byte ebp+042h], 0Dh
        jmp short CommentaryEvent_8B9.61
CommentaryEvent_8B0:
        mov dword [byte ebp+042h], 0Eh
        jmp short CommentaryEvent_8B9.61
CommentaryEvent_8B9:
        mov dword [byte ebp+042h], 10h
.61:
        mov ecx, dword [byte ebp+042h]
        mov ebx, dword [byte ebp+046h]
        mov edx, dword [byte ebp+03Eh]
        mov eax, dword [byte ebp+03Ah]
        call QueuePenaltySpeech
        jmp near CommentaryEvent_1FE8.272
CommentaryEvent_8D6:
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+06Eh], eax
        call SpeechClipExists
        mov dword [byte ebp+03Ah], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+03Eh], eax
        test eax, eax
        je short .62
        mov eax, dword [SpeechBankAway]
        jmp short .63
.62:
        mov eax, dword [SpeechBankHome]
.63:
        mov dword [byte ebp+03Eh], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        cmp eax, 1000h
        je short .65
        cmp eax, 1002h
        jne short .64
        mov eax, 2
        jmp short .66
.64:
        mov eax, 1
        jmp short .66
.65:
        xor eax, eax
.66:
        mov edx, dword [byte ebp+03Eh]
        mov ebx, dword [byte ebp+03Ah]
        mov ecx, eax
        mov dword [byte ebp+042h], eax
        xor eax, eax
.67:
        add eax, byte 4
        xor esi, esi
        mov dword [dword eax+ebp-02FAh], esi
        cmp eax, byte 30h
        jne short .67
        mov edi, 8
        lea eax, [dword ebp-02F6h]
        mov dword [dword ebp-02F2h], edx
        mov dword [dword ebp-02EEh], ebx
        mov dword [dword ebp-02EAh], ecx
        mov dword [dword ebp-02F6h], edi
        call RequestSpeechEvent
        jmp near CommentaryEvent_1FE8.272
CommentaryEvent_96F:
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+06Eh], eax
        call SpeechClipExists
        mov dword [byte ebp+03Ah], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+03Eh], eax
        test eax, eax
        je short .68
        mov eax, dword [SpeechBankAway]
        jmp short .69
.68:
        mov eax, dword [SpeechBankHome]
.69:
        mov dword [byte ebp+03Eh], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        cmp eax, 1000h
        je short .71
        cmp eax, 1002h
        jne short .70
        mov eax, 2
        jmp short .72
.70:
        mov eax, 1
        jmp short .72
.71:
        xor eax, eax
.72:
        mov ebx, dword [byte ebp+03Eh]
        mov edx, dword [byte ebp+03Ah]
        mov ecx, eax
        mov dword [byte ebp+042h], eax
        xor eax, eax
.73:
        add eax, byte 4
        xor esi, esi
        mov dword [dword eax+ebp-020Ah], esi
        cmp eax, byte 30h
        jne short .73
        mov edi, 9
        lea eax, [dword ebp-0206h]
        mov dword [dword ebp-0202h], ebx
        mov dword [dword ebp-01FEh], edx
        mov dword [dword ebp-01FAh], ecx
        mov dword [dword ebp-0206h], edi
        call RequestSpeechEvent
        jmp near CommentaryEvent_1FE8.272
CommentaryEvent_A08:
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+06Eh], eax
        call SpeechClipExists
        mov dword [byte ebp+03Ah], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+03Eh], eax
        test eax, eax
        je short .74
        mov eax, dword [SpeechBankAway]
        jmp short .75
.74:
        mov eax, dword [SpeechBankHome]
.75:
        mov dword [byte ebp+03Eh], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+046h], eax
        test eax, eax
        setne al
        and eax, 0FFh
        add ebx, byte 4
        mov dword [byte ebp+046h], eax
        mov ebx, dword [byte ebx-04h]
        cmp ebx, 1000h
        je short .77
        cmp ebx, 1002h
        jne short .76
        mov ebx, 2
        jmp short .78
.76:
        mov ebx, 1
        jmp short .78
.77:
        xor ebx, ebx
.78:
        mov ecx, dword [byte ebp+046h]
        mov edx, dword [byte ebp+03Ah]
        mov eax, dword [byte ebp+03Eh]
        mov dword [byte ebp+042h], ebx
        call QueueReceiveSpeech
        jmp near CommentaryEvent_1FE8.272
CommentaryEvent_A84:
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+06Eh], eax
        call SpeechClipExists
        mov dword [byte ebp+03Ah], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+03Eh], eax
        test eax, eax
        je short .79
        mov eax, dword [SpeechBankAway]
        jmp short .80
.79:
        mov eax, dword [SpeechBankHome]
.80:
        mov dword [byte ebp+03Eh], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        cmp eax, 1000h
        je short .82
        cmp eax, 1002h
        jne short .81
        mov eax, 2
        jmp short .83
.81:
        mov eax, 1
        jmp short .83
.82:
        xor eax, eax
.83:
        mov ecx, dword [byte ebp+03Eh]
        mov edx, dword [byte ebp+03Ah]
        mov ebx, eax
        mov dword [byte ebp+042h], eax
        xor eax, eax
.84:
        add eax, byte 4
        xor esi, esi
        mov dword [dword eax+ebp-01AAh], esi
        cmp eax, byte 30h
        jne short .84
        mov edi, 0Bh
        lea eax, [dword ebp-01A6h]
        mov dword [dword ebp-01A2h], ecx
        mov dword [dword ebp-019Eh], edx
        mov dword [dword ebp-019Ah], ebx
        mov dword [dword ebp-01A6h], edi
        call RequestSpeechEvent
        jmp near CommentaryEvent_1FE8.272
CommentaryEvent_B1D:
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+06Eh], eax
        call SpeechClipExists
        mov dword [byte ebp+03Ah], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+03Eh], eax
        test eax, eax
        je short .85
        mov eax, dword [SpeechBankAway]
        jmp short .86
.85:
        mov eax, dword [SpeechBankHome]
.86:
        mov dword [byte ebp+03Eh], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        cmp eax, 1000h
        je short .88
        cmp eax, 1002h
        jne short .87
        mov eax, 2
        jmp short .89
.87:
        mov eax, 1
        jmp short .89
.88:
        xor eax, eax
.89:
        mov edx, dword [byte ebp+03Eh]
        mov ecx, dword [byte ebp+03Ah]
        mov ebx, eax
        mov dword [byte ebp+042h], eax
        xor eax, eax
.90:
        add eax, byte 4
        xor esi, esi
        mov dword [dword eax+ebp-02CAh], esi
        cmp eax, byte 30h
        jne short .90
        mov edi, 0Ch
        lea eax, [dword ebp-02C6h]
        mov dword [dword ebp-02C2h], edx
        mov dword [dword ebp-02BEh], ecx
        mov dword [dword ebp-02BAh], ebx
        mov dword [dword ebp-02C6h], edi
        call RequestSpeechEvent
        jmp near CommentaryEvent_1FE8.272
CommentaryEvent_BB6:
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+06Eh], eax
        call SpeechClipExists
        mov dword [byte ebp+03Ah], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+03Eh], eax
        test eax, eax
        je short .91
        mov eax, dword [SpeechBankAway]
        jmp short .92
.91:
        mov eax, dword [SpeechBankHome]
.92:
        mov dword [byte ebp+03Eh], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+042h], eax
        cmp eax, 8001h
        jb short .94
        jbe short .93
        cmp eax, 8002h
        jne short .94
        mov dword [byte ebp+042h], 1
        jmp short .95
.93:
        mov dword [byte ebp+042h], 0FFFFFFFFh
        jmp short .95
.94:
        xor esi, esi
        mov dword [byte ebp+042h], esi
.95:
        mov eax, dword [ebx]
        add ebx, byte 4
        cmp eax, 1000h
        je short .97
        cmp eax, 1002h
        jne short .96
        mov eax, 2
        jmp short .98
.96:
        mov eax, 1
        jmp short .98
.97:
        xor eax, eax
.98:
        mov edi, dword [byte ebp+042h]
        mov dword [byte ebp+046h], eax
        test edi, edi
        jl short .99
        mov edx, dword [byte ebp+03Ah]
        mov ecx, eax
        mov ebx, edi
        mov eax, dword [byte ebp+03Eh]
        call QueueLoosePuckSpeech
        jmp near CommentaryEvent_1FE8.272
.99:
        mov ecx, 5
        mov edx, dword [byte ebp+03Ah]
        mov ebx, eax
        mov eax, dword [byte ebp+03Eh]
        call QueueTeamSpeech
        jmp near CommentaryEvent_1FE8.272
CommentaryEvent_C68:
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+06Eh], eax
        call SpeechClipExists
        mov dword [byte ebp+03Ah], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+03Eh], eax
        test eax, eax
        je short .100
        mov eax, dword [SpeechBankAway]
        jmp short .101
.100:
        mov eax, dword [SpeechBankHome]
.101:
        mov dword [byte ebp+03Eh], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+042h], eax
        cmp eax, 9002h
        jb short .102
        jbe short .103
        cmp eax, 9003h
        je short .104
        jmp short .105
.102:
        cmp eax, 9001h
        jne short .105
        mov dword [byte ebp+042h], 2
        jmp short .106
.103:
        mov dword [byte ebp+042h], 1
        jmp short .106
.104:
        mov dword [byte ebp+042h], 0FFFFFFFFh
        jmp short .106
.105:
        xor eax, eax
        mov dword [byte ebp+042h], eax
.106:
        mov eax, dword [ebx]
        add ebx, byte 4
        cmp eax, 1000h
        je short .108
        cmp eax, 1002h
        jne short .107
        mov eax, 2
        jmp short .109
.107:
        mov eax, 1
        jmp short .109
.108:
        xor eax, eax
.109:
        mov ebx, dword [byte ebp+042h]
        mov dword [byte ebp+046h], eax
        test ebx, ebx
        jl short .110
        mov edx, dword [byte ebp+03Ah]
        mov ecx, eax
        mov eax, dword [byte ebp+03Eh]
        call QueueCarrySpeech
        jmp near CommentaryEvent_1FE8.272
.110:
        mov ecx, 6
        mov edx, dword [byte ebp+03Ah]
        mov ebx, eax
        mov eax, dword [byte ebp+03Eh]
        call QueueTeamSpeech
        jmp near CommentaryEvent_1FE8.272
CommentaryEvent_D2A:
        mov eax, dword [ebx]
        add ebx, byte 4
        cmp eax, 1000h
        je short .112
        cmp eax, 1002h
        jne short .111
        mov eax, 2
        jmp short .113
.111:
        mov eax, 1
        jmp short .113
.112:
        xor eax, eax
.113:
        mov ebx, eax
        mov dword [byte ebp+03Ah], eax
        xor eax, eax
.114:
        add eax, byte 4
        xor edx, edx
        mov dword [dword eax+ebp-0BAh], edx
        cmp eax, byte 30h
        jne short .114
        mov ecx, 0Fh
        lea eax, [dword ebp-0B6h]
        mov dword [dword ebp-0B2h], ebx
        mov dword [dword ebp-0B6h], ecx
        call RequestSpeechEvent
        jmp near CommentaryEvent_1FE8.272
CommentaryEvent_D86:
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+03Ah], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+03Eh], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        cmp eax, 1000h
        je short .116
        cmp eax, 1002h
        jne short .115
        mov eax, 2
        jmp short .117
.115:
        mov eax, 1
        jmp short .117
.116:
        xor eax, eax
.117:
        mov edx, dword [byte ebp+03Ah]
        mov dword [byte ebp+042h], eax
        test edx, edx
        jle near CommentaryEvent_1FE8.272
        cmp edx, byte 4
        jge near CommentaryEvent_1FE8.272
        mov ecx, dword [byte ebp+03Eh]
        cmp ecx, byte 0FFFFFFFFh
        jle near CommentaryEvent_1FE8.272
        cmp ecx, byte 2
        jge near CommentaryEvent_1FE8.272
        mov edx, 3
        mov edi, dword [byte ebp+03Ah]
        sub edx, edi
        test ecx, ecx
        je short .119
        mov ebx, eax
        mov ecx, edx
        xor eax, eax
.118:
        add eax, byte 4
        xor edi, edi
        mov dword [dword eax+ebp-038Ah], edi
        cmp eax, byte 30h
        jne short .118
        mov eax, 10h
        mov dword [dword ebp-0382h], ebx
        mov dword [dword ebp-0386h], eax
        lea eax, [dword ebp-0386h]
        mov dword [dword ebp-037Eh], ecx
        call RequestSpeechEvent
        jmp near CommentaryEvent_1FE8.272
.119:
        cmp edi, byte 1
        jle near CommentaryEvent_1FE8.272
        mov ebx, eax
        lea ecx, [byte edx+03h]
        xor eax, eax
.120:
        add eax, byte 4
        xor edx, edx
        mov dword [dword eax+ebp-041Ah], edx
        cmp eax, byte 30h
        jne short .120
        mov esi, 10h
        lea eax, [dword ebp-0416h]
        mov dword [dword ebp-0412h], ebx
        mov dword [dword ebp-040Eh], ecx
        mov dword [dword ebp-0416h], esi
        call RequestSpeechEvent
        jmp near CommentaryEvent_1FE8.272
CommentaryEvent_E79:
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+06Eh], eax
        call SpeechClipExists
        mov dword [byte ebp+03Ah], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+03Eh], eax
        test eax, eax
        je short .121
        mov eax, dword [SpeechBankAway]
        jmp short .122
.121:
        mov eax, dword [SpeechBankHome]
.122:
        mov dword [byte ebp+03Eh], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        cmp eax, 1000h
        je short .124
        cmp eax, 1002h
        jne short .123
        mov eax, 2
        jmp short .125
.123:
        mov eax, 1
        jmp short .125
.124:
        xor eax, eax
.125:
        mov ecx, dword [byte ebp+03Eh]
        mov edx, dword [byte ebp+03Ah]
        mov ebx, eax
        mov dword [byte ebp+042h], eax
        xor eax, eax
.126:
        add eax, byte 4
        xor esi, esi
        mov dword [dword eax+ebp-032Ah], esi
        cmp eax, byte 30h
        jne short .126
        mov edi, 11h
        lea eax, [dword ebp-0326h]
        mov dword [dword ebp-0322h], ecx
        mov dword [dword ebp-031Eh], edx
        mov dword [dword ebp-031Ah], ebx
        mov dword [dword ebp-0326h], edi
        call RequestSpeechEvent
        jmp near CommentaryEvent_1FE8.272
CommentaryEvent_F12:
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+03Ah], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+03Eh], eax
        test eax, eax
        je short .127
        mov eax, dword [SpeechBankAway]
        jmp short .128
.127:
        mov eax, dword [SpeechBankHome]
.128:
        mov dword [byte ebp+03Eh], eax
        mov esi, 0FFFFFFFFh
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+06Eh], eax
        mov dword [byte ebp+042h], esi
        mov eax, dword [ebx]
        add ebx, byte 4
        cmp eax, 1000h
        je short .130
        cmp eax, 1002h
        jne short .129
        mov eax, 2
        jmp short .131
.129:
        mov eax, 1
        jmp short .131
.130:
        xor eax, eax
.131:
        mov dword [byte ebp+046h], eax
        mov eax, dword [byte ebp+03Ah]
        sub eax, 0A001h
        cmp eax, byte 5
        ja short CommentaryEvent_FB9.132
        jmp dword [nosplit cs:eax*4+CommentaryA000JumpTable]
CommentaryEvent_F80:
        mov dword [byte ebp+03Ah], 1
        jmp short CommentaryEvent_FB9.133
CommentaryEvent_F89:
        mov dword [byte ebp+03Ah], 2
        jmp short CommentaryEvent_FB9.133
CommentaryEvent_F92:
        mov dword [byte ebp+03Ah], 3
        jmp short CommentaryEvent_FB9.133
CommentaryEvent_F9B:
        mov ebx, 4
        mov eax, dword [byte ebp+06Eh]
        mov dword [byte ebp+03Ah], ebx
        call SpeechClipExists
        mov dword [byte ebp+042h], eax
        jmp short CommentaryEvent_FB9.133
CommentaryEvent_FB0:
        mov dword [byte ebp+03Ah], 5
        jmp short CommentaryEvent_FB9.133
CommentaryEvent_FB9:
        mov dword [byte ebp+03Ah], 6
        jmp short .133
.132:
        xor edi, edi
        mov dword [byte ebp+03Ah], edi
.133:
        mov ecx, dword [byte ebp+03Ah]
        mov ebx, dword [byte ebp+046h]
        mov edx, dword [byte ebp+042h]
        mov eax, dword [byte ebp+03Eh]
        call QueueTeamSpeech
        jmp near CommentaryEvent_1FE8.272
CommentaryEvent_FDD:
        mov edi, 0FFFFFFFFh
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+06Eh], eax
        mov dword [byte ebp+03Ah], edi
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+03Eh], eax
        test eax, eax
        je short .134
        mov eax, dword [SpeechBankAway]
        jmp short .135
.134:
        mov eax, dword [SpeechBankHome]
.135:
        mov dword [byte ebp+03Eh], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+042h], eax
        cmp eax, 0B001h
        jb short .138
        jbe short .136
        cmp eax, 0B002h
        je short .137
        jmp short .138
.136:
        mov dword [byte ebp+042h], 3
        jmp short .140
.137:
        mov edi, 4
        mov eax, dword [byte ebp+06Eh]
        mov dword [byte ebp+042h], edi
        jmp short .139
.138:
        xor edx, edx
        mov eax, dword [byte ebp+06Eh]
        mov dword [byte ebp+042h], edx
.139:
        call SpeechClipExists
        mov dword [byte ebp+03Ah], eax
.140:
        add ebx, byte 4
        mov ebx, dword [byte ebx-04h]
        cmp ebx, 1000h
        je short .142
        cmp ebx, 1002h
        jne short .141
        mov ebx, 2
        jmp short .143
.141:
        mov ebx, 1
        jmp short .143
.142:
        xor ebx, ebx
.143:
        mov ecx, dword [byte ebp+042h]
        mov edx, dword [byte ebp+03Ah]
        mov eax, dword [byte ebp+03Eh]
        mov dword [byte ebp+046h], ebx
        call QueueDeflectSpeech
        jmp near CommentaryEvent_1FE8.272
CommentaryEvent_1084:
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+06Eh], eax
        call SpeechClipExists
        mov dword [byte ebp+03Ah], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+03Eh], eax
        test eax, eax
        je short .144
        mov eax, dword [SpeechBankAway]
        jmp short .145
.144:
        mov eax, dword [SpeechBankHome]
.145:
        mov dword [byte ebp+03Eh], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+042h], eax
        cmp eax, 0B004h
        jb short .147
        jbe short .146
        cmp eax, 0B005h
        jne short .147
        mov dword [byte ebp+042h], 3
        jmp short .148
.146:
        mov dword [byte ebp+042h], 2
        jmp short .148
.147:
        mov dword [byte ebp+042h], 1
.148:
        add ebx, byte 4
        mov ebx, dword [byte ebx-04h]
        cmp ebx, 1000h
        je short .150
        cmp ebx, 1002h
        jne short .149
        mov ebx, 2
        jmp short .151
.149:
        mov ebx, 1
        jmp short .151
.150:
        xor ebx, ebx
.151:
        mov ecx, dword [byte ebp+042h]
        mov edx, dword [byte ebp+03Ah]
        mov eax, dword [byte ebp+03Eh]
        mov dword [byte ebp+046h], ebx
        call QueueDeflectSpeech
        jmp near CommentaryEvent_1FE8.272
CommentaryEvent_111C:
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+06Eh], eax
        call SpeechClipExists
        mov dword [byte ebp+03Ah], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+072h], eax
        call SpeechClipExists
        mov dword [byte ebp+03Eh], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+042h], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        cmp eax, 1000h
        je short .153
        cmp eax, 1002h
        jne short .152
        mov eax, 2
        jmp short .154
.152:
        mov eax, 1
        jmp short .154
.153:
        xor eax, eax
.154:
        mov dword [byte ebp+046h], eax
        call rand_
        mov edx, eax
        mov ebx, 2
        sar edx, 1Fh
        idiv ebx
        test edx, edx
        je short .155
        mov eax, dword [byte ebp+03Eh]
        mov edx, dword [byte ebp+03Ah]
        mov dword [byte ebp+03Ah], eax
        mov dword [byte ebp+03Eh], edx
.155:
        cmp dword [byte ebp+042h], byte 0
        setne al
        and eax, 0FFh
        push eax
        call rand_
        mov edx, eax
        mov ebx, 2
        sar edx, 1Fh
        idiv ebx
        xor ecx, ecx
        test edx, edx
        sete al
        mov ebx, dword [byte ebp+046h]
        mov edx, dword [byte ebp+03Eh]
        mov cl, al
        mov eax, dword [byte ebp+03Ah]
        call QueueFaceoffSpeech
        jmp near CommentaryEvent_1FE8.272
CommentaryEvent_11C5:
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+03Ah], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+06Eh], eax
        call SpeechClipExists
        mov dword [byte ebp+03Eh], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+072h], eax
        call SpeechClipExists
        mov dword [byte ebp+042h], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+046h], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        cmp eax, 1000h
        je short .157
        cmp eax, 1002h
        jne short .156
        mov eax, 2
        jmp short .158
.156:
        mov eax, 1
        jmp short .158
.157:
        xor eax, eax
.158:
        mov dword [byte ebp+04Ah], eax
        call rand_
        mov edx, eax
        mov ebx, 3
        sar edx, 1Fh
        idiv ebx
        cmp edx, byte 2
        jl short .159
        cmp dword [byte ebp+046h], byte 0
        je short .164
.159:
        cmp dword [byte ebp+046h], byte 0
        je short .160
        mov eax, 2
        jmp short .161
.160:
        xor eax, eax
.161:
        mov ebx, dword [byte ebp+04Ah]
        mov ecx, eax
        mov eax, dword [byte ebp+03Ah]
        mov edx, dword [byte ebp+03Eh]
        test eax, eax
        je short .162
        mov eax, dword [SpeechBankAway]
        jmp short .163
.162:
        mov eax, dword [SpeechBankHome]
.163:
        call QueuePickupSpeech
        jmp near CommentaryEvent_1FE8.272
.164:
        mov ebx, dword [byte ebp+04Ah]
        mov edx, dword [byte ebp+042h]
        mov esi, dword [byte ebp+03Ah]
        mov ecx, 1
        test esi, esi
        je short .165
        mov eax, dword [SpeechBankHome]
        jmp short .166
.165:
        mov eax, dword [SpeechBankAway]
.166:
        call QueuePickupSpeech
        jmp near CommentaryEvent_1FE8.272
CommentaryEvent_1293:
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+03Ah], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+03Eh], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        cmp eax, 1000h
        je short .168
        cmp eax, 1002h
        jne short .167
        mov eax, 2
        jmp short .169
.167:
        mov eax, 1
        jmp short .169
.168:
        xor eax, eax
.169:
        mov esi, dword [byte ebp+03Eh]
        mov dword [byte ebp+042h], eax
        test esi, esi
        jle near CommentaryEvent_1FE8.272
        cmp esi, byte 78h
        jge near CommentaryEvent_1FE8.272
        cmp esi, byte 73h
        jle short .172
        cmp dword [CommentaryOn], byte 1
        je short .171
        cmp dword [byte ebp+03Ah], byte 3
        setne dl
        and edx, 0FFh
        mov ebx, eax
        xor ecx, ecx
        xor eax, eax
.170:
        add eax, byte 4
        xor esi, esi
        mov dword [dword eax+ebp-029Ah], esi
        cmp eax, byte 30h
        jne short .170
        mov edi, 16h
        lea eax, [dword ebp-0296h]
        mov dword [dword ebp-0292h], ebx
        mov dword [dword ebp-028Eh], edx
        mov dword [dword ebp-028Ah], ecx
        mov dword [dword ebp-0296h], edi
        call RequestSpeechEvent
.171:
        mov dword [CommentaryOn], 1
        jmp near CommentaryEvent_1FE8.272
.172:
        cmp esi, byte 3Ch
        jge short .175
        cmp esi, byte 2Dh
        jle short .175
        cmp dword [CommentaryOn], byte 2
        je short .174
        cmp dword [byte ebp+03Ah], byte 3
        setne dl
        mov ecx, 1
        and edx, 0FFh
        mov ebx, eax
        xor eax, eax
.173:
        add eax, byte 4
        xor esi, esi
        mov dword [byte eax+ebp-05Ah], esi
        cmp eax, byte 30h
        jne short .173
        mov edi, 16h
        lea eax, [byte ebp-056h]
        mov dword [byte ebp-052h], ebx
        mov dword [byte ebp-04Eh], edx
        mov dword [byte ebp-04Ah], ecx
        mov dword [byte ebp-056h], edi
        call RequestSpeechEvent
.174:
        mov dword [CommentaryOn], 2
        jmp near CommentaryEvent_1FE8.272
.175:
        mov esi, dword [byte ebp+03Eh]
        cmp esi, byte 1Fh
        jge short .178
        cmp esi, byte 1Ch
        jle short .178
        cmp dword [CommentaryOn], byte 3
        je short .177
        cmp dword [byte ebp+03Ah], byte 3
        setne al
        mov ecx, dword [byte ebp+042h]
        mov ebx, eax
        mov edx, 2
        and ebx, 0FFh
        xor eax, eax
.176:
        add eax, byte 4
        xor esi, esi
        mov dword [dword eax+ebp-0EAh], esi
        cmp eax, byte 30h
        jne short .176
        mov edi, 16h
        lea eax, [dword ebp-0E6h]
        mov dword [dword ebp-0E2h], ecx
        mov dword [dword ebp-0DEh], ebx
        mov dword [dword ebp-0DAh], edx
        mov dword [dword ebp-0E6h], edi
        call RequestSpeechEvent
.177:
        mov dword [CommentaryOn], 3
        jmp near CommentaryEvent_1FE8.272
.178:
        mov eax, dword [byte ebp+03Eh]
        cmp eax, byte 15h
        jge short .181
        cmp eax, byte 12h
        jle short .181
        cmp dword [CommentaryOn], byte 4
        je short .180
        cmp dword [byte ebp+03Ah], byte 3
        setne al
        mov ebx, dword [byte ebp+042h]
        mov edx, eax
        mov ecx, 3
        and edx, 0FFh
        xor eax, eax
.179:
        add eax, byte 4
        xor esi, esi
        mov dword [dword eax+ebp-04AAh], esi
        cmp eax, byte 30h
        jne short .179
        mov edi, 16h
        lea eax, [dword ebp-04A6h]
        mov dword [dword ebp-04A2h], ebx
        mov dword [dword ebp-049Eh], edx
        mov dword [dword ebp-049Ah], ecx
        mov dword [dword ebp-04A6h], edi
        call RequestSpeechEvent
.180:
        mov dword [CommentaryOn], 4
        jmp near CommentaryEvent_1FE8.272
.181:
        mov ebx, dword [byte ebp+03Eh]
        cmp ebx, byte 0Bh
        jge near CommentaryEvent_1FE8.272
        cmp ebx, byte 8
        jle near CommentaryEvent_1FE8.272
        cmp dword [CommentaryOn], byte 5
        je short .183
        cmp dword [byte ebp+03Ah], byte 3
        setne al
        mov ebx, dword [byte ebp+042h]
        mov edx, eax
        mov ecx, 4
        and edx, 0FFh
        xor eax, eax
.182:
        add eax, byte 4
        xor esi, esi
        mov dword [byte eax+ebp+06h], esi
        cmp eax, byte 30h
        jne short .182
        mov edi, 16h
        lea eax, [byte ebp+0Ah]
        mov dword [byte ebp+0Eh], ebx
        mov dword [byte ebp+012h], edx
        mov dword [byte ebp+016h], ecx
        mov dword [byte ebp+0Ah], edi
        call RequestSpeechEvent
.183:
        mov dword [CommentaryOn], 5
        jmp near CommentaryEvent_1FE8.272
CommentaryEvent_1500:
        mov ecx, 0FFFFFFFFh
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+06Eh], eax
        mov dword [byte ebp+03Ah], ecx
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+03Eh], eax
        test eax, eax
        je short .184
        mov eax, dword [SpeechBankAway]
        jmp short .185
.184:
        mov eax, dword [SpeechBankHome]
.185:
        mov dword [byte ebp+03Eh], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+042h], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        cmp eax, 1000h
        je short .187
        cmp eax, 1002h
        jne short .186
        mov eax, 2
        jmp short .188
.186:
        mov eax, 1
        jmp short .188
.187:
        xor eax, eax
.188:
        mov edi, dword [byte ebp+042h]
        mov dword [byte ebp+046h], eax
        test edi, edi
        jle near CommentaryEvent_1FE8.272
        cmp edi, byte 78h
        jge near CommentaryEvent_1FE8.272
        mov eax, dword [byte ebp+06Eh]
        call SpeechClipExists
        mov edx, dword [CommentaryClip]
        mov dword [byte ebp+03Ah], eax
        lea esi, [nosplit eax*8+00h]
        cmp esi, edx
        sete al
        and eax, 0FFh
        jne short .189
        test edx, edx
        jne near CommentaryEvent_1FE8.272
.189:
        mov ecx, dword [byte ebp+042h]
        cmp ecx, byte 73h
        jle short .191
        mov ecx, dword [CommentaryClip]
        lea eax, [byte esi+01h]
        cmp eax, ecx
        je short .190
        mov ebx, dword [byte ebp+046h]
        mov edx, dword [byte ebp+03Ah]
        mov eax, dword [byte ebp+03Eh]
        xor ecx, ecx
        call QueuePenaltyEndSpeech
.190:
        inc esi
        mov dword [CommentaryClip], esi
        jmp near CommentaryEvent_1FE8.272
.191:
        cmp ecx, byte 3Ch
        jge short .193
        cmp ecx, byte 2Dh
        jle short .193
        mov ebx, dword [CommentaryClip]
        lea eax, [byte esi+02h]
        cmp eax, ebx
        je short .192
        mov ecx, 1
        mov ebx, dword [byte ebp+046h]
        mov edx, dword [byte ebp+03Ah]
        mov eax, dword [byte ebp+03Eh]
        call QueuePenaltyEndSpeech
.192:
        add esi, byte 2
        mov dword [CommentaryClip], esi
        jmp near CommentaryEvent_1FE8.272
.193:
        mov edx, dword [byte ebp+042h]
        cmp edx, byte 1Fh
        jge short .195
        cmp edx, byte 1Ch
        jle short .195
        mov edx, dword [CommentaryClip]
        lea eax, [byte esi+03h]
        cmp eax, edx
        je short .194
        mov ecx, 2
        mov ebx, dword [byte ebp+046h]
        mov edx, dword [byte ebp+03Ah]
        mov eax, dword [byte ebp+03Eh]
        call QueuePenaltyEndSpeech
.194:
        add esi, byte 3
        mov dword [CommentaryClip], esi
        jmp near CommentaryEvent_1FE8.272
.195:
        mov ecx, dword [byte ebp+042h]
        cmp ecx, byte 15h
        jge short .197
        cmp ecx, byte 12h
        jle short .197
        mov edi, dword [CommentaryClip]
        lea eax, [byte esi+04h]
        cmp eax, edi
        je short .196
        mov ecx, 3
        mov ebx, dword [byte ebp+046h]
        mov edx, dword [byte ebp+03Ah]
        mov eax, dword [byte ebp+03Eh]
        call QueuePenaltyEndSpeech
.196:
        add esi, byte 4
        mov dword [CommentaryClip], esi
        jmp near CommentaryEvent_1FE8.272
.197:
        mov eax, dword [byte ebp+042h]
        cmp eax, byte 0Bh
        jge near CommentaryEvent_1FE8.272
        cmp eax, byte 8
        jle near CommentaryEvent_1FE8.272
        mov ebx, dword [CommentaryClip]
        add esi, byte 5
        cmp esi, ebx
        je short .198
        mov ecx, 4
        mov ebx, dword [byte ebp+046h]
        mov edx, dword [byte ebp+03Ah]
        mov eax, dword [byte ebp+03Eh]
        call QueuePenaltyEndSpeech
.198:
        xor ecx, ecx
        mov dword [CommentaryClip], ecx
        jmp near CommentaryEvent_1FE8.272
CommentaryEvent_16BA:
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+03Ah], eax
        test eax, eax
        je short .199
        mov eax, dword [SpeechBankAway]
        jmp short .200
.199:
        mov eax, dword [SpeechBankHome]
.200:
        mov dword [byte ebp+03Ah], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+03Eh], eax
        cmp eax, byte 1
        jge short .201
        mov dword [byte ebp+03Eh], 1
        jmp short .202
.201:
        cmp eax, byte 2
        jle short .202
        mov dword [byte ebp+03Eh], 2
.202:
        mov eax, dword [ebx]
        add ebx, byte 4
        cmp eax, 1000h
        je short .204
        cmp eax, 1002h
        jne short .203
        mov eax, 2
        jmp short .205
.203:
        mov eax, 1
        jmp short .205
.204:
        xor eax, eax
.205:
        mov ebx, dword [byte ebp+03Eh]
        mov dword [byte ebp+042h], eax
        cmp ebx, byte 1
        setne dl
        mov ecx, dword [byte ebp+03Ah]
        and edx, 0FFh
        mov ebx, eax
        xor eax, eax
.206:
        add eax, byte 4
        xor esi, esi
        mov dword [dword eax+ebp-026Ah], esi
        cmp eax, byte 30h
        jne short .206
        mov edi, 18h
        lea eax, [dword ebp-0266h]
        mov dword [dword ebp-0262h], ecx
        mov dword [dword ebp-025Eh], ebx
        mov dword [dword ebp-025Ah], edx
        mov dword [dword ebp-0266h], edi
        call RequestSpeechEvent
        jmp near CommentaryEvent_1FE8.272
CommentaryEvent_1771:
        lea eax, [nosplit edx*4+00h]
.207:
        add eax, byte 4
        xor esi, esi
        mov dword [dword eax+ebp-014Ah], esi
        cmp eax, byte 30h
        jne short .207
        mov edi, 19h
        lea eax, [dword ebp-0146h]
        mov dword [dword ebp-0142h], edx
        mov dword [dword ebp-0146h], edi
        call RequestSpeechEvent
        jmp near CommentaryEvent_1FE8.272
CommentaryEvent_17AA:
        xor eax, eax
        mov edx, 1
        shl eax, 2
.208:
        add eax, byte 4
        xor ebx, ebx
        mov dword [dword eax+ebp-04DAh], ebx
        cmp eax, byte 30h
        jne short .208
        mov ecx, 19h
        lea eax, [dword ebp-04D6h]
        mov dword [dword ebp-04D2h], edx
        mov dword [dword ebp-04D6h], ecx
        call RequestSpeechEvent
        jmp near CommentaryEvent_1FE8.272
CommentaryEvent_17E6:
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+03Ah], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        cmp eax, 1000h
        je short .210
        cmp eax, 1002h
        jne short .209
        mov eax, 2
        jmp short .211
.209:
        mov eax, 1
        jmp short .211
.210:
        xor eax, eax
.211:
        mov edx, dword [byte ebp+03Ah]
        mov dword [byte ebp+03Eh], eax
        cmp edx, 0C001h
        setne al
        and eax, 0FFh
        mov dword [byte ebp+03Ah], eax
        mov al, byte [PeriodHomeTeam]
        mov ah, byte [PeriodAwayTeam]
        cmp al, ah
        jne short .212
        mov dword [byte ebp+042h], 2
        jmp short .214
.212:
        cmp al, ah
        jbe short .213
        xor ecx, ecx
        mov dword [byte ebp+042h], ecx
        jmp short .214
.213:
        mov dword [byte ebp+042h], 1
.214:
        mov edi, dword [byte ebp+03Eh]
        mov ecx, dword [byte ebp+03Ah]
        mov ebx, dword [byte ebp+042h]
        push edi
        mov edx, dword [SpeechBankAway]
        mov eax, dword [SpeechBankHome]
        call QueueFinalSpeech
        jmp near CommentaryEvent_1FE8.272
CommentaryEvent_1871:
        mov eax, dword [ebx]
        mov dword [byte ebp+06Eh], eax
        call SpeechClipExists
        mov dword [byte ebp+03Ah], eax
        mov eax, dword [byte ebx+04h]
        add ebx, byte 4
        mov dword [byte ebp+03Eh], eax
        sub eax, 0D001h
        add ebx, byte 4
        cmp eax, byte 4
        ja short CommentaryEvent_18BC
        jmp dword [nosplit cs:eax*4+CommentaryD000JumpTable]
CommentaryEvent_189C:
        mov dword [byte ebp+03Eh], edx
        jmp short CommentaryEvent_18BC.215
CommentaryEvent_18A1:
        mov dword [byte ebp+03Eh], 1
        jmp short CommentaryEvent_18BC.215
CommentaryEvent_18AA:
        mov dword [byte ebp+03Eh], 2
        jmp short CommentaryEvent_18BC.215
CommentaryEvent_18B3:
        mov dword [byte ebp+03Eh], 4
        jmp short CommentaryEvent_18BC.215
CommentaryEvent_18BC:
        mov dword [byte ebp+03Eh], 3
.215:
        mov eax, dword [ebx]
        add ebx, byte 4
        cmp eax, 1000h
        je short .217
        cmp eax, 1002h
        jne short .216
        mov eax, 2
        jmp short .218
.216:
        mov eax, 1
        jmp short .218
.217:
        xor eax, eax
.218:
        mov ebx, dword [byte ebp+03Ah]
        mov ecx, dword [byte ebp+03Eh]
        mov edx, eax
        mov dword [byte ebp+042h], eax
        xor eax, eax
.219:
        add eax, byte 4
        xor edi, edi
        mov dword [dword eax+ebp-035Ah], edi
        cmp eax, byte 30h
        jne short .219
        mov eax, 1Bh
        mov dword [dword ebp-0352h], ebx
        mov dword [dword ebp-034Eh], ecx
        mov dword [dword ebp-0356h], eax
        lea eax, [dword ebp-0356h]
        mov dword [dword ebp-034Ah], edx
        call RequestSpeechEvent
        jmp near CommentaryEvent_1FE8.272
CommentaryEvent_1931:
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+06Eh], eax
        add ebx, byte 4
        call SpeechClipExists
        mov dword [byte ebp+03Ah], eax
        mov eax, dword [byte ebx-04h]
        add ebx, byte 4
        mov dword [byte ebp+03Eh], eax
        mov eax, dword [byte ebx-04h]
        mov ecx, dword [byte ebp+03Eh]
        mov dword [byte ebp+042h], eax
        cmp eax, ecx
        sete al
        and eax, 0FFh
        mov esi, dword [byte ebp+042h]
        mov dword [byte ebp+046h], eax
        test esi, esi
        je short .220
        mov eax, dword [SpeechBankAway]
        mov dword [byte ebp+03Eh], eax
        mov eax, dword [SpeechBankHome]
        jmp short .221
.220:
        mov eax, dword [SpeechBankHome]
        mov dword [byte ebp+03Eh], eax
        mov eax, dword [SpeechBankAway]
.221:
        mov dword [byte ebp+042h], eax
        mov ecx, dword [ebx]
        add ebx, byte 4
        cmp ecx, 1000h
        je short .223
        cmp ecx, 1002h
        jne short .222
        mov ecx, 2
        jmp short .224
.222:
        mov ecx, 1
        jmp short .224
.223:
        xor ecx, ecx
.224:
        mov edi, dword [byte ebp+046h]
        mov ebx, dword [byte ebp+03Ah]
        mov edx, dword [byte ebp+042h]
        push edi
        mov eax, dword [byte ebp+03Eh]
        mov dword [byte ebp+04Ah], ecx
        call QueueTouchPuckSpeech
        jmp near CommentaryEvent_1FE8.272
CommentaryEvent_19C8:
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+06Eh], eax
        call SpeechClipExists
        mov dword [byte ebp+03Ah], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+03Eh], eax
        test eax, eax
        je short .225
        mov eax, dword [SpeechBankAway]
        jmp short .226
.225:
        mov eax, dword [SpeechBankHome]
.226:
        mov dword [byte ebp+03Eh], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+042h], eax
        test eax, eax
        setne al
        and eax, 0FFh
        add ebx, byte 4
        mov dword [byte ebp+042h], eax
        mov ebx, dword [byte ebx-04h]
        cmp ebx, 1000h
        je short .228
        cmp ebx, 1002h
        jne short .227
        mov ebx, 2
        jmp short .229
.227:
        mov ebx, 1
        jmp short .229
.228:
        xor ebx, ebx
.229:
        mov ecx, dword [byte ebp+042h]
        mov edx, dword [byte ebp+03Ah]
        mov eax, dword [byte ebp+03Eh]
        mov dword [byte ebp+046h], ebx
        call QueuePenaltyCallSpeech
        jmp near CommentaryEvent_1FE8.272
CommentaryEvent_1A44:
        cmp dword [SpeechBanksReady], byte 0
        jne near CommentaryEvent_1FE8.272
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+06Eh], eax
        call SpeechClipExists
        mov dword [CommentaryTime], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+072h], eax
        test eax, eax
        je short .230
        call SpeechClipExists
        mov dword [CommentaryDelay], eax
        jmp short .231
.230:
        mov dword [CommentaryDelay], 0FFFFFFFFh
.231:
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [CommentaryEventId], eax
        test eax, eax
        je short .232
        mov eax, dword [SpeechBankAway]
        mov dword [CommentaryEventId], eax
        mov eax, dword [SpeechBankHome]
        jmp short .233
.232:
        mov eax, dword [SpeechBankHome]
        mov dword [CommentaryEventId], eax
        mov eax, dword [SpeechBankAway]
.233:
        mov dword [SpeechPlaying], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        cmp eax, 1000h
        je short .235
        cmp eax, 1002h
        jne short .234
        mov eax, 2
        jmp short .236
.234:
        mov eax, 1
        jmp short .236
.235:
        xor eax, eax
.236:
        mov edi, 1
        mov ecx, dword [CommentaryDelay]
        mov ebx, dword [CommentaryTime]
        xor esi, esi
        mov edx, dword [SpeechPlaying]
        push esi
        mov dword [CommentaryPriority], eax
        mov dword [CommentarySpeaker], esi
        push eax
        mov eax, dword [CommentaryEventId]
        mov dword [SpeechBanksReady], edi
        call QueueStoppageSpeech
        jmp near CommentaryEvent_1FE8.272
CommentaryEvent_1B16:
        cmp dword [SpeechBanksReady], byte 0
        je near CommentaryEvent_1FE8.272
        mov ebx, 1
        mov esi, dword [CommentaryPriority]
        mov ecx, dword [CommentaryDelay]
        push ebx
        mov edx, dword [SpeechPlaying]
        mov eax, dword [CommentaryEventId]
        push esi
        mov dword [CommentarySpeaker], ebx
        mov ebx, dword [CommentaryTime]
        call QueueStoppageSpeech
        jmp near CommentaryEvent_1FE8.272
CommentaryEvent_1B57:
        cmp dword [SpeechBanksReady], byte 0
        je near CommentaryEvent_1FE8.272
        mov esi, 2
        mov eax, dword [CommentaryPriority]
        mov ecx, dword [CommentaryDelay]
        push esi
        mov ebx, dword [CommentaryTime]
        mov edx, dword [SpeechPlaying]
        push eax
        mov eax, dword [CommentaryEventId]
        mov dword [CommentarySpeaker], esi
        call QueueStoppageSpeech
        jmp near CommentaryEvent_1FE8.272
CommentaryEvent_1B97:
        cmp dword [SpeechBanksReady], byte 0
        je near CommentaryEvent_1FE8.272
        mov edx, dword [CommentaryPriority]
        xor ebx, ebx
        xor eax, eax
        mov dword [SpeechBanksReady], ebx
        shl eax, 2
        mov ebx, dword [CommentaryEventId]
.237:
        add eax, byte 4
        xor ecx, ecx
        mov dword [dword eax+ebp-023Ah], ecx
        cmp eax, byte 30h
        jne short .237
        mov esi, 1Fh
        lea eax, [dword ebp-0236h]
        mov dword [dword ebp-0232h], ebx
        mov dword [dword ebp-022Eh], edx
        mov dword [dword ebp-0236h], esi
        call RequestSpeechEvent
        jmp near CommentaryEvent_1FE8.272
CommentaryEvent_1BF5:
        mov eax, dword [ebx]
        mov dword [byte ebp+06Eh], eax
        call SpeechClipExists
        mov dword [byte ebp+03Ah], eax
        mov edx, eax
        xor eax, eax
        add ebx, byte 4
        shl eax, 2
.238:
        add eax, byte 4
        xor edi, edi
        mov dword [dword eax+ebp-053Ah], edi
        cmp eax, byte 30h
        jne short .238
        mov dword [dword ebp-0536h], 20h
        lea eax, [dword ebp-0536h]
        mov dword [dword ebp-0532h], edx
        call RequestSpeechEvent
        jmp near CommentaryEvent_1FE8.272
CommentaryEvent_1C3D:
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+06Eh], eax
        call SpeechClipExists
        mov dword [byte ebp+03Ah], eax
        mov eax, dword [ebx]
        add ebx, byte 4
        cmp eax, 1000h
        je short .240
        cmp eax, 1002h
        jne short .239
        mov eax, 2
        jmp short .241
.239:
        mov eax, 1
        jmp short .241
.240:
        xor eax, eax
.241:
        mov ebx, dword [byte ebp+03Ah]
        mov edx, eax
        mov dword [byte ebp+03Eh], eax
        xor eax, eax
.242:
        add eax, byte 4
        xor ecx, ecx
        mov dword [dword eax+ebp-017Ah], ecx
        cmp eax, byte 30h
        jne short .242
        mov esi, 21h
        lea eax, [dword ebp-0176h]
        mov dword [dword ebp-0172h], ebx
        mov dword [dword ebp-016Eh], edx
        mov dword [dword ebp-0176h], esi
        call RequestSpeechEvent
        jmp near CommentaryEvent_1FE8.272
CommentaryEvent_1CB2:
        xor eax, eax
        call SetSpeechEnabled
        mov eax, dword [ebx]
        add ebx, byte 4
        mov dword [byte ebp+03Ah], eax
        cmp eax, byte 2
        jge near .246
        mov eax, dword [gameopts]
        mov eax, dword [byte eax+01h]
        and eax, 0FC000h
        cmp eax, 68000h
        jae short .244
        mov edx, dword [SpeechBankAway]
        xor eax, eax
        mov ebx, dword [SpeechBankHome]
        shl eax, 2
.243:
        add eax, byte 4
        xor edi, edi
        mov dword [dword eax+ebp-044Ah], edi
        cmp eax, byte 30h
        jne short .243
        mov eax, 22h
        mov dword [dword ebp-0442h], ebx
        mov dword [dword ebp-0446h], eax
        lea eax, [dword ebp-0446h]
        mov dword [dword ebp-043Eh], edx
        call RequestSpeechEvent
        jmp near CommentaryEvent_1FE8.272
.244:
        mov ebx, 0FFFFFFFFh
        xor eax, eax
        mov edx, dword [SpeechBankAway]
        shl eax, 2
.245:
        add eax, byte 4
        xor ecx, ecx
        mov dword [dword eax+ebp-03BAh], ecx
        cmp eax, byte 30h
        jne short .245
        mov esi, 22h
        lea eax, [dword ebp-03B6h]
        mov dword [dword ebp-03B2h], ebx
        mov dword [dword ebp-03AEh], edx
        mov dword [dword ebp-03B6h], esi
        call RequestSpeechEvent
        jmp near CommentaryEvent_1FE8.272
.246:
        cmp eax, byte 3
        jle short .247
        mov dword [byte ebp+03Ah], 3
        jmp short .249
.247:
        jne short .248
        mov dword [byte ebp+03Ah], 2
        jmp short .249
.248:
        cmp eax, byte 2
        jne short .249
        mov dword [byte ebp+03Ah], 1
.249:
        mov ecx, dword [byte ebp+03Ah]
        mov edx, dword [SpeechBankAway]
        mov ebx, dword [SpeechBankHome]
        xor eax, eax
.250:
        add eax, byte 4
        xor esi, esi
        mov dword [byte eax+ebp-02Ah], esi
        cmp eax, byte 30h
        jne short .250
        mov edi, 23h
        lea eax, [byte ebp-026h]
        mov dword [byte ebp-022h], ebx
        mov dword [byte ebp-01Eh], edx
        mov dword [byte ebp-01Ah], ecx
        mov dword [byte ebp-026h], edi
        call RequestSpeechEvent
        jmp near CommentaryEvent_1FE8.272
CommentaryEvent_1DD1:
        xor eax, eax
        call SetSpeechEnabled
        lea eax, [dword ebp+09Ah]
        add eax, byte 4
        mov eax, dword [byte eax-04h]
        mov dword [byte ebp+03Ah], eax
        cmp eax, byte 3
        jle short .251
        mov dword [byte ebp+03Ah], 3
        jmp short .254
.251:
        jne short .252
        mov dword [byte ebp+03Ah], 2
        jmp short .254
.252:
        cmp eax, byte 2
        jne short .253
        mov dword [byte ebp+03Ah], 1
        jmp short .254
.253:
        jge short .254
        mov dword [byte ebp+03Ah], edx
.254:
        mov edx, dword [byte ebp+03Ah]
        xor eax, eax
.255:
        add eax, byte 4
        xor edi, edi
        mov dword [dword eax+ebp-08Ah], edi
        cmp eax, byte 30h
        jne short .255
        mov dword [dword ebp-086h], 24h
        lea eax, [dword ebp-086h]
        mov dword [dword ebp-082h], edx
        call RequestSpeechEvent
        jmp near CommentaryEvent_1FE8.272
CommentaryEvent_1E49:
        lea edx, [byte ebx+04h]
        mov eax, dword [byte edx-04h]
        mov dword [byte ebp+03Ah], eax
        test eax, eax
        je short .256
        mov eax, dword [SpeechBankAway]
        jmp short .257
.256:
        mov eax, dword [SpeechBankHome]
.257:
        mov dword [byte ebp+03Ah], eax
        mov eax, dword [edx]
        add edx, byte 4
        mov dword [byte ebp+03Eh], eax
        test eax, eax
        setne al
        and eax, 0FFh
        mov dword [byte ebp+03Eh], eax
        mov eax, dword [edx]
        add edx, byte 4
        mov dword [byte ebp+042h], eax
        test eax, eax
        sete al
        and eax, 0FFh
        add edx, byte 4
        mov dword [byte ebp+042h], eax
        mov edx, dword [byte edx-04h]
        cmp edx, 1000h
        je short .259
        cmp edx, 1002h
        jne short .258
        mov edx, 2
        jmp short .260
.258:
        mov edx, 1
        jmp short .260
.259:
        xor edx, edx
.260:
        mov ecx, dword [byte ebp+042h]
        mov ebx, dword [byte ebp+03Eh]
        mov eax, dword [byte ebp+03Ah]
        mov dword [byte ebp+046h], edx
        call QueuePowerPlaySpeech
        jmp near CommentaryEvent_1FE8.272
CommentaryEvent_1ECB:
        lea eax, [byte ebx+04h]
        mov eax, dword [byte eax-04h]
        cmp eax, 1000h
        je short .262
        cmp eax, 1002h
        jne short .261
        mov eax, 2
        jmp short .263
.261:
        mov eax, 1
        jmp short .263
.262:
        xor eax, eax
.263:
        mov edx, eax
        mov dword [byte ebp+03Ah], eax
        xor eax, eax
.264:
        add eax, byte 4
        xor ecx, ecx
        mov dword [dword eax+ebp-011Ah], ecx
        cmp eax, byte 30h
        jne short .264
        mov esi, 25h
        lea eax, [dword ebp-0116h]
        mov dword [dword ebp-0112h], edx
        mov dword [dword ebp-0116h], esi
        call RequestSpeechEvent
        jmp near CommentaryEvent_1FE8.272
CommentaryEvent_1F28:
        xor eax, eax
.265:
        add eax, byte 4
        xor edx, edx
        mov dword [dword eax+ebp-01DAh], edx
        cmp eax, byte 30h
        jne short .265
        mov ebx, 27h
        lea eax, [dword ebp-01D6h]
        mov dword [dword ebp-01D6h], ebx
        call RequestSpeechEvent
        jmp near CommentaryEvent_1FE8.272
CommentaryEvent_1F56:
        lea edx, [byte ebx+04h]
        mov eax, dword [byte edx-04h]
        mov dword [byte ebp+06Eh], eax
        call SpeechClipExists
        mov dword [byte ebp+03Ah], eax
        mov eax, dword [edx]
        add edx, byte 4
        mov dword [byte ebp+03Eh], eax
        mov eax, dword [edx]
        add edx, byte 4
        cmp eax, 1000h
        je short .267
        cmp eax, 1002h
        jne short .266
        mov eax, 2
        jmp short .268
.266:
        mov eax, 1
        jmp short .268
.267:
        xor eax, eax
.268:
        mov esi, dword [byte ebp+03Eh]
        mov dword [byte ebp+042h], eax
        test esi, esi
        sete dl
        mov ecx, dword [byte ebp+03Ah]
        and edx, 0FFh
        mov ebx, eax
        mov dword [byte ebp+03Eh], edx
        xor eax, eax
.269:
        add eax, byte 4
        xor esi, esi
        mov dword [dword eax+ebp-050Ah], esi
        cmp eax, byte 30h
        jne short .269
        mov edi, 28h
        lea eax, [dword ebp-0506h]
        mov dword [dword ebp-0502h], ecx
        mov dword [dword ebp-04FEh], ebx
        mov dword [dword ebp-04FAh], edx
        mov dword [dword ebp-0506h], edi
        call RequestSpeechEvent
        jmp short CommentaryEvent_1FE8.272
CommentaryEvent_1FE8:
        lea eax, [byte ebx+04h]
        cmp dword [byte eax-04h], byte 0
        je short .270
        mov eax, 1
        jmp short .271
.270:
        xor eax, eax
.271:
        call SetSpeechEnabled
.272:
        call PlayQueuedSpeech
        mov eax, dword [dword ebp+096h]
        mov dword [CommentaryLast], eax
.273:
        lea esp, [byte ebp+07Ah]
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; OpenSpeechFile                                  47C08  97 PC, low confidence
; Opens the "SPEECH" file ("G.KSF")
;-----------------------------------------------------------------------------
OpenSpeechFile:
        push dword 30h
        call __CHK
        push ebx
        push ecx
        push edx
        push ebp
        sub esp, byte 0Ch
        mov ebx, eax
        test eax, eax
        jl near .5
        cmp eax, byte 3
        jge near .5
        mov ecx, eax
        shl ecx, 4
        add ecx, eax
        mov eax, dword [SpeechFileHandle]
        shl ecx, 2
        add eax, ecx
        cmp dword [eax], byte 0
        jne near .5
        add eax, byte 8
        mov edx, dword [nosplit ebx*4+SpeechFileIds]
        call MakeDataPath
        mov eax, dword [GameSettings]
        and eax, byte 0Ch
        cmp eax, byte 8
        jne short .3
        mov eax, dword [SpeechFileHandle]
        add eax, ecx
        mov dl, byte [byte eax+08h]
        add eax, byte 8
        cmp dl, 2Eh
        je short .2
.1:
        mov dh, byte [byte eax+01h]
        inc eax
        cmp dh, 2Eh
        jne short .1
.2:
        mov byte [eax], 0
        mov eax, ebx
        shl eax, 4
        add eax, ebx
        mov edx, dword [SpeechFileHandle]
        shl eax, 2
        add eax, edx
        mov edx, str_GKSF
        add eax, byte 8
        call strcat_
.3:
        call ServiceIdle
        mov eax, esp
        push eax
        lea eax, [byte esp+08h]
        push eax
        lea eax, [byte esp+010h]
        push eax
        mov eax, ebx
        shl eax, 4
        add eax, ebx
        mov edx, dword [SpeechFileHandle]
        shl eax, 2
        add eax, edx
        add eax, byte 8
        push eax
        call DosOpenReadOnly
        add esp, byte 10h
        cmp dword [byte esp+08h], byte 0
        jne short .4
        cmp dword [byte esp+04h], byte 0
        jne short .4
        cmp dword [esp], byte 0
        je near .5
.4:
        push byte 0
        mov ebp, dword [byte esp+0Ch]
        push ebp
        call DosSeekFile
        mov eax, ebx
        shl eax, 4
        add esp, byte 8
        add ebx, eax
        mov eax, dword [SpeechFileHandle]
        shl ebx, 2
        push byte 4
        add eax, ebx
        push eax
        mov eax, dword [byte esp+010h]
        push eax
        call DosReadFile
        mov eax, dword [SpeechFileHandle]
        add esp, byte 0Ch
        mov eax, dword [ebx+eax]
        push byte 20h
        shl eax, 2
        push eax
        push str_SPEECH
        call AllocMemBlock
        mov edx, dword [SpeechFileHandle]
        mov dword [byte edx+ebx+04h], eax
        mov eax, dword [SpeechFileHandle]
        add ebx, eax
        mov eax, dword [ebx]
        add esp, byte 0Ch
        shl eax, 2
        push eax
        mov edx, dword [byte ebx+04h]
        push edx
        mov ebx, dword [byte esp+010h]
        push ebx
        call DosReadFile
        add esp, byte 0Ch
        mov ecx, dword [byte esp+08h]
        push ecx
        call DosCloseFile
        add esp, byte 4
.5:
        add esp, byte 0Ch
        pop ebp
        pop edx
        pop ecx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; FreeSpeechBuffers                               47D70  97 PC, low confidence
; Frees the speech buffers
;-----------------------------------------------------------------------------
FreeSpeechBuffers:
        push dword 14h
        call __CHK
        push ebx
        push ecx
        push edx
        test eax, eax
        jl short .1
        cmp eax, byte 3
        jge short .1
        mov ebx, eax
        shl eax, 4
        add ebx, eax
        mov eax, dword [SpeechFileHandle]
        shl ebx, 2
        add eax, ebx
        cmp dword [eax], byte 0
        je short .1
        mov dword [eax], 0
        mov eax, dword [SpeechFileHandle]
        mov ecx, dword [byte ebx+eax+04h]
        push ecx
        call FreeMemBlock
        mov eax, dword [SpeechFileHandle]
        add esp, byte 4
        mov dword [byte ebx+eax+04h], 0
.1:
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; PickPaClip                                      47DC8  97 PC, low confidence
; Picks an arena announcer clip
;-----------------------------------------------------------------------------
PickPaClip:
        push dword 10h
        call __CHK
        push esi
        push edi
        push ebp
        mov esi, ecx
        test eax, eax
        jl short .1
        cmp eax, byte 3
        jl short .2
.1:
        xor eax, eax
        pop ebp
        pop edi
        pop esi
        ret
.2:
        mov ecx, eax
        shl eax, 4
        add ecx, eax
        mov eax, dword [SpeechFileHandle]
        shl ecx, 2
        add eax, ecx
        mov edi, dword [eax]
        test edi, edi
        jne short .3
        xor eax, eax
        pop ebp
        pop edi
        pop esi
        ret
.3:
        test edx, edx
        jl short .4
        dec edi
        cmp edx, edi
        jl short .5
.4:
        xor eax, eax
        pop ebp
        pop edi
        pop esi
        ret
.5:
        mov eax, dword [byte eax+04h]
        mov eax, dword [eax+edx*4]
        mov dword [ebx], eax
        mov eax, dword [SpeechFileHandle]
        mov eax, dword [byte ecx+eax+04h]
        mov ebp, dword [ebx]
        mov eax, dword [byte eax+edx*4+04h]
        sub eax, ebp
        mov dword [esi], eax
        mov eax, 1
        pop ebp
        pop edi
        pop esi
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; OpenSpeechData                                  47E38  97 PC, low confidence
; Opens the speech data file
;-----------------------------------------------------------------------------
OpenSpeechData:
        push dword 0B8h
        call __CHK
        push ebx
        push ecx
        push edx
        sub esp, 0A0h
        cmp word [SpeechDataOpen], byte 0
        jne short .1
        call ServiceIdle
        lea eax, [byte esp+050h]
        mov edx, dword [SpeechFileIds]
        call MakeDataPath
        mov eax, esp
        mov edx, dword [SpeechDataId]
        call MakeDataPath
        mov eax, esp
        push eax
        lea eax, [byte esp+054h]
        push eax
        call OpenSpeechStreamFile
        add esp, byte 8
        mov ebx, 1
        call ServiceIdle
        mov word [SpeechDataOpen], bx
.1:
        add esp, 0A0h
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Dh,040h,00h
;-----------------------------------------------------------------------------
; InitSpeechStream                                47EA4  97 PC, low confidence
; Sets up the speech stream
;-----------------------------------------------------------------------------
InitSpeechStream:
        push dword 20h
        call __CHK
        push ebx
        push ecx
        push edx
        push esi
        cmp dword [SoundDriverId], byte 0FFFFFFFFh
        jne near .2
        push byte 20h
        push dword 2000h
        push byte 18h
        call AsyncInit
        add esp, byte 0Ch
        call AsyncStreamStep
        call SpeechBufferSize
        push byte 0
        lea ebx, [dword eax+03A0D4h]
        push ebx
        push str_SPEECH
        mov dword [SpeechStreamBase], ebx
        call AllocMemBlock
        add esp, byte 0Ch
        push ebx
        push eax
        mov dword [SpeechStreamFile], eax
        mov ebx, 39CD8h
        call ZeroMem
        mov eax, dword [SpeechStreamFile]
        add esp, byte 8
        mov dword [SpeechStreamClip], ebx
        xor ecx, ecx
        mov dword [SpeechStreamBuf], eax
        mov dword [SpeechStreamRead], eax
        mov dword [SpeechStreamLen], eax
        add eax, ebx
        mov dword [SpeechStreamEnd], ecx
        mov dword [SpeechStreamBytes], eax
        call SpeechBufferSize
        mov ebx, eax
        mov eax, dword [SpeechStreamBytes]
        lea edx, [eax+ebx]
        mov dword [PaQueueHead], edx
        lea ebx, [dword edx+0330h]
        mov dword [SpeechFileHandle], ebx
        call RegisterStreamBank
        mov dword [SpeechStreamTimer], eax
        mov eax, dword [SfxVolumeLevel]
        sar eax, 10h
        call StartSpeechQueue
        cmp word [SpeechDataOpen], byte 0
        jne short .1
        call OpenSpeechData
.1:
        xor esi, esi
        call ServiceIdle
        mov dword [SoundDriverId], esi
.2:
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; ShutdownSound                                47F8C  96 PC, medium confidence
; From ShutDown: ShutdownSpeech, frees the sound effect banks, fades and
; stops the music, AsyncClose
;-----------------------------------------------------------------------------
ShutdownSound:
        push dword 1Ch
        call __CHK
        push ebx
        push ecx
        push edx
        push esi
        cmp dword [SoundDriverId], byte 0FFFFFFFFh
        je near .1
        call AsyncStreamStep
        mov ebx, 0FFFFFFFFh
        call AsyncClose
        mov dword [StreamTimerHandle], ebx
        call ShutdownSpeechQueue
        xor eax, eax
        call FreeSpeechBuffers
        mov eax, 1
        call FreeSpeechBuffers
        mov eax, 2
        call FreeSpeechBuffers
        mov eax, dword [SpeechStreamTimer]
        call UnregisterSoundBank
        mov ecx, dword [SpeechStreamFile]
        push ecx
        call FreeMemBlock
        add esp, byte 4
        xor esi, esi
        push byte 14h
        mov dword [SpeechStreamFile], esi
        mov dword [SpeechStreamBytes], esi
        push SpeechStreamBuf
        mov dword [PaQueueHead], esi
        mov dword [SpeechStreamTimer], ebx
        call ZeroMem
        add esp, byte 8
        mov dword [SoundDriverId], ebx
        call ServiceIdle
.1:
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
        db 08Bh,0C0h
;-----------------------------------------------------------------------------
; OpenPlayByPlay                                  48030  97 PC, low confidence
; Opens the play-by-play speech
;-----------------------------------------------------------------------------
OpenPlayByPlay:
        push dword 8
        call __CHK
        push ebx
        cmp dword [SoundDriverId], byte 0FFFFFFFFh
        jne short .1
        call InitSpeechStream
.1:
        xor eax, eax
        call FreeSpeechBuffers
        call ServiceIdle
        mov eax, 1
        call OpenSpeechFile
        call ServiceIdle
        mov eax, 2
        mov ebx, 2
        call OpenSpeechFile
        call ServiceIdle
        mov dword [SoundDriverId], ebx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; OpenArenaSpeech                                 48080  97 PC, low confidence
; Opens the arena announcer speech
;-----------------------------------------------------------------------------
OpenArenaSpeech:
        push dword 8
        call __CHK
        push ebx
        cmp dword [SoundDriverId], byte 0FFFFFFFFh
        jne short .1
        call InitSpeechStream
.1:
        mov eax, 2
        call FreeSpeechBuffers
        mov eax, 1
        call FreeSpeechBuffers
        call ServiceIdle
        xor eax, eax
        mov ebx, 1
        call OpenSpeechFile
        call ServiceIdle
        mov dword [SoundDriverId], ebx
        pop ebx
        ret
        db 090h
;-----------------------------------------------------------------------------
; ServiceSpeechStream                             480CC  97 PC, low confidence
; Feeds the speech stream
;-----------------------------------------------------------------------------
ServiceSpeechStream:
        push dword 28h
        call __CHK
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        cmp dword [PaQueueHead], byte 0
        je near .23
        cmp word [StreamTimerOn], byte 0
        je near .23
        mov bx, word [PaQueuePrev]
        cmp bx, word [PaQueueClip]
        je near .10
        cmp bx, word [PaQueueTime]
        je near .7
        mov edx, dword [PaQueueClip]
        sar edx, 10h
        mov eax, edx
        shl eax, 4
        add edx, eax
        mov eax, dword [PaQueueHead]
        add edx, edx
        cmp dword [byte edx+eax+02h], byte 0
        jne near .7
        mov ecx, dword [SpeechStreamLen]
        mov eax, dword [SpeechStreamRead]
        cmp eax, ecx
        jge short .1
        mov edx, ecx
        sub edx, eax
        jmp short .2
.1:
        mov edx, dword [SpeechStreamClip]
        mov eax, dword [SpeechStreamBuf]
        mov esi, dword [SpeechStreamRead]
        mov ebx, ecx
        add edx, eax
        sub ebx, eax
        sub edx, esi
        mov eax, ebx
        cmp edx, ebx
        jge short .2
        mov edx, ebx
.2:
        mov ebx, dword [PaQueueClip]
        sar ebx, 10h
        mov eax, ebx
        shl eax, 4
        add eax, ebx
        mov ebx, dword [PaQueueHead]
        add eax, eax
        add eax, ebx
        mov ebp, dword [byte eax+016h]
        cmp edx, ebp
        jl near .7
        mov eax, SpeechStreamBuf
        mov edx, ebp
        call RingBufferSpace
        mov edx, dword [PaQueueClip]
        sar edx, 10h
        mov ebx, eax
        mov eax, edx
        shl eax, 4
        add eax, edx
        mov edx, dword [PaQueueHead]
        mov dword [byte edx+eax*2+012h], ebx
        mov edx, dword [PaQueueClip]
        sar edx, 10h
        mov eax, edx
        shl eax, 4
        add eax, edx
        mov edx, dword [PaQueueHead]
        movsx eax, word [edx+eax*2]
        cmp eax, dword [StreamTimerHandle]
        je short .3
        mov edx, eax
        shl eax, 4
        add eax, edx
        mov edx, dword [SpeechFileHandle]
        shl eax, 2
        add eax, edx
        add eax, byte 8
        push eax
        call AsyncRequestOpen
        mov edx, dword [PaQueueClip]
        sar edx, 10h
        mov eax, edx
        shl eax, 4
        add eax, edx
        mov edx, dword [PaQueueHead]
        movsx eax, word [edx+eax*2]
        add esp, byte 4
        mov dword [StreamTimerHandle], eax
.3:
        mov edx, dword [PaQueueClip]
        sar edx, 10h
        mov eax, edx
        shl eax, 4
        add eax, edx
        mov edx, dword [PaQueueHead]
        add eax, eax
        add eax, edx
        cmp dword [byte eax+0Eh], byte 0
        jl short .4
        mov eax, 2800h
        jmp short .5
.4:
        mov eax, dword [byte eax+016h]
.5:
        mov edx, dword [PaQueueClip]
        sar edx, 10h
        push eax
        mov eax, edx
        shl eax, 4
        add eax, edx
        mov edx, dword [PaQueueHead]
        mov ecx, dword [byte edx+eax*2+012h]
        push ecx
        mov esi, dword [byte edx+eax*2+0Ah]
        push esi
        call AsyncRequestSection
        mov edx, dword [PaQueueClip]
        sar edx, 10h
        mov ebx, eax
        mov eax, edx
        shl eax, 4
        add eax, edx
        mov edx, dword [PaQueueHead]
        mov dword [byte edx+eax*2+02h], ebx
        mov edx, dword [PaQueueClip]
        sar edx, 10h
        mov eax, edx
        shl eax, 4
        add edx, eax
        mov eax, dword [PaQueueHead]
        add edx, edx
        add eax, edx
        mov edi, dword [byte eax+0Eh]
        add esp, byte 0Ch
        test edi, edi
        jl short .6
        mov edx, dword [byte eax+016h]
        sub edx, 2800h
        push edx
        mov edx, dword [byte eax+012h]
        add edx, 2800h
        push edx
        push edi
        call AsyncRequestSection
        mov ebx, dword [PaQueueClip]
        sar ebx, 10h
        mov edx, eax
        mov eax, ebx
        shl eax, 4
        add eax, ebx
        mov ebx, dword [PaQueueHead]
        add esp, byte 0Ch
        mov dword [byte ebx+eax*2+06h], edx
.6:
        mov edx, dword [PaQueueClip]
        sar edx, 10h
        inc edx
        mov ebx, 18h
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        mov word [PaQueueTime], dx
.7:
        call AsyncStreamStep
        mov edx, dword [PaQueueCount]
        sar edx, 10h
        mov eax, edx
        shl eax, 4
        add eax, edx
        mov edx, dword [PaQueueHead]
        add eax, eax
        add eax, edx
        mov edx, dword [byte eax+02h]
        test edx, edx
        je near .10
        push edx
        call AsyncFreeRequest
        add esp, byte 4
        test eax, eax
        je near .10
        mov edx, dword [PaQueueCount]
        sar edx, 10h
        mov eax, edx
        shl eax, 4
        add eax, edx
        mov edx, dword [PaQueueHead]
        mov dword [byte edx+eax*2+02h], 0
        mov edx, dword [PaQueueCount]
        sar edx, 10h
        mov eax, edx
        shl eax, 4
        add eax, edx
        mov edx, dword [PaQueueHead]
        add eax, eax
        add edx, eax
        mov eax, dword [byte edx+012h]
        xor ecx, ecx
        mov cl, byte [byte eax+03h]
        add ecx, eax
        lea ebx, [byte eax+04h]
        add edx, byte 1Eh
        mov eax, dword [SpeechStreamTimer]
        call AddStreamSample
        mov edx, dword [PaQueueCount]
        sar edx, 10h
        mov eax, edx
        shl eax, 4
        add eax, edx
        mov edx, dword [PaQueueHead]
        cmp word [edx+eax*2], byte 0
        jne short .8
        xor ebx, ebx
        jmp short .9
.8:
        mov ebx, 64h
.9:
        mov edx, dword [PaQueueCount]
        sar edx, 10h
        mov eax, edx
        shl eax, 4
        add eax, edx
        mov edx, dword [PaQueueHead]
        mov edx, dword [byte edx+eax*2+01Eh]
        mov eax, dword [SpeechStreamTimer]
        call QueueSpeechClip
        call SpeechQueueGo
        mov eax, dword [tickcount]
        mov edx, dword [PaQueueCount]
        sar edx, 10h
        mov ebx, eax
        mov eax, edx
        shl eax, 4
        add eax, edx
        mov edx, dword [PaQueueHead]
        mov dword [byte edx+eax*2+01Ah], ebx
        mov edx, dword [PaQueueCount]
        sar edx, 10h
        inc edx
        mov ebx, 18h
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        mov word [PaQueueClip], dx
.10:
        call AsyncStreamStep
        mov ax, word [PaQueueCount]
        cmp ax, word [PaQueueClip]
        je near .23
        mov edx, dword [PaQueueTail]
        sar edx, 10h
        mov eax, edx
        shl eax, 4
        add edx, eax
        mov eax, dword [PaQueueHead]
        add edx, edx
        add edx, eax
        mov eax, dword [tickcount]
        mov ecx, dword [byte edx+01Ah]
        mov edx, eax
        sub edx, ecx
        test edx, edx
        jle near .23
        mov ebx, dword [PaQueueTail]
        sar ebx, 10h
        mov eax, ebx
        shl eax, 4
        add eax, ebx
        mov ebx, dword [PaQueueHead]
        cmp word [ebx+eax*2], byte 0
        jne short .11
        imul edx, dword 2B11h
        jmp short .12
.11:
        imul edx, dword 5622h
.12:
        mov ebx, 64h
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        mov ebx, eax
        mov edx, dword [PaQueueTail]
        sar edx, 10h
        mov eax, edx
        shl eax, 4
        add eax, edx
        mov edx, dword [PaQueueHead]
        cmp ebx, dword [byte edx+eax*2+016h]
        jge short .13
        cmp ebx, 1000h
        jle near .19
.13:
        mov edx, dword [PaQueueTail]
        sar edx, 10h
        mov eax, edx
        shl eax, 4
        add eax, edx
        mov edx, dword [PaQueueHead]
        add eax, eax
        add edx, eax
        mov edi, dword [byte edx+01Eh]
        test edi, edi
        jl short .14
        mov eax, dword [SpeechStreamTimer]
        mov edx, edi
        call ReleaseBankSample
        mov edx, dword [PaQueueTail]
        sar edx, 10h
        mov eax, edx
        shl eax, 4
        add eax, edx
        mov edx, dword [PaQueueHead]
        mov dword [byte edx+eax*2+01Eh], 0FFFFFFFFh
.14:
        mov edx, dword [PaQueueTail]
        sar edx, 10h
        mov eax, edx
        shl eax, 4
        add eax, edx
        mov edx, dword [PaQueueHead]
        add eax, eax
        add edx, eax
        mov ebp, dword [byte edx+016h]
        cmp ebx, ebp
        jle short .15
        mov edx, ebp
        jmp short .16
.15:
        mov edx, ebx
.16:
        mov ecx, dword [PaQueueTail]
        sar ecx, 10h
        mov eax, ecx
        shl eax, 4
        add ecx, eax
        mov eax, dword [PaQueueHead]
        add ecx, ecx
        mov eax, dword [byte ecx+eax+012h]
        add eax, edx
        mov ecx, dword [SpeechStreamRead]
        mov dword [SpeechStreamLen], eax
        cmp eax, ecx
        jne short .17
        mov eax, dword [SpeechStreamBuf]
        mov dword [SpeechStreamRead], eax
        mov dword [SpeechStreamLen], eax
        jmp short .18
.17:
        cmp eax, dword [SpeechStreamEnd]
        jne short .18
        mov eax, dword [SpeechStreamBuf]
        xor edi, edi
        mov dword [SpeechStreamLen], eax
        mov dword [SpeechStreamEnd], edi
.18:
        mov ecx, dword [PaQueueTail]
        sar ecx, 10h
        mov eax, ecx
        shl eax, 4
        add eax, ecx
        mov ecx, dword [PaQueueHead]
        add dword [byte ecx+eax*2+012h], edx
        mov edx, dword [PaQueueTail]
        sar edx, 10h
        mov eax, edx
        shl eax, 4
        add edx, eax
        mov eax, dword [PaQueueHead]
        add edx, edx
        sub dword [byte edx+eax+016h], ebx
        mov eax, dword [tickcount]
        mov edx, dword [PaQueueTail]
        sar edx, 10h
        mov ebx, eax
        mov eax, edx
        shl eax, 4
        add eax, edx
        mov edx, dword [PaQueueHead]
        mov dword [byte edx+eax*2+01Ah], ebx
.19:
        mov edx, dword [PaQueueTail]
        sar edx, 10h
        mov eax, edx
        shl eax, 4
        add eax, edx
        mov edx, dword [PaQueueHead]
        add eax, eax
        add eax, edx
        cmp dword [byte eax+016h], byte 0
        jg near .23
        cmp dword [byte eax+0Eh], byte 0
        jl short .20
        mov ebp, dword [byte eax+06h]
        test ebp, ebp
        je short .20
        push ebp
        call AsyncFreeRequest
        mov edx, dword [PaQueueTail]
        sar edx, 10h
        mov eax, edx
        shl eax, 4
        add eax, edx
        mov edx, dword [PaQueueHead]
        add esp, byte 4
        mov dword [byte edx+eax*2+06h], 0
.20:
        mov edx, dword [PaQueueTail]
        sar edx, 10h
        mov eax, edx
        shl eax, 4
        add eax, edx
        mov ebx, dword [PaQueueHead]
        add eax, eax
        add ebx, eax
        mov edx, dword [byte ebx+016h]
        lea eax, [nosplit edx*4+00h]
        sub eax, edx
        shl eax, 3
        add edx, eax
        shl edx, 2
        mov si, word [ebx]
        neg edx
        test si, si
        jne short .21
        mov ebx, 2B11h
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        mov ebx, eax
        jmp short .22
.21:
        mov ebx, 5622h
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        lea ebx, [byte eax+064h]
.22:
        mov edx, dword [PaQueueTail]
        sar edx, 10h
        inc edx
        mov ecx, 18h
        mov eax, edx
        sar edx, 1Fh
        idiv ecx
        mov di, word [StreamTimerOn]
        mov word [PaQueueCount], dx
        dec di
        mov word [StreamTimerOn], di
        je short .23
        mov eax, dword [tickcount]
        mov edx, dword [PaQueueTail]
        sub eax, ebx
        sar edx, 10h
        mov ebx, eax
        mov eax, edx
        shl eax, 4
        add eax, edx
        mov edx, dword [PaQueueHead]
        mov dword [byte edx+eax*2+01Ah], ebx
.23:
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; QueuePaClip                                     486E8  97 PC, low confidence
; Queues an arena announcer clip
;-----------------------------------------------------------------------------
QueuePaClip:
        push dword 1Ch
        call __CHK
        push ecx
        push esi
        push edi
        push ebp
        mov edi, eax
        mov esi, edx
        cmp dword [PaQueueHead], byte 0
        je near .3
        mov ecx, dword [PaQueueTime]
        sar ecx, 10h
        lea edx, [byte ecx+01h]
        mov ebp, 18h
        mov eax, edx
        sar edx, 1Fh
        idiv ebp
        mov eax, dword [PaQueueTail]
        sar eax, 10h
        cmp edx, eax
        je near .3
        mov eax, ecx
        shl eax, 4
        add eax, ecx
        mov edx, dword [PaQueueHead]
        add eax, eax
        push byte 22h
        add eax, edx
        push eax
        call ZeroMem
        mov edx, dword [PaQueueTime]
        sar edx, 10h
        mov eax, edx
        shl eax, 4
        add eax, edx
        mov edx, dword [PaQueueHead]
        mov word [edx+eax*2], di
        mov edx, dword [PaQueueTime]
        sar edx, 10h
        mov eax, edx
        shl eax, 4
        add eax, edx
        mov edx, dword [PaQueueHead]
        add esp, byte 8
        mov dword [byte edx+eax*2+0Ah], esi
        cmp ebx, 2800h
        jg short .1
        mov edx, dword [PaQueueTime]
        sar edx, 10h
        mov eax, edx
        shl eax, 4
        add edx, eax
        mov eax, dword [PaQueueHead]
        add edx, edx
        mov dword [byte edx+eax+0Eh], 0FFFFFFFFh
        jmp short .2
.1:
        mov edx, dword [PaQueueTime]
        sar edx, 10h
        mov eax, edx
        shl eax, 4
        add eax, edx
        mov edx, dword [PaQueueHead]
        add esi, 2800h
        mov dword [byte edx+eax*2+0Eh], esi
.2:
        mov edx, dword [PaQueueTime]
        sar edx, 10h
        mov eax, edx
        shl eax, 4
        add eax, edx
        mov edx, dword [PaQueueHead]
        mov dword [byte edx+eax*2+016h], ebx
        mov edx, dword [PaQueueTime]
        sar edx, 10h
        inc edx
        mov ebx, 18h
        mov eax, edx
        sar edx, 1Fh
        idiv ebx
        mov word [PaQueuePrev], dx
        inc word [StreamTimerOn]
.3:
        pop ebp
        pop edi
        pop esi
        pop ecx
        ret
        db 090h
;-----------------------------------------------------------------------------
; SayPaClip                                       4880C  97 PC, low confidence
; Plays an arena announcer clip
;-----------------------------------------------------------------------------
SayPaClip:
        push dword 18h
        call __CHK
        push ebx
        push ecx
        push esi
        sub esp, byte 8
        mov esi, eax
        cmp dword [PaQueueHead], byte 0
        jne short .1
        xor eax, eax
        jmp short .3
.1:
        mov ecx, esp
        lea ebx, [byte esp+04h]
        call PickPaClip
        test eax, eax
        je short .3
        mov ecx, dword [esp]
        cmp ecx, byte 5
        jge short .2
        xor eax, eax
        add esp, byte 8
        pop esi
        pop ecx
        pop ebx
        ret
.2:
        mov edx, dword [byte esp+04h]
        mov ebx, ecx
        mov eax, esi
        call QueuePaClip
        mov eax, 1
.3:
        add esp, byte 8
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; PaPlayerName                                    48864  97 PC, low confidence
; Says a player's name over the arena speakers
;-----------------------------------------------------------------------------
PaPlayerName:
        push dword 28h
        call __CHK
        push ebx
        push ecx
        push esi
        push edi
        push ebp
        sub esp, byte 10h
        xor ebx, ebx
        mov dword [byte esp+0Ch], ebx
        mov ebx, edx
        shl ebx, 8
        add ebx, eax
        shl eax, 8
        mov ebp, 0FFFFFFFFh
        add eax, edx
        mov dword [byte esp+04h], ebx
        mov dword [esp], eax
.1:
        mov ecx, dword [byte esp+0Ch]
        inc ecx
        mov dword [byte esp+0Ch], ecx
        cmp cx, byte 1
        je short .2
        mov eax, dword [byte esp+04h]
        jmp short .3
.2:
        mov eax, dword [esp]
.3:
        mov dword [byte esp+08h], eax
        mov eax, 0Fh
        xor edx, edx
.4:
        movsx ecx, ax
        movsx esi, dx
        add ecx, esi
        sar ecx, 1
        movsx esi, cx
        mov ebx, ecx
        lea ecx, [nosplit esi*2+00h]
        mov edi, dword [byte esp+08h]
        cmp di, word [dword ecx+PaNameRanges]
        jle short .5
        mov edx, ebx
        inc edx
        jmp short .7
.5:
        jge short .6
        mov eax, ebx
        dec eax
        jmp short .7
.6:
        mov edi, dword [byte esp+0Ch]
        mov edx, eax
        mov ebp, esi
        inc edi
        inc edx
        mov dword [byte esp+0Ch], edi
.7:
        cmp dx, ax
        jle short .4
        cmp word [byte esp+0Ch], byte 2
        jl short .1
        mov eax, ebp
        add esp, byte 10h
        pop ebp
        pop edi
        pop esi
        pop ecx
        pop ebx
        ret
;-----------------------------------------------------------------------------
; CountRecordGame                              4890C  96 PC, medium confidence
; Counts one game of a W/L/T byte string (1, 2, 3) into the counters the
; caller passes
;-----------------------------------------------------------------------------
CountRecordGame:
        push dword 0Ch
        call __CHK
        push esi
        push edi
        mov esi, eax
        mov edi, ebx
        mov eax, dword [byte esp+0Ch]
        mov ebx, dword [esi]
        cmp byte [ebx], 3
        jne short .1
        inc dword [edx]
        inc dword [eax]
        jmp short .3
.1:
        mov dl, byte [ebx]
        cmp dl, 2
        jne short .2
        inc dword [edi]
        inc dword [eax]
        inc dword [esi]
        pop edi
        pop esi
        ret 4
.2:
        cmp dl, 1
        jne short .3
        inc dword [eax]
        inc dword [ecx]
.3:
        inc dword [esi]
        pop edi
        pop esi
        ret 4
        db 090h
;-----------------------------------------------------------------------------
; RecordPctClip                                48950  96 PC, medium confidence
; Picks clip 9-0Ch from three 16.16 ratios (>= .5, >= .65, >= .6)
;-----------------------------------------------------------------------------
RecordPctClip:
        push dword 10h
        call __CHK
        push esi
        push edi
        push ebp
        mov edi, eax
        mov ebp, edx
        mov esi, ecx
        mov eax, ebx
        shl esi, 10h
        shl eax, 10h
        mov ebx, esi
        cdq
        idiv ebx
        mov ecx, eax
        xor eax, eax
        shrd eax, edx, 10h
        sar edx, 10h
        idiv ebx
        shl ecx, 10h
        add eax, ecx
        cmp eax, 8000h
        jl short .1
        mov eax, 0Ah
        pop ebp
        pop edi
        pop esi
        ret
.1:
        mov eax, edi
        mov ebx, esi
        shl eax, 10h
        cdq
        idiv ebx
        mov ecx, eax
        xor eax, eax
        shrd eax, edx, 10h
        sar edx, 10h
        idiv ebx
        shl ecx, 10h
        add eax, ecx
        cmp eax, 0A666h
        jl short .2
        mov eax, 0Ch
        pop ebp
        pop edi
        pop esi
        ret
.2:
        mov eax, ebp
        mov ebx, esi
        shl eax, 10h
        cdq
        idiv ebx
        mov ecx, eax
        xor eax, eax
        shrd eax, edx, 10h
        sar edx, 10h
        idiv ebx
        shl ecx, 10h
        add eax, ecx
        cmp eax, 9999h
        jl short .3
        mov eax, 0Bh
        pop ebp
        pop edi
        pop esi
        ret
.3:
        mov eax, 9
        pop ebp
        pop edi
        pop esi
        ret
        db 090h
;-----------------------------------------------------------------------------
; RecordStreakClips                            489F4  96 PC, medium confidence
; Reads a team's W/L/T byte string (streak or record) for the play-by-play
; event 4 clips
;-----------------------------------------------------------------------------
RecordStreakClips:
        push dword 44h
        call __CHK
        push esi
        push edi
        push ebp
        sub esp, byte 30h
        mov dword [byte esp+028h], eax
        mov edi, edx
        mov ebp, ebx
        mov dword [byte esp+024h], ecx
        xor edx, edx
        mov dword [byte esp+020h], eax
        mov dword [byte esp+018h], edx
        mov dword [byte esp+014h], edx
        mov dword [byte esp+010h], edx
        mov dword [byte esp+01Ch], edx
        lea esi, [byte eax+0Bh]
        mov word [edi], 0
        mov eax, dword [byte esp+020h]
        mov dl, byte [byte eax+01h]
        test dl, dl
        jne short .3
        mov ch, byte [eax]
        cmp ch, 1
        jne short .1
        mov word [edi], 3
        jmp near .27
.1:
        cmp ch, 3
        jne short .2
        mov word [edi], 2
        jmp near .27
.2:
        mov word [edi], 1
        jmp near .27
.3:
        mov dh, byte [eax]
        cmp dh, 1
        jne short .5
        cmp dl, dh
        jne short .5
        mov word [edi], 4
        add dword [byte esp+020h], byte 2
        mov word [ebx], 0
        mov eax, dword [byte esp+020h]
        cmp dh, byte [eax]
        jne near .27
.4:
        cmp esi, dword [byte esp+020h]
        jbe near .27
        cmp word [byte ebp+00h], byte 2
        jge near .27
        inc word [byte ebp+00h]
        mov edi, dword [byte esp+020h]
        inc edi
        mov dword [byte esp+020h], edi
        cmp byte [edi], 1
        je short .4
        add esp, byte 30h
        pop ebp
        pop edi
        pop esi
        ret
.5:
        mov eax, dword [byte esp+020h]
        mov bh, byte [byte eax+01h]
        cmp bh, byte [eax]
        jne short .8
        mov cl, byte [byte eax+02h]
        cmp cl, byte [eax]
        jne short .8
        cmp byte [eax], 3
        sete al
        xor ah, ah
        add eax, 5
        mov word [edi], ax
        mov edx, dword [byte esp+020h]
        lea ebx, [byte edx+03h]
        mov dword [byte esp+020h], ebx
        mov word [byte ebp+00h], 1
        mov eax, dword [byte esp+020h]
        mov bh, byte [edx]
        cmp bh, byte [eax]
        jne short .7
.6:
        cmp esi, dword [byte esp+020h]
        jbe short .7
        cmp word [byte ebp+00h], byte 9
        jge short .7
        inc dword [byte esp+020h]
        inc word [byte ebp+00h]
        mov eax, dword [byte esp+020h]
        mov bl, byte [edx]
        cmp bl, byte [eax]
        je short .6
.7:
        cmp word [byte ebp+00h], byte 9
        jne near .27
        add word [edi], byte 2
        add esp, byte 30h
        pop ebp
        pop edi
        pop esi
        ret
.8:
        mov eax, dword [byte esp+020h]
        cmp byte [byte eax+02h], 0
        jne short .10
        mov dl, byte [eax]
        cmp dl, 1
        jne short .9
        mov word [edi], 3
        add esp, byte 30h
        pop ebp
        pop edi
        pop esi
        ret
.9:
        cmp dl, 3
        jne near .2
        mov word [edi], 2
        add esp, byte 30h
        pop ebp
        pop edi
        pop esi
        ret
.10:
        xor eax, eax
        mov dword [byte esp+02Ch], eax
.11:
        lea eax, [byte esp+010h]
        lea ecx, [byte esp+014h]
        lea ebx, [byte esp+018h]
        push eax
        lea edx, [byte esp+020h]
        lea eax, [byte esp+024h]
        call CountRecordGame
        mov eax, dword [byte esp+02Ch]
        inc eax
        mov dword [byte esp+02Ch], eax
        cmp eax, byte 3
        jl short .11
        mov ecx, dword [byte esp+010h]
        mov ebx, dword [byte esp+014h]
        mov edx, dword [byte esp+018h]
        mov eax, dword [byte esp+01Ch]
        call RecordPctClip
        mov word [edi], ax
        mov eax, dword [byte esp+020h]
        mov dh, byte [eax]
        dec esi
        test dh, dh
        je near .18
.12:
        cmp esi, dword [byte esp+020h]
        jbe near .18
        cmp word [edi], byte 9
        jne short .13
        lea eax, [byte esp+010h]
        lea ecx, [byte esp+014h]
        lea ebx, [byte esp+018h]
        push eax
        lea edx, [byte esp+020h]
        lea eax, [byte esp+024h]
        call CountRecordGame
.13:
        mov ecx, dword [byte esp+010h]
        mov ebx, dword [byte esp+014h]
        mov edx, dword [byte esp+018h]
        mov eax, dword [byte esp+01Ch]
        call RecordPctClip
        mov edx, eax
        cmp eax, byte 9
        je near .17
        mov word [edi], ax
        mov eax, dword [byte esp+020h]
        cmp byte [eax], 0
        je near .17
.14:
        cmp esi, dword [byte esp+020h]
        jbe near .17
        mov eax, dword [byte esp+01Ch]
        mov dword [byte esp+0Ch], eax
        mov eax, dword [byte esp+018h]
        mov dword [byte esp+08h], eax
        mov eax, dword [byte esp+014h]
        mov dword [byte esp+04h], eax
        mov eax, dword [byte esp+010h]
        lea ecx, [byte esp+04h]
        mov dword [esp], eax
        mov eax, esp
        lea ebx, [byte esp+08h]
        push eax
        lea edx, [byte esp+010h]
        lea eax, [byte esp+024h]
        call CountRecordGame
        mov ecx, dword [esp]
        mov ebx, dword [byte esp+04h]
        mov edx, dword [byte esp+08h]
        mov eax, dword [byte esp+0Ch]
        call RecordPctClip
        movsx edx, word [edi]
        cmp eax, edx
        jne short .15
        mov eax, dword [byte esp+0Ch]
        mov dword [byte esp+01Ch], eax
        mov eax, dword [byte esp+08h]
        mov dword [byte esp+018h], eax
        mov eax, dword [byte esp+04h]
        mov dword [byte esp+014h], eax
        mov eax, dword [esp]
        mov dword [byte esp+010h], eax
        jmp short .16
.15:
        mov dword [byte esp+020h], esi
.16:
        mov eax, dword [byte esp+020h]
        cmp byte [eax], 0
        jne near .14
.17:
        mov eax, dword [byte esp+020h]
        cmp byte [eax], 0
        jne near .12
.18:
        mov cx, word [edi]
        cmp cx, byte 9
        jne short .20
        mov eax, dword [byte esp+028h]
        mov ch, byte [eax]
        cmp ch, 1
        jne short .19
        mov word [edi], 3
        add esp, byte 30h
        pop ebp
        pop edi
        pop esi
        ret
.19:
        cmp ch, 3
        jne near .2
        mov word [edi], 2
        add esp, byte 30h
        pop ebp
        pop edi
        pop esi
        ret
.20:
        mov eax, ecx
        cmp cx, byte 0Bh
        jb short .21
        jbe short .23
        cmp cx, byte 0Ch
        je short .22
        jmp short .26
.21:
        cmp cx, byte 0Ah
        je short .24
        jmp short .26
.22:
        mov eax, dword [byte esp+01Ch]
        jmp short .25
.23:
        mov eax, dword [byte esp+018h]
        jmp short .25
.24:
        mov eax, dword [byte esp+014h]
.25:
        dec eax
        mov word [byte ebp+00h], ax
.26:
        mov eax, dword [byte esp+010h]
        mov edx, dword [byte esp+024h]
        sub eax, byte 2
        mov word [edx], ax
.27:
        add esp, byte 30h
        pop ebp
        pop edi
        pop esi
        ret
        db 08Bh,0C0h
PaEventJumpTable:                               ; jump table for the switch cases of PaEvent
        dd PaEvent_4D6
        dd PaEvent_4EC
        dd PaEvent_502
        dd PaEvent_518
        dd PaEvent_536
        dd PaEvent_572
        dd PaEvent_5AE
        dd PaEvent_5D6
        dd PaEvent_14CD
        dd PaEvent_5FE
        dd PaEvent_64E
        dd PaEvent_69E
PaEventArgJumpTable:                            ; jump table for the switch cases of PaEvent
        dd PaEvent_745
        dd PaEvent_7FF
        dd PaEvent_87E
        dd PaEvent_8CF
        dd PaEvent_8F5
        dd PaEvent_91B
        dd PaEvent_941
        dd PaEvent_967
;-----------------------------------------------------------------------------
; PaEvent                                         48D70  96 PC, low confidence
;
; The arena PA announcer: B events (0B000001h-0B000006h) from the front end and pre-game screens, C events
; (0C000001h-0C000004h) in game; ClockTick posts 0C0000004h at one minute left in a period. The play-by-play
; is CommentaryEvent
;-----------------------------------------------------------------------------
PaEvent:
        push dword 5Ch
        call __CHK
        push ebx
        push ecx
        push edx
        push esi
        push edi
        push ebp
        sub esp, byte 40h
        test byte [MusicOptions], 2
        je near PaEvent_14CD
        cmp dword [SoundDriverId], byte 1
        jl near PaEvent_14CD
        mov eax, 0FFFFFFFFh
        call ReplaySoundAllowed
        test eax, eax
        je near PaEvent_14CD
        mov ebx, dword [byte esp+05Ch]
        lea edx, [byte esp+060h]
        cmp ebx, 0B0000006h
        jb short .2
        jbe near PaEvent_69E.53
        cmp ebx, 0C0000001h
        jb short .1
        lea eax, [byte edx+04h]
        jbe near PaEvent_967.70
        cmp ebx, 0C0000003h
        jb near PaEvent_967.89
        jbe near PaEvent_967.105
        cmp ebx, 0C0000004h
        je near PaEvent_967.158
        jmp near PaEvent_14CD
.1:
        cmp ebx, 0B0000007h
        jbe near PaEvent_967.64
        cmp ebx, 0B0000008h
        je near .19
        jmp near PaEvent_14CD
.2:
        cmp ebx, 0B0000003h
        jb short .3
        jbe near .21
        cmp ebx, 0B0000004h
        jbe short .4
        jmp near .48
.3:
        cmp ebx, 0B0000001h
        jb near PaEvent_14CD
        ja near .20
        cmp dword [SoundDriverId], byte 1
        jne near PaEvent_14CD
        xor edx, edx
        xor eax, eax
        jmp near PaEvent_967.161
.4:
        cmp dword [SoundDriverId], byte 1
        jne near PaEvent_14CD
        xor eax, eax
        shl eax, 2
.5:
        add eax, byte 4
        mov ebx, dword [edx]
        add edx, byte 4
        mov dword [byte esp+eax-04h], ebx
        cmp eax, byte 14h
        jne short .5
        mov edi, dword [esp]
        mov eax, 5
        cmp edi, byte 0FFFFFFFFh
        jge short .6
        xor eax, eax
.6:
        mov ebp, dword [byte esp+04h]
        test ebp, ebp
        jl short .7
        cmp ebp, byte 22h
        jle short .8
.7:
        xor eax, eax
.8:
        mov ebx, dword [byte esp+08h]
        test ebx, ebx
        jl short .9
        cmp ebx, byte 1Eh
        jle short .10
.9:
        xor eax, eax
.10:
        mov esi, dword [byte esp+0Ch]
        test esi, esi
        jl short .11
        cmp esi, byte 22h
        jle short .12
.11:
        xor eax, eax
.12:
        mov ebp, dword [byte esp+010h]
        test ebp, ebp
        jl short .13
        cmp ebp, byte 1Eh
        jle short .14
.13:
        xor eax, eax
.14:
        test eax, eax
        je near PaEvent_14CD
        mov ebx, dword [esp]
        cmp ebx, byte 0FFFFFFFFh
        jne short .15
        mov edx, 9Eh
        jmp short .17
.15:
        cmp ebx, byte 4
        jle short .16
        mov edx, 0A4h
        jmp short .17
.16:
        lea edx, [dword ebx+09Fh]
.17:
        xor eax, eax
        call SayPaClip
        cmp dword [esp], byte 0FFFFFFFFh
        jne short .18
        mov edx, dword [byte esp+0Ch]
        xor eax, eax
        add edx, 0A5h
        call SayPaClip
        mov edx, dword [byte esp+010h]
        xor eax, eax
        add edx, 0C8h
        call SayPaClip
        mov edx, dword [byte esp+04h]
        xor eax, eax
        add edx, 0E7h
        call SayPaClip
        mov edx, dword [byte esp+08h]
        xor eax, eax
        add edx, 10Ah
        call SayPaClip
        add esp, byte 40h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.18:
        mov edx, dword [byte esp+04h]
        xor eax, eax
        add edx, 0A5h
        call SayPaClip
        mov edx, dword [byte esp+08h]
        xor eax, eax
        add edx, 0C8h
        call SayPaClip
        mov edx, dword [byte esp+0Ch]
        xor eax, eax
        add edx, 0E7h
        call SayPaClip
        mov edx, dword [byte esp+010h]
        xor eax, eax
        add edx, 10Ah
        call SayPaClip
        add esp, byte 40h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.19:
        cmp dword [SoundDriverId], byte 1
        jne near PaEvent_14CD
        mov edx, 1A2h
        xor eax, eax
        call SayPaClip
        add esp, byte 40h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.20:
        cmp dword [SoundDriverId], byte 1
        jne near PaEvent_14CD
        mov edx, 1A1h
        xor eax, eax
        call SayPaClip
        add esp, byte 40h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.21:
        cmp dword [SoundDriverId], byte 1
        jne near PaEvent_14CD
        xor eax, eax
        shl eax, 2
.22:
        add eax, byte 4
        mov ebx, dword [edx]
        add edx, byte 4
        mov dword [byte esp+eax-04h], ebx
        cmp eax, byte 14h
        jne short .22
        mov edi, dword [esp]
        mov eax, 5
        test edi, edi
        jl short .23
        cmp edi, byte 1Ah
        jl short .24
.23:
        xor eax, eax
.24:
        mov edx, dword [byte esp+04h]
        test edx, edx
        jl short .25
        cmp edx, byte 7
        jle short .26
.25:
        xor eax, eax
.26:
        mov ecx, dword [byte esp+08h]
        cmp ecx, byte 1
        jl short .27
        cmp ecx, 200h
        jle short .28
.27:
        xor eax, eax
.28:
        mov edi, dword [byte esp+0Ch]
        test edi, edi
        jl short .29
        cmp edi, byte 23h
        jle short .30
.29:
        xor eax, eax
.30:
        mov edx, dword [byte esp+010h]
        test edx, edx
        jl short .31
        cmp edx, byte 23h
        jle short .32
.31:
        xor eax, eax
.32:
        test eax, eax
        je near PaEvent_14CD
        mov edx, dword [byte esp+010h]
        mov eax, dword [byte esp+0Ch]
        call PaPlayerName
        mov edx, eax
        mov ebx, eax
        test eax, eax
        jl short .33
        lea edx, [dword eax+08Fh]
        xor eax, eax
        call SayPaClip
        add esp, byte 40h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.33:
        mov ecx, dword [esp]
        call rand_
        mov edx, eax
        mov esi, 2
        sar edx, 1Fh
        idiv esi
        add ecx, ecx
        inc ecx
        add edx, ecx
        xor eax, eax
        call SayPaClip
        mov ecx, dword [byte esp+04h]
        test ecx, ecx
        jle short .34
        lea edx, [byte ecx+034h]
        xor eax, eax
        call SayPaClip
.34:
        mov esi, dword [byte esp+08h]
        cmp esi, byte 10h
        jb short .36
        jbe near .42
        cmp esi, 80h
        jb short .35
        jbe near .45
        cmp esi, 100h
        jb near .47
        jbe near .46
        cmp esi, 200h
        je near .39
        jmp near .47
.35:
        cmp esi, byte 20h
        jb near .47
        jbe near .43
        cmp esi, byte 40h
        je near .44
        jmp near .47
.36:
        cmp esi, byte 2
        jb short .37
        jbe short .38
        cmp esi, byte 4
        jb near .47
        jbe short .40
        cmp esi, byte 8
        je short .41
        jmp near .47
.37:
        cmp esi, byte 1
        jne short .47
        call rand_
        mov edx, eax
        mov ebx, 2
        sar edx, 1Fh
        idiv ebx
        lea ebx, [byte edx+043h]
        jmp short .47
.38:
        call rand_
        mov edx, eax
        mov ebx, 3
        sar edx, 1Fh
        idiv ebx
        lea ebx, [byte edx+046h]
        jmp short .47
.39:
        mov ebx, 45h
        jmp short .47
.40:
        mov ebx, 41h
        jmp short .47
.41:
        mov ebx, 3Fh
        jmp short .47
.42:
        mov ebx, 3Dh
        jmp short .47
.43:
        mov ebx, 42h
        jmp short .47
.44:
        mov ebx, esi
        jmp short .47
.45:
        mov ebx, 3Eh
        jmp short .47
.46:
        mov ebx, 3Ch
.47:
        mov edx, ebx
        xor eax, eax
        call SayPaClip
        mov edx, dword [byte esp+0Ch]
        xor eax, eax
        add edx, byte 49h
        call SayPaClip
        mov edx, dword [byte esp+010h]
        xor eax, eax
        add edx, byte 6Ch
        call SayPaClip
        add esp, byte 40h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.48:
        mov edi, dword [SoundDriverId]
        cmp edi, byte 1
        jne near PaEvent_14CD
        mov eax, dword [edx]
        add edx, byte 4
        mov ebx, edi
        mov dword [esp], eax
        test eax, eax
        jl short .49
        cmp eax, byte 1Ah
        jl short .50
.49:
        xor ebx, ebx
.50:
        test ebx, ebx
        je short .52
        mov esi, dword [edx]
        add edx, byte 4
        test esi, esi
        je short .51
        cmp byte [esi], 0
        jne short .52
.51:
        xor ebx, ebx
.52:
        test ebx, ebx
        je near PaEvent_14CD
        lea ecx, [byte esp+038h]
        lea ebx, [byte esp+03Ch]
        lea edx, [byte esp+034h]
        mov eax, esi
        call RecordStreakClips
        mov edx, dword [esp]
        xor eax, eax
        add edx, 129h
        call SayPaClip
        mov eax, dword [byte esp+034h]
        dec eax
        cmp ax, 0Bh
        ja near PaEvent_14CD
        and eax, 0FFFFh
        jmp dword [nosplit cs:eax*4+PaEventJumpTable]
PaEvent_4D6:
        mov edx, 15Bh
        xor eax, eax
        call SayPaClip
        add esp, byte 40h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
PaEvent_4EC:
        mov edx, 15Ah
        xor eax, eax
        call SayPaClip
        add esp, byte 40h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
PaEvent_502:
        mov edx, 15Ch
        xor eax, eax
        call SayPaClip
        add esp, byte 40h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
PaEvent_518:
        mov edx, dword [byte esp+03Ah]
        sar edx, 10h
        xor eax, eax
        add edx, 14Eh
        call SayPaClip
        add esp, byte 40h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
PaEvent_536:
        call rand_
        mov edx, eax
        mov ebx, 3
        sar edx, 1Fh
        idiv ebx
        add edx, 14Bh
        xor eax, eax
        call SayPaClip
        mov edx, dword [byte esp+03Ah]
        sar edx, 10h
        xor eax, eax
        add edx, 15Dh
        call SayPaClip
        add esp, byte 40h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
PaEvent_572:
        call rand_
        mov edx, eax
        mov ebx, 4
        sar edx, 1Fh
        idiv ebx
        add edx, 147h
        xor eax, eax
        call SayPaClip
        mov edx, dword [byte esp+03Ah]
        sar edx, 10h
        xor eax, eax
        add edx, 15Dh
        call SayPaClip
        add esp, byte 40h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
PaEvent_5AE:
        call rand_
        mov edx, eax
        mov ebx, 2
        sar edx, 1Fh
        idiv ebx
        add edx, 145h
        xor eax, eax
        call SayPaClip
        add esp, byte 40h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
PaEvent_5D6:
        call rand_
        mov edx, eax
        mov ebx, 2
        sar edx, 1Fh
        idiv ebx
        add edx, 143h
        xor eax, eax
        call SayPaClip
        add esp, byte 40h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
PaEvent_5FE:
        call rand_
        mov edx, eax
        mov ebx, 2
        sar edx, 1Fh
        idiv ebx
        add edx, 158h
        xor eax, eax
        call SayPaClip
        mov edx, dword [byte esp+03Ah]
        sar edx, 10h
        xor eax, eax
        add edx, 17Ah
        call SayPaClip
        mov edx, dword [byte esp+036h]
        sar edx, 10h
        xor eax, eax
        add edx, 184h
        call SayPaClip
        add esp, byte 40h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
PaEvent_64E:
        call rand_
        mov edx, eax
        mov ebx, 3
        sar edx, 1Fh
        idiv ebx
        add edx, 155h
        xor eax, eax
        call SayPaClip
        mov edx, dword [byte esp+03Ah]
        sar edx, 10h
        xor eax, eax
        add edx, 170h
        call SayPaClip
        mov edx, dword [byte esp+036h]
        sar edx, 10h
        xor eax, eax
        add edx, 184h
        call SayPaClip
        add esp, byte 40h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
PaEvent_69E:
        call rand_
        mov edx, eax
        mov ebx, 4
        sar edx, 1Fh
        idiv ebx
        add edx, 151h
        xor eax, eax
        call SayPaClip
        mov edx, dword [byte esp+03Ah]
        sar edx, 10h
        xor eax, eax
        add edx, 166h
        call SayPaClip
        mov edx, dword [byte esp+036h]
        sar edx, 10h
        xor eax, eax
        add edx, 184h
        call SayPaClip
        add esp, byte 40h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.53:
        mov ecx, dword [SoundDriverId]
        cmp ecx, byte 1
        jne near PaEvent_14CD
        mov eax, dword [edx]
        add edx, byte 4
        mov ebx, ecx
        mov dword [esp], eax
        test eax, eax
        jl short .54
        cmp eax, byte 1Ah
        jl short .55
.54:
        xor ebx, ebx
.55:
        mov eax, dword [edx]
        add edx, byte 4
        mov dword [byte esp+04h], eax
        cmp eax, byte 1
        jl short .56
        cmp eax, byte 8
        jle short .57
.56:
        xor ebx, ebx
.57:
        test ebx, ebx
        je near PaEvent_14CD
        mov eax, dword [byte esp+04h]
        dec eax
        cmp eax, byte 7
        ja near PaEvent_14CD
        jmp dword [nosplit cs:eax*4+PaEventArgJumpTable]
PaEvent_745:
        mov eax, dword [edx]
        add edx, byte 4
        mov dword [byte esp+08h], eax
        cmp eax, byte 1
        jl short .58
        cmp eax, byte 3
        jle short .59
.58:
        xor ebx, ebx
.59:
        test ebx, ebx
        je near PaEvent_14CD
        mov eax, dword [edx]
        add edx, byte 4
        mov dword [byte esp+0Ch], eax
        test eax, eax
        jl near PaEvent_14CD
        cmp eax, dword [byte esp+08h]
        jge near PaEvent_14CD
        mov edx, dword [esp]
        xor eax, eax
        add edx, 129h
        call SayPaClip
        mov edx, 18Dh
        xor eax, eax
        call SayPaClip
        mov edx, dword [byte esp+08h]
        xor eax, eax
        add edx, 195h
        call SayPaClip
        mov ebp, dword [byte esp+0Ch]
        test ebp, ebp
        jne short .61
        call rand_
        mov edx, eax
        mov ebx, 2
        sar edx, 1Fh
        idiv ebx
        test edx, edx
        je short .60
        mov edx, 7
.60:
        mov eax, dword [byte esp+0Ch]
        add eax, 19Ch
        add edx, eax
        xor eax, eax
        call SayPaClip
        add esp, byte 40h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.61:
        lea edx, [dword ebp+019Ch]
        xor eax, eax
        call SayPaClip
        add esp, byte 40h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
PaEvent_7FF:
        mov eax, dword [edx]
        add edx, byte 4
        mov dword [byte esp+08h], eax
        test eax, eax
        jl short .62
        cmp eax, byte 2
        jle short .63
.62:
        xor ebx, ebx
.63:
        test ebx, ebx
        je near PaEvent_14CD
        mov eax, dword [edx]
        add edx, byte 4
        mov dword [byte esp+0Ch], eax
        test eax, eax
        jle near PaEvent_14CD
        cmp eax, dword [byte esp+08h]
        jle near PaEvent_14CD
        mov edx, dword [esp]
        xor eax, eax
        add edx, 129h
        call SayPaClip
        mov edx, 18Eh
        xor eax, eax
        call SayPaClip
        mov edx, dword [byte esp+08h]
        xor eax, eax
        add edx, 195h
        call SayPaClip
        mov edx, dword [byte esp+0Ch]
        xor eax, eax
        add edx, 19Ch
        call SayPaClip
        add esp, byte 40h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
PaEvent_87E:
        mov eax, dword [edx]
        add edx, byte 4
        mov dword [byte esp+08h], eax
        test eax, eax
        jle near PaEvent_14CD
        cmp eax, byte 4
        jge near PaEvent_14CD
        mov edx, dword [esp]
        xor eax, eax
        add edx, 129h
        call SayPaClip
        mov edx, 18Fh
        xor eax, eax
        call SayPaClip
        mov edx, dword [byte esp+08h]
        xor eax, eax
        add edx, 198h
        call SayPaClip
        add esp, byte 40h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
PaEvent_8CF:
        mov edx, dword [esp]
        xor eax, eax
        add edx, 129h
        call SayPaClip
        mov edx, 190h
        xor eax, eax
        call SayPaClip
        add esp, byte 40h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
PaEvent_8F5:
        mov edx, dword [esp]
        xor eax, eax
        add edx, 129h
        call SayPaClip
        mov edx, 191h
        xor eax, eax
        call SayPaClip
        add esp, byte 40h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
PaEvent_91B:
        mov edx, dword [esp]
        xor eax, eax
        add edx, 129h
        call SayPaClip
        mov edx, 192h
        xor eax, eax
        call SayPaClip
        add esp, byte 40h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
PaEvent_941:
        mov edx, dword [esp]
        xor eax, eax
        add edx, 129h
        call SayPaClip
        mov edx, 193h
        xor eax, eax
        call SayPaClip
        add esp, byte 40h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
PaEvent_967:
        mov edx, dword [esp]
        xor eax, eax
        add edx, 129h
        call SayPaClip
        mov edx, 194h
        xor eax, eax
        call SayPaClip
        add esp, byte 40h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.64:
        cmp dword [SoundDriverId], byte 1
        jne near PaEvent_14CD
        xor eax, eax
        shl eax, 2
.65:
        add eax, byte 4
        mov ebx, dword [edx]
        add edx, byte 4
        mov dword [byte esp+eax-04h], ebx
        cmp eax, byte 8
        jne short .65
        mov edx, dword [esp]
        mov eax, 2
        test edx, edx
        jl short .66
        cmp edx, byte 1Ah
        jl short .67
.66:
        xor eax, eax
.67:
        mov ecx, dword [byte esp+04h]
        test ecx, ecx
        jl short .68
        cmp ecx, byte 6
        jle short .69
.68:
        xor eax, eax
.69:
        test eax, eax
        je near PaEvent_14CD
        mov edx, dword [esp]
        xor eax, eax
        add edx, 129h
        call SayPaClip
        mov edx, dword [byte esp+04h]
        xor eax, eax
        add edx, 1A3h
        call SayPaClip
        add esp, byte 40h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.70:
        mov ebp, dword [SoundDriverId]
        cmp ebp, byte 2
        jne near PaEvent_14CD
        mov edx, eax
        mov eax, dword [byte eax-04h]
        mov ebx, 1
        mov dword [esp], eax
        test eax, eax
        jl short .71
        cmp eax, ebp
        jle short .72
.71:
        xor ebx, ebx
.72:
        mov eax, dword [edx]
        add edx, byte 4
        mov dword [byte esp+04h], eax
        test eax, eax
        je short .73
        mov eax, dword [HomeTeamRating]
        jmp short .74
.73:
        mov eax, dword [PaEventValue]
.74:
        sar eax, 10h
        mov dword [byte esp+04h], eax
        mov ebp, dword [byte esp+04h]
        test ebp, ebp
        jl short .75
        cmp ebp, byte 23h
        jle short .76
.75:
        xor ebx, ebx
.76:
        mov ecx, dword [edx]
        xor eax, eax
        mov al, byte [dword ecx+0BCh]
        add edx, byte 4
        mov dword [byte esp+08h], eax
        cmp eax, byte 1
        jl short .77
        cmp eax, byte 63h
        jle short .78
.77:
        xor ebx, ebx
.78:
        mov eax, dword [byte ecx+04h]
        mov dword [byte esp+0Ch], eax
        test eax, eax
        jge short .79
        xor ebx, ebx
.79:
        test ebx, ebx
        je near .85
        cmp dword [esp], byte 0
        jle near .85
        mov eax, dword [edx]
        mov dword [byte esp+02Ch], eax
        mov esi, dword [byte esp+02Ch]
        xor eax, eax
        mov al, byte [dword esi+0BCh]
        add edx, byte 4
        mov dword [byte esp+010h], eax
        cmp eax, byte 1
        jl short .80
        cmp eax, byte 63h
        jle short .81
.80:
        xor ebx, ebx
.81:
        mov eax, dword [byte esp+02Ch]
        mov eax, dword [byte eax+04h]
        mov dword [byte esp+014h], eax
        test eax, eax
        jge short .82
        xor ebx, ebx
.82:
        cmp dword [esp], byte 1
        jle short .85
        mov eax, dword [edx]
        add edx, byte 4
        mov dword [byte esp+030h], eax
        mov edx, dword [byte esp+030h]
        xor eax, eax
        mov al, byte [dword edx+0BCh]
        mov dword [byte esp+018h], eax
        cmp eax, byte 1
        jl short .83
        cmp eax, byte 63h
        jle short .84
.83:
        xor ebx, ebx
.84:
        mov eax, dword [byte esp+030h]
        mov eax, dword [byte eax+04h]
        mov dword [byte esp+01Ch], eax
        test eax, eax
        jge short .85
        xor ebx, ebx
.85:
        test ebx, ebx
        je near PaEvent_14CD
        mov edx, dword [byte esp+04h]
        mov eax, 2
        call SayPaClip
        mov edx, dword [byte esp+08h]
        mov eax, 2
        add edx, 4B4h
        call SayPaClip
        cmp dword [ecx], byte 0
        jne short .86
        mov eax, dword [GameSettings]
        and eax, byte 0Ch
        cmp eax, byte 8
        je short .86
        mov edx, dword [byte esp+0Ch]
        mov eax, 2
        add edx, 518h
        call SayPaClip
.86:
        cmp dword [esp], byte 0
        jle near PaEvent_14CD
        mov edx, 47Fh
        mov eax, 2
        call SayPaClip
        cmp dword [esp], byte 1
        jle near .88
        mov edx, dword [byte esp+010h]
        mov eax, 2
        add edx, byte 6Ah
        call SayPaClip
        mov eax, dword [byte esp+02Ch]
        cmp dword [eax], byte 0
        jne short .87
        mov eax, dword [GameSettings]
        and eax, byte 0Ch
        cmp eax, byte 8
        je short .87
        mov edx, dword [byte esp+014h]
        mov eax, 2
        add edx, 0CEh
        call SayPaClip
.87:
        mov edx, 480h
        mov eax, 2
        call SayPaClip
        mov edx, dword [byte esp+018h]
        mov eax, 2
        add edx, 4B4h
        call SayPaClip
        mov eax, dword [byte esp+030h]
        cmp dword [eax], byte 0
        jne near PaEvent_14CD
        mov eax, dword [GameSettings]
        and eax, byte 0Ch
        cmp eax, byte 8
        je near PaEvent_14CD
        mov edx, dword [byte esp+01Ch]
        mov eax, 2
        add edx, 518h
        call SayPaClip
        add esp, byte 40h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.88:
        mov edx, dword [byte esp+010h]
        mov eax, 2
        add edx, 4B4h
        call SayPaClip
        mov eax, dword [byte esp+02Ch]
        cmp dword [eax], byte 0
        jne near PaEvent_14CD
        mov eax, dword [GameSettings]
        and eax, byte 0Ch
        cmp eax, byte 8
        je near PaEvent_14CD
        mov edx, dword [byte esp+014h]
        mov eax, 2
        add edx, 518h
        call SayPaClip
        add esp, byte 40h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.89:
        cmp dword [SoundDriverId], byte 2
        jne near PaEvent_14CD
        mov edx, eax
        mov eax, dword [byte eax-04h]
        mov ebx, 1
        mov dword [esp], eax
        test eax, eax
        je short .90
        mov eax, dword [HomeTeamRating]
        jmp short .91
.90:
        mov eax, dword [PaEventValue]
.91:
        sar eax, 10h
        mov dword [esp], eax
        mov ebp, dword [esp]
        test ebp, ebp
        jl short .92
        cmp ebp, byte 23h
        jle short .93
.92:
        xor ebx, ebx
.93:
        mov eax, dword [edx]
        add edx, byte 4
        mov dword [byte esp+04h], eax
        test eax, eax
        jl short .94
        cmp eax, byte 1
        jle short .95
.94:
        xor ebx, ebx
.95:
        mov ecx, dword [edx]
        xor eax, eax
        mov al, byte [dword ecx+0BCh]
        add edx, byte 4
        mov dword [byte esp+08h], eax
        test eax, eax
        jl short .96
        cmp eax, byte 63h
        jle short .97
.96:
        xor ebx, ebx
.97:
        mov eax, dword [byte ecx+04h]
        mov dword [byte esp+0Ch], eax
        test eax, eax
        jge short .98
        xor ebx, ebx
.98:
        cmp dword [byte esp+04h], byte 0
        je short .101
        mov eax, dword [edx]
        add edx, byte 4
        mov dword [byte esp+02Ch], eax
        mov edx, dword [byte esp+02Ch]
        xor eax, eax
        mov al, byte [dword edx+0BCh]
        mov dword [byte esp+010h], eax
        test eax, eax
        jl short .99
        cmp eax, byte 63h
        jle short .100
.99:
        xor ebx, ebx
.100:
        mov eax, dword [byte esp+02Ch]
        mov eax, dword [byte eax+04h]
        mov dword [byte esp+014h], eax
        test eax, eax
        jge short .101
        xor ebx, ebx
.101:
        test ebx, ebx
        je near PaEvent_14CD
        mov edx, dword [esp]
        mov eax, 2
        add edx, byte 46h
        call SayPaClip
        mov edx, dword [byte esp+08h]
        mov eax, 2
        add edx, byte 6Ah
        call SayPaClip
        mov eax, dword [GameSettings]
        mov ebx, dword [byte esp+04h]
        and eax, byte 0Ch
        test ebx, ebx
        je near .104
        cmp dword [ecx], byte 0
        jne short .102
        cmp eax, byte 8
        je short .102
        mov edx, dword [byte esp+0Ch]
        mov eax, 2
        add edx, 0CEh
        call SayPaClip
.102:
        mov edx, 481h
        mov eax, 2
        call SayPaClip
        cmp dword [ecx], byte 0
        jne short .103
        mov eax, dword [GameSettings]
        and eax, byte 0Ch
        cmp eax, byte 8
        je short .103
        mov edx, dword [byte esp+010h]
        mov eax, 2
        add edx, 4B4h
        call SayPaClip
        mov edx, dword [byte esp+014h]
        mov eax, 2
        add edx, 518h
        call SayPaClip
        add esp, byte 40h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.103:
        mov edx, dword [byte esp+010h]
        mov eax, 2
        add edx, byte 6Ah
        call SayPaClip
        add esp, byte 40h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.104:
        mov edx, dword [byte esp+02Ch]
        cmp dword [edx], byte 0
        jne near PaEvent_14CD
        cmp eax, byte 8
        je near PaEvent_14CD
        mov edx, dword [byte esp+0Ch]
        mov eax, 2
        add edx, 518h
        call SayPaClip
        add esp, byte 40h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.105:
        cmp dword [SoundDriverId], byte 2
        jne near PaEvent_14CD
        mov edx, eax
        mov eax, dword [byte eax-04h]
        mov ebx, 1
        mov dword [esp], eax
        test eax, eax
        je short .106
        mov eax, dword [HomeTeamRating]
        jmp short .107
.106:
        mov eax, dword [PaEventValue]
.107:
        sar eax, 10h
        mov dword [esp], eax
        mov edi, dword [esp]
        test edi, edi
        jl short .108
        cmp edi, byte 23h
        jle short .109
.108:
        xor ebx, ebx
.109:
        mov eax, dword [edx]
        add edx, byte 4
        mov dword [byte esp+04h], eax
        cmp eax, byte 1
        jl short .110
        cmp eax, byte 2
        jle short .111
.110:
        xor ebx, ebx
.111:
        mov ecx, dword [edx]
        xor eax, eax
        mov al, byte [dword ecx+0BCh]
        add edx, byte 4
        mov dword [byte esp+08h], eax
        cmp eax, byte 1
        jl short .112
        cmp eax, byte 63h
        jle short .113
.112:
        xor ebx, ebx
.113:
        mov eax, dword [byte ecx+04h]
        mov dword [byte esp+0Ch], eax
        test eax, eax
        jge short .114
        xor ebx, ebx
.114:
        mov eax, dword [edx]
        mov dword [byte esp+010h], eax
        mov esi, dword [byte esp+012h]
        and esi, 7000h
        add edx, byte 4
        mov word [byte esp+012h], si
        and eax, 0FFF0000h
        mov esi, dword [byte esp+010h]
        mov dword [byte esp+020h], eax
        cmp esi, 70000001h
        jl short .115
        cmp eax, 10000h
        jl short .115
        cmp esi, 70000012h
        jg short .115
        cmp eax, 0F0000h
        jle short .116
.115:
        xor ebx, ebx
.116:
        test ebx, ebx
        je near .121
        cmp dword [byte esp+04h], byte 2
        jne near .121
        mov esi, dword [byte esp+02Ch]
        xor eax, eax
        mov al, byte [dword esi+0BCh]
        add edx, byte 4
        mov dword [byte esp+014h], eax
        cmp eax, byte 1
        jl short .117
        cmp eax, byte 63h
        jle short .118
.117:
        xor ebx, ebx
.118:
        mov eax, dword [byte esp+02Ch]
        mov eax, dword [byte eax+04h]
        mov dword [byte esp+018h], eax
        test eax, eax
        jge short .119
        xor ebx, ebx
.119:
        mov eax, dword [edx]
        mov dword [byte esp+01Ch], eax
        mov edi, dword [byte esp+01Eh]
        and edi, 7000h
        add edx, byte 4
        mov word [byte esp+01Eh], di
        and eax, 0FFF0000h
        mov edx, dword [byte esp+01Ch]
        mov dword [byte esp+024h], eax
        cmp edx, 70000001h
        jl short .120
        cmp eax, 10000h
        jl short .120
        cmp edx, 70000012h
        jg short .120
        cmp eax, 0F0000h
        jle short .121
.120:
        xor ebx, ebx
.121:
        test ebx, ebx
        je near PaEvent_14CD
        mov eax, dword [byte esp+010h]
        cmp eax, 70000009h
        jg near .126
        test byte [byte esp+022h], 8
        je short .123
        cmp eax, 70000001h
        jne short .122
        cmp dword [byte esp+020h], 80000h
        jne short .122
        xor edx, edx
        mov eax, 4B4h
        mov dword [byte esp+020h], edx
        mov dword [byte esp+010h], eax
        jmp near .136
.122:
        cmp dword [byte esp+020h], 0C0000h
        jne near .135
        mov ebp, dword [byte esp+010h]
        mov edi, 1
        sub ebp, 6FFFFB5Ah
        mov dword [byte esp+020h], edi
        mov dword [byte esp+010h], ebp
        jmp near .136
.123:
        mov ebx, dword [byte esp+020h]
        cmp ebx, 40000h
        jne short .124
        lea ebp, [dword eax-06FFFFB64h]
        xor edi, edi
        mov dword [byte esp+010h], ebp
        mov dword [byte esp+020h], edi
        jmp near .136
.124:
        cmp ebx, 20000h
        jne short .125
        lea esi, [dword eax-06FFFFB6Fh]
        xor ebx, ebx
        mov dword [byte esp+010h], esi
        mov dword [byte esp+020h], ebx
        jmp near .136
.125:
        cmp ebx, 10000h
        jne near .135
        mov edx, dword [byte esp+010h]
        xor eax, eax
        sub edx, 6FFFFB7Fh
        mov dword [byte esp+020h], eax
        mov dword [byte esp+010h], edx
        jmp near .136
.126:
        cmp eax, 70000011h
        jge near .132
        cmp eax, 7000000Ah
        jne short .129
        mov edi, dword [byte esp+020h]
        cmp edi, 40000h
        jne short .127
        xor edx, edx
        mov eax, 4A6h
        mov dword [byte esp+020h], edx
        mov dword [byte esp+010h], eax
        jmp near .136
.127:
        cmp edi, 20000h
        jne short .128
        xor ebp, ebp
        mov edi, 49Bh
        mov dword [byte esp+020h], ebp
        mov dword [byte esp+010h], edi
        jmp near .136
.128:
        cmp edi, 10000h
        jne near .135
        xor esi, esi
        mov ebx, 48Bh
        mov dword [byte esp+020h], esi
        mov dword [byte esp+010h], ebx
        jmp near .136
.129:
        cmp eax, 7000000Bh
        jne short .131
        mov esi, dword [byte esp+020h]
        cmp esi, 20000h
        jne short .130
        xor esi, esi
        mov ebx, 49Ch
        mov dword [byte esp+020h], esi
        mov dword [byte esp+010h], ebx
        jmp near .136
.130:
        cmp esi, 10000h
        jne near .135
        xor edx, edx
        mov eax, 48Ch
        mov dword [byte esp+020h], edx
        mov dword [byte esp+010h], eax
        jmp near .136
.131:
        cmp dword [byte esp+020h], 10000h
        jne near .135
        lea ebx, [dword eax-06FFFFB7Fh]
        xor edx, edx
        mov dword [byte esp+010h], ebx
        mov dword [byte esp+020h], edx
        jmp near .136
.132:
        jne short .134
        mov ebx, dword [byte esp+020h]
        cmp ebx, 0C0000h
        jne short .133
        mov ebx, 1
        mov edx, 4B2h
        mov dword [byte esp+020h], ebx
        mov dword [byte esp+010h], edx
        jmp short .136
.133:
        cmp ebx, 40000h
        jne short .135
        xor eax, eax
        mov ebp, 4B1h
        mov dword [byte esp+020h], eax
        mov dword [byte esp+010h], ebp
        jmp short .136
.134:
        cmp eax, 70000012h
        jne short .135
        cmp dword [byte esp+020h], 70000000h
        jne short .135
        xor edx, edx
        mov eax, 4B3h
        mov dword [byte esp+020h], edx
        mov dword [byte esp+010h], eax
        jmp short .136
.135:
        mov dword [byte esp+010h], 0FFFFFFFFh
.136:
        cmp dword [byte esp+04h], byte 2
        jne near .152
        mov esi, dword [byte esp+01Ch]
        cmp esi, 70000009h
        jg near .141
        test byte [byte esp+026h], 8
        je short .138
        cmp esi, 70000001h
        jne short .137
        cmp dword [byte esp+024h], 80000h
        jne short .137
        xor edi, edi
        mov esi, 4B4h
        mov dword [byte esp+024h], edi
        mov dword [byte esp+01Ch], esi
        jmp near .151
.137:
        cmp dword [byte esp+024h], 0C0000h
        jne near .150
        mov ebx, dword [byte esp+01Ch]
        mov edx, 1
        sub ebx, 6FFFFB5Ah
        mov dword [byte esp+024h], edx
        mov dword [byte esp+01Ch], ebx
        jmp near .151
.138:
        mov ebp, dword [byte esp+024h]
        cmp ebp, 40000h
        jne short .139
        lea ebx, [dword esi-06FFFFB64h]
        xor edx, edx
        mov dword [byte esp+01Ch], ebx
        mov dword [byte esp+024h], edx
        jmp near .151
.139:
        cmp ebp, 20000h
        jne short .140
        lea eax, [dword esi-06FFFFB6Fh]
        xor ebp, ebp
        mov dword [byte esp+01Ch], eax
        mov dword [byte esp+024h], ebp
        jmp near .151
.140:
        cmp ebp, 10000h
        jne near .150
        mov edi, dword [byte esp+01Ch]
        xor esi, esi
        sub edi, 6FFFFB7Fh
        mov dword [byte esp+024h], esi
        mov dword [byte esp+01Ch], edi
        jmp near .151
.141:
        cmp esi, 70000011h
        jge near .147
        cmp esi, 7000000Ah
        jne short .144
        mov edx, dword [byte esp+024h]
        cmp edx, 40000h
        jne short .142
        xor edi, edi
        mov esi, 4A6h
        mov dword [byte esp+024h], edi
        mov dword [byte esp+01Ch], esi
        jmp near .151
.142:
        cmp edx, 20000h
        jne short .143
        xor ebx, ebx
        mov edx, 49Bh
        mov dword [byte esp+024h], ebx
        mov dword [byte esp+01Ch], edx
        jmp near .151
.143:
        cmp edx, 10000h
        jne near .150
        xor eax, eax
        mov ebp, 48Bh
        mov dword [byte esp+024h], eax
        mov dword [byte esp+01Ch], ebp
        jmp near .151
.144:
        cmp esi, 7000000Bh
        jne short .146
        mov eax, dword [byte esp+024h]
        cmp eax, 20000h
        jne short .145
        xor eax, eax
        mov ebp, 49Ch
        mov dword [byte esp+024h], eax
        mov dword [byte esp+01Ch], ebp
        jmp near .151
.145:
        cmp eax, 10000h
        jne near .150
        xor edi, edi
        mov esi, 48Ch
        mov dword [byte esp+024h], edi
        mov dword [byte esp+01Ch], esi
        jmp near .151
.146:
        cmp dword [byte esp+024h], 10000h
        jne near .150
        lea ebp, [dword esi-06FFFFB7Fh]
        xor edi, edi
        mov dword [byte esp+01Ch], ebp
        mov dword [byte esp+024h], edi
        jmp near .151
.147:
        jne short .149
        mov ebp, dword [byte esp+024h]
        cmp ebp, 0C0000h
        jne short .148
        mov ebp, 1
        mov edi, 4B2h
        mov dword [byte esp+024h], ebp
        mov dword [byte esp+01Ch], edi
        jmp short .151
.148:
        cmp ebp, 40000h
        jne short .150
        xor esi, esi
        mov ebx, 4B1h
        mov dword [byte esp+024h], esi
        mov dword [byte esp+01Ch], ebx
        jmp short .151
.149:
        cmp esi, 70000012h
        jne short .150
        cmp dword [byte esp+024h], 70000000h
        jne short .150
        xor edi, edi
        mov esi, 4B3h
        mov dword [byte esp+024h], edi
        mov dword [byte esp+01Ch], esi
        jmp short .151
.150:
        mov dword [byte esp+01Ch], 0FFFFFFFFh
.151:
        cmp dword [byte esp+01Ch], byte 0
        jge short .152
        mov dword [byte esp+04h], 1
.152:
        cmp dword [byte esp+010h], byte 0
        jle near PaEvent_14CD
        mov edx, dword [esp]
        mov eax, 2
        add edx, byte 23h
        call SayPaClip
        cmp dword [byte esp+04h], byte 1
        jne short .153
        mov edx, 69h
        jmp short .154
.153:
        mov edx, 6Ah
.154:
        mov eax, 2
        call SayPaClip
        mov edx, dword [byte esp+08h]
        mov eax, 2
        add edx, byte 6Ah
        call SayPaClip
        cmp dword [ecx], byte 0
        jne short .155
        mov eax, dword [GameSettings]
        and eax, byte 0Ch
        cmp eax, byte 8
        je short .155
        mov edx, dword [byte esp+0Ch]
        mov eax, 2
        add edx, 0CEh
        call SayPaClip
.155:
        mov edx, dword [byte esp+010h]
        mov eax, 2
        call SayPaClip
        cmp dword [byte esp+020h], byte 0
        je short .156
        mov edx, 4B0h
        mov eax, 2
        call SayPaClip
.156:
        mov ebp, dword [byte esp+04h]
        cmp ebp, byte 2
        jne near PaEvent_14CD
        mov edx, 480h
        mov eax, ebp
        call SayPaClip
        mov edx, dword [byte esp+014h]
        mov eax, ebp
        add edx, byte 6Ah
        call SayPaClip
        mov eax, dword [byte esp+02Ch]
        cmp dword [eax], byte 0
        jne short .157
        mov eax, dword [GameSettings]
        and eax, byte 0Ch
        cmp eax, byte 8
        je short .157
        mov edx, dword [byte esp+018h]
        mov eax, ebp
        add edx, 0CEh
        call SayPaClip
.157:
        mov edx, dword [byte esp+01Ch]
        mov eax, 2
        call SayPaClip
        cmp dword [byte esp+024h], byte 0
        je short PaEvent_14CD
        mov edx, 4B0h
        mov eax, 2
        call SayPaClip
        add esp, byte 40h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
.158:
        cmp dword [SoundDriverId], byte 2
        jne short PaEvent_14CD
        mov eax, dword [byte eax-04h]
        mov dword [esp], eax
        test eax, eax
        jl short PaEvent_14CD
        cmp eax, byte 4
        jge short .159
        mov edx, eax
        jmp short .160
.159:
        mov edx, 3
.160:
        mov eax, 1
.161:
        call SayPaClip
PaEvent_14CD:
        add esp, byte 40h
        pop ebp
        pop edi
        pop esi
        pop edx
        pop ecx
        pop ebx
        ret
