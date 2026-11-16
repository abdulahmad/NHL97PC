# xmatch.py OLD NEW : pairs code blocks of two PC disassemblies with the same normalized instructions,
# then votes OLD generic labels -> NEW names from the block starts and aligned operands. Prints TSV.
import re,glob,sys,collections,hashlib,difflib
MASK='--mask' in sys.argv
sys.argv=[x for x in sys.argv if x!='--mask']
REG=set('eax ebx ecx edx esi edi ebp esp ax bx cx dx si di bp sp al bl cl dl ah bh ch dh cs ds es fs gs ss st st0 st1 st2 st3 st4 st5 st6 st7'.split())
KW=set('byte word dword qword tword tbyte near short far nosplit strict rel abs ptr'.split())
GEN=re.compile(r'^(sub|loc|unk|dword|word|byte|off|jpt|qword|stru|asc|flt|dbl|tbyte)_[0-9A-F]{4,}(_\w+)?$')
LAB=re.compile(r'^([A-Za-z_][\w$?@]*):')
def blocks(repo):
    out=[]
    for f in sorted(glob.glob(repo+'/src/**/*.asm',recursive=True)):
        if '/data/' in f: continue
        cur=None;seq=[];syms=[]
        def flush():
            if cur and len(seq)>=5: out.append((cur,tuple(seq),syms[:],f))
        for l in open(f,encoding='latin1'):
            m=LAB.match(l)
            if m:
                flush(); cur=m.group(1); seq=[]; syms=[]; continue
            if l.startswith(('global','extern','section','bits','%')) or not l.strip() or l.lstrip().startswith(';'): continue
            code=l.split(';')[0].strip()
            if not code: continue
            # fold symbol+const into one token so merged arrays still match
            code=re.sub(r'\b([A-Za-z_@$?][\w@$?]*)\s*([+-])\s*(0x[0-9A-Fa-f]+|[0-9][0-9A-Fa-f]*h?)\b',lambda m: m.group(1)+'#'+('p' if m.group(2)=='+' else 'm')+m.group(3) if m.group(1).lower() not in REG else m.group(0),code)
            toks=re.findall(r'[A-Za-z_.@$?][\w.@$?#]*|0x[0-9A-Fa-f]+|[0-9][0-9A-Fa-f]*h?|\S',code)
            n=[]
            for t in toks:
                tl=t.lower()
                if re.match(r'^[A-Za-z_@$?][\w@$?#]*$',t) and tl not in REG and tl not in KW and t!=toks[0]:
                    n.append('S'); syms.append(t)
                elif t.startswith('.'): n.append('L')
                elif MASK and re.match(r'^(0x)?[0-9][0-9A-Fa-f]*h?$',t): n.append('N')
                else: n.append(t)
            seq.append(' '.join(n))
        flush()
    return out
a=blocks(sys.argv[1]); b=blocks(sys.argv[2])
def h(s): return hashlib.md5('\n'.join(s).encode()).hexdigest()
ha=collections.defaultdict(list); hb=collections.defaultdict(list)
for x in a: ha[h(x[1])].append(x)
for x in b: hb[h(x[1])].append(x)
votes=collections.defaultdict(collections.Counter)
pairs=0
for k,xs in ha.items():
    ys=hb.get(k)
    if not ys or len(xs)!=1 or len(ys)!=1: continue
    x,y=xs[0],ys[0]; pairs+=1
    votes[x[0]][y[0]]+=3
    for s,t in zip(x[2],y[2]):
        if s!=t: votes[s][t]+=1
bn={}
for y in b: bn.setdefault(y[0],y)
for x in a:
    y=bn.get(x[0])
    if not y or h(x[1])==h(y[1]): continue
    sm=difflib.SequenceMatcher(None,x[1],y[1],autojunk=False)
    if sm.ratio()<0.6: continue
    # map symbol positions per instruction
    def per(blk):
        res=[];i=0
        for ins in blk[1]:
            k=ins.split().count('S'); res.append(blk[2][i:i+k]); i+=k
        return res
    px=per(x);py=per(y)
    for tag,i1,i2,j1,j2 in sm.get_opcodes():
        if tag!='equal': continue
        for d in range(i2-i1):
            for s1,t1 in zip(px[i1+d],py[j1+d]):
                if s1!=t1: votes[s1][t1]+=1
    pairs+=1
print('#pairs',pairs,file=sys.stderr)
for s,c in sorted(votes.items()):
    if not GEN.match(s): continue
    t,n=c.most_common(1)[0]
    tot=sum(c.values())
    if GEN.match(t) or t.startswith('.'): continue
    print('%s\t%s\t%d\t%d'%(s,t,n,tot))
