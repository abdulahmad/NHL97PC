import pickle,bisect,struct
exec(open(__import__('os').path.join(__import__('os').path.dirname(__import__('os').path.abspath(__file__)), 'align2.py')).read().split('results={}')[0])
R=pickle.load(open('align.pkl','rb'))
allc=sorted(c for lo in R for c in R[lo]); starts=[c[0] for c in allc]
fix1={s:(t,to,st) for c,s,t,to,st in g1}
obase={1:0x10000,2:0x140000,3:0x150000,4:0x160000}
def mp(x):
    i=bisect.bisect_right(starts,x)-1
    if i<0: return None
    a,b,d,ok=allc[i]
    if x==b and i+1<len(allc): a,b,d,ok=allc[i+1]
    if ok: return x+d
    return None
bad=0;unk=0;n=0
for P,sz,k,T in fields:
    i=bisect.bisect_right(starts,P)-1; a,b,d,ok=allc[i]
    if not ok: continue
    n+=1; P1=P+d; want=mp(T)
    if k=='a':
        f=fix1.get(P1)
        got=obase[f[0]]+f[1] if f else None
    else:
        v=G1(P1,sz); got=P1+sz+(struct.unpack('<i',v)[0] if sz==4 else struct.unpack('<b',v)[0])
    if want is None: unk+=1; continue
    if got!=want:
        bad+=1
        if bad<15: print('bad %s P=%X P1=%X T=%X want %X got %s'%(k,P,P1,T,want,hex(got) if got else got))
print('fields checked',n,'bad',bad,'target in changed region',unk)
