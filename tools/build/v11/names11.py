"""Names and comments for the routines and variables that only NHL 97 PC patch 1.1 has.

RENAME maps the generator's placeholder (NEW_<1.1 address> for code, NEWD_<1.1 address> for data) to the
name used in src/. None means the label only marks alignment padding and is left out.
DATA_COMMENT is the comment on a new data label; HEADER the description lines of a new routine's header."""

RENAME = {
    'NEW_1589B': None,                       # nop padding before EstimateCpuSpeed
    'NEW_76581': None,                       # lea padding before AllocAnimNode
    'NEW_1589B_1': 'EstimateCpuSpeed',
    'NEWD_1600D8': 'F64_33',
    'NEWD_1600E0': 'F64_1p76206eneg06',
    'NEWD_1600E8': 'F64_90',
    'NEWD_1600F0': 'F64_4p01469eneg07',
    'NEWD_1600F8': 'F64_150',
    'NEWD_160100': 'F64_2p39167eneg07',
    'NEWD_160108': 'F64_200_EstimateCpuSpeed',
    'NEWD_160110': 'F64_1p38006eneg07',
    'NEWD_160118': 'F32_1000000',
    'NEWD_160E08': 'str_KTSF_InitSpeechBanks',
    'NEWD_16302B': 'F64_100_UpdateScoreClockData',
    'NEWD_163033': 'F32_11931',
    'NEWD_1632E0': 'F32_4_PuckOffPost2',
    'NEWD_163D8C': 'F64_48_GoalieMoves2',
    'NEWD_167588': 'str_PeerVersionOlder',
    'NEWD_167658': 'str_PeerVersionOlderSwedish',
    'NEWD_167728': 'str_PeerVersionOlderGerman',
    'NEWD_16DDD4': 'LinkPeerMinSequence',
    'NEWD_16DDDC': 'LinkBlockAcked',
    'NEWD_1BFB2C': 'GoalieMoveDist',
    'NEWD_1BFBC8': 'AnimNodeFreeCount',
    'NEWD_1BFBCC': 'AnimNodeFreeHead',
    'NEWD_1BFBD0': 'AnimNodeFreeTail',
    'AudioDriverVersion': 'CpuSpeedCount',   # 1.0 name was wrong: InitVideoModeList stores a CPU speed measure
}

DATA_COMMENT = {
    'F64_33': '; double constant 33 (MHz); used by EstimateCpuSpeed',
    'F64_1p76206eneg06': '; double constant 1.76206e-06 (loop scale at 33 MHz); used by EstimateCpuSpeed',
    'F64_90': '; double constant 90 (MHz); used by EstimateCpuSpeed',
    'F64_4p01469eneg07': '; double constant 4.01469e-07 (loop scale at 90 MHz); used by EstimateCpuSpeed',
    'F64_150': '; double constant 150 (MHz); used by EstimateCpuSpeed',
    'F64_2p39167eneg07': '; double constant 2.39167e-07 (loop scale at 150 MHz); used by EstimateCpuSpeed',
    'F64_200_EstimateCpuSpeed': '; double constant 200 (MHz); used by EstimateCpuSpeed',
    'F64_1p38006eneg07': '; double constant 1.38006e-07 (loop scale at 200 MHz); used by EstimateCpuSpeed',
    'F32_1000000': '; float constant 1000000 (MHz to Hz); used by EstimateCpuSpeed',
    'str_KTSF_InitSpeechBanks': '; string "KTSF"; used by InitSpeechBanks',
    'F64_100_UpdateScoreClockData': '; double constant 100; used by UpdateScoreClockData',
    'F32_11931': '; float constant 11931 (PIT counts per 10 ms); used by UpdateScoreClockData',
    'F32_4_PuckOffPost2': '; float constant 4 (a second copy, new in 1.1); used by PuckOffPost',
    'F64_48_GoalieMoves2': '; double constant 48 (a second copy, new in 1.1); used by GoalieMoves',
    'str_PeerVersionOlder': '; message: the connected computer runs an older version; used by StartNetworkLink',
    'str_PeerVersionOlderSwedish': '; Swedish older-version message; used by StartNetworkLink',
    'str_PeerVersionOlderGerman': '; German older-version message; used by StartNetworkLink',
    'LinkPeerMinSequence': '; lowest LinkRemoteSequence seen, starts at 1; above 0 means the peer is older',
    'LinkBlockAcked': '; cleared before LinkHandshake, set when the peer acknowledges; used by LinkReceiveBlock',
    'GoalieMoveDist': '; per-move distance table, the GoalieMoveTable of 1.0 moved 4 bytes; used by GoalieMoves',
    'AnimNodeFreeCount': '; free animation nodes; used by AllocAnimNode, InitAnimNodePool',
    'AnimNodeFreeHead': '; head of the free animation node list; used by AllocAnimNode, AllocAnimStateBlocks',
    'AnimNodeFreeTail': '; tail of the free animation node list; nodes are freed onto it',
}

HEADER = {
    'EstimateCpuSpeed': [
        'Estimates the CPU clock in Hz without rdtsc: counts a busy loop over 20 timer ticks five times,',
        'keeps the second best count and scales it by the loop time of the detected CPU class',
    ],
}
