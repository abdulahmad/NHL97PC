# xdata.py OLD NEW: align data labels by content (bytes / dd symbols) in data files, in file order; votes
import re,glob,sys,collections,difflib,hashlib
GEN=re.compile(r'^(unk|dword|word|byte|off|qword|asc|stru|flt|dbl|tbyte)_[0-9A-F]{4,}$')
def labs(repo):
    out=[]
    for f in sorted(glob.glob(repo+'/src/data/**/*.asm',recursive=True)):
        cur=None;body=[]
        def fl():
            if cur: out.append((cur,hashlib.md5(' '.join(body).encode()).hexdigest(),len(body)))
        for l in open(f,encoding='latin1'):
            m=re.match(r'^([A-Za-z_][\w$?@]*):',l)
            if m: fl(); cur=m.group(1); body=[]; continue
            if l.startswith(('global','extern','section','bits','%')) or l.lstrip().startswith(';'): continue
            c=l.split(';')[0].strip()
            if not c: continue
            # symbols in dd -> S (names differ)
            c=re.sub(r'\b[A-Za-z_][\w$?@.]*\b',lambda m: m.group(0) if m.group(0) in('db','dw','dd','dq','dt','resb','resw','resd','resq','times') else 'S',c)
            body.append(c)
        fl()
    return out
a=labs(sys.argv[1]); b=labs(sys.argv[2])
def refs(repo):
    R=collections.defaultdict(set)
    for f in glob.glob(repo+'/src/**/*.asm',recursive=True):
        if '/data/' in f: continue
        cur=None
        for l in open(f,encoding='latin1'):
            m=re.match(r'^([A-Za-z_][\w$?@]*):',l)
            if m:
                if not re.search(r'_[0-9A-F]+$',m.group(1)): cur=m.group(1)
                continue
            c=l.split(';')[0]
            if cur and c.strip() and not c.startswith(('global','extern')):
                for t in re.findall(r'\b[A-Za-z_][\w$?@]*\b',c): R[t].add(cur)
    return R
ra=refs(sys.argv[1]); rb=refs(sys.argv[2])
sa=[x[1] for x in a]; sb=[y[1] for y in b]
sm=difflib.SequenceMatcher(None,sa,sb,autojunk=False)
ca=collections.Counter(sa); cb=collections.Counter(sb)
n=0
for tag,i1,i2,j1,j2 in sm.get_opcodes():
    if tag!='equal' or i2-i1<3: continue
    for d in range(i2-i1):
        x=a[i1+d]; y=b[j1+d]
        if not (ca[x[1]]==1 and cb[y[1]]==1) and not (ra.get(x[0],set()) & rb.get(y[0],set())): continue
        if GEN.match(x[0]) and not GEN.match(y[0]) and x[0]!=y[0]:
            print('%s\t%s\t1\t1\trun%d'%(x[0],y[0],i2-i1)); n+=1
print(n,file=sys.stderr)
