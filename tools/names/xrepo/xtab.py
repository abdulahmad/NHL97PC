# xtab.py OLD NEW: tables of dd symbols with the same label in both repos; zip entries -> votes OLD generic -> NEW name
import re,glob,sys,collections
GEN=re.compile(r'^(sub|loc|unk|dword|word|byte|off|jpt|qword|stru|asc|flt|dbl|tbyte)_[0-9A-F]{4,}$')
def tabs(repo):
    T=collections.defaultdict(list)
    for f in glob.glob(repo+'/src/**/*.asm',recursive=True):
        cur=None
        for l in open(f,encoding='latin1'):
            m=re.match(r'^([A-Za-z_][\w$?@]*):',l)
            if m: cur=m.group(1); continue
            if l.startswith(('global','extern')): continue
            c=l.split(';')[0].strip()
            m=re.match(r'^dd\s+([A-Za-z_][\w$?@.]*)$',c)
            if cur and m: T[cur].append(m.group(1))
            elif cur and c.startswith(('db','dw','dd')): T[cur].append('#')
            elif c: cur=None
    return T
a=tabs(sys.argv[1]); b=tabs(sys.argv[2])
votes=collections.defaultdict(collections.Counter)
for k,xs in a.items():
    ys=b.get(k)
    if not ys or len(xs)!=len(ys): continue
    for s,t in zip(xs,ys):
        if s!=t and GEN.match(s) and t!='#' and not GEN.match(t) and '.' not in t: votes[s][t]+=1
for s,c in sorted(votes.items()):
    t,n=c.most_common(1)[0]
    print('%s\t%s\t%d\t%d'%(s,t,n,sum(c.values())))
