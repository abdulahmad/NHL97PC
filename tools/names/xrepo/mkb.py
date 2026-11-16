# mkb.py OLDREPO NEWREPO OUT TSV... : rename batch for OLD generic -> NEW name votes (unanimous), with NEW's descriptions
import csv,re,glob,sys
old,new,outp=sys.argv[1:4]
ev={r['name']:r for r in csv.DictReader(open(new+'/docs/name_map.csv'))}
LIN=re.compile(r'\b(9[2-7][GS]|NHLPA ?93|NHL ?9[2-7]|9[2-7] ?(PC|Genesis|SNES)|Genesis|SNES|Sega|NHL9\dPC)\b',re.I)
IDA=re.compile(r'\b(?:sub|loc|unk|dword|byte|word|off|qword|asc|jpt)_[0-9A-F]{4,}\b')
defined=set()
for f in glob.glob(old+'/src/**/*.asm',recursive=True):
    for l in open(f,encoding='latin1'):
        m=re.match(r'^([A-Za-z_][\w$?@]*):',l)
        if m: defined.add(m.group(1))
out=[];tgt=set()
for tsv in sys.argv[4:]:
    for l in open(tsv):
        p=l.rstrip('\n').split('\t')
        s,t=p[0],p[1]
        conf='medium'
        if len(p)>=4 and p[2].isdigit():
            if int(p[2])!=int(p[3]): continue
        elif len(p)>=3:
            if float(p[2])<0.9: continue
            conf='low'
        if not s.startswith(('sub_','unk_','dword_','word_','byte_','off_','jpt_','qword_','asc_')): continue
        if re.match(r'^\w+_[0-9A-F]{4,}_[0-9A-Fx]+$',s) or '#' in t or '.' in t or t in defined or t in tgt: continue
        if re.search(r'_[0-9A-F]+$',t) and t.rsplit('_',1)[0] in ev: continue
        tgt.add(t)
        r=ev.get(t); e=r['evidence'] if r else ''
        if not e or LIN.search(e) or IDA.search(e) or re.search(r'\b[0-9A-F]{5,}h?\b',e): e='same code as in the next game'
        src={'WATCOM':'WATCOM','94G':'94G','93G':'93G','95PC':'95PC'}.get(r['source'] if r else '','new')
        out.append('%s %s {confidence=%s,source=%s} %s'%(s,t,conf,src,e))
open(outp,'w').write('\n'.join(out)+'\n'); print(len(out))
