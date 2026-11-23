#!/bin/sh
# 1.0-wide renames done before the 1.1 code is put in
cd "$(dirname "$0")/../../.."
grep -rl AudioDriverVersion src | xargs sed -i 's/\bAudioDriverVersion\b/CpuSpeedCount/g'
python3 - <<'P'
p='src/data/lib/ea/ea_alloc_gfx_fix_buffer_data_01.asm'
s=open(p).read()
a=s.index('CpuSpeedCount:'); b=s.index("        db 0FFh,0FFh,0FFh,0FFh", a)
new=('%-48s%s\n' % ('CpuSpeedCount:', '; CPU speed: rdtsc cycles over 100 timer ticks')) + ' '*48 + '; (1.1: PIT count or EstimateCpuSpeed without rdtsc);\n' + ' '*48 + '; used by InitVideoModeList,\n' + ' '*48 + '; OpenAudioStream, UpdateScoreClockData\n'
open(p,'w').write(s[:a]+new+s[b:])
P
