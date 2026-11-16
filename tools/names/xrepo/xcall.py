# xcall.py OLD NEW: for routines with the same name in both, align their call/jump-target sequences; an OLD generic
# target opposite a NEW name that OLD doesn't define yet is a vote. Prints OLD NEW votes total.
import re,glob,sys,collections,difflib
GEN=re.compile(r'^(sub|loc|unk|dword|word|byte|off|jpt|qword|asc)_[0-9A-F]{4,}$')
def calls(repo):
    C={};defined=set()
    for f in glob.glob(repo+'/src/**/*.asm',recursive=True):
        cur=None
        for l in open(f,encoding='latin1'):
            m=re.match(r'^([A-Za-z_][\w$?@]*):',l)
            if m:
                defined.add(m.group(1))
                n=m.group(1)
                if not re.search(r'_[0-9A-F]+$',n) or GEN.match(n): cur=n; C.setdefault(cur,[])
                continue
            c=l.split(';')[0].strip()
            m=re.match(r'^(call)\s+(?:near |short |dword )?([A-Za-z_][\w$?@]*)$',c)
            if cur and m and not m.group(2).startswith('.'):
                t=re.sub(r'_[0-9A-F]+$','',m.group(2)) if not GEN.match(m.group(2)) else m.group(2)
                if t!=cur: C[cur].append(t)
    return C,defined
A,da=calls(sys.argv[1]); B,db=calls(sys.argv[2])
votes=collections.defaultdict(collections.Counter)
for n,xs in A.items():
    if GEN.match(n) or n not in B: continue
    ys=B[n]
    xa=['?' if GEN.match(t) else t for t in xs]
    ya=['?' if (t not in da and not GEN.match(t)) else t for t in ys]
    sm=difflib.SequenceMatcher(None,xa,ya,autojunk=False)
    for tag,i1,i2,j1,j2 in sm.get_opcodes():
        if tag!='equal': continue
        for d in range(i2-i1):
            s,t=xs[i1+d],ys[j1+d]
            if s.startswith('sub_') and not GEN.match(t): votes[s][t]+=1
for s,c in sorted(votes.items()):
    t,k=c.most_common(1)[0]; print('%s\t%s\t%d\t%d'%(s,t,k,sum(c.values())))
