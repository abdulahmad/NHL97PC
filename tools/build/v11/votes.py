import pickle,bisect,struct
from collections import Counter,defaultdict
exec(open(__import__('os').path.join(__import__('os').path.dirname(__import__('os').path.abspath(__file__)), 'align2.py')).read().split('results={}')[0])
R=pickle.load(open('align.pkl','rb'))
fix1={s:(t,to,st) for c,s,t,to,st in g1}
obase={1:0x10000,2:0x140000,3:0x150000,4:0x160000}
for it in range(3):
    allc=sorted(c for lo in R for c in R[lo]); starts=[c[0] for c in allc]
    votes=defaultdict(Counter)
    for P,sz,k,T in fields:
        i=bisect.bisect_right(starts,P)-1; a,b,d,ok=allc[i]
        if not ok: continue
        P1=P+d
        if k=='a':
            f=fix1.get(P1)
            if not f: continue
            got=obase[f[0]]+f[1]
        else:
            v=G1(P1,sz); got=P1+sz+(struct.unpack('<i',v)[0] if sz==4 else struct.unpack('<b',v)[0])
        j=bisect.bisect_right(starts,T)-1
        votes[allc[j][0]][got-T]+=1
    changed=0
    for lo in R:
        new=[]
        for a,b,d,ok in R[lo]:
            if a in votes:
                dd,cnt=votes[a].most_common(1)[0]
                if dd!=d:
                    okk=masked(G0,a,b,a)==masked(G1,a+dd,b+dd,a)
                    if okk or not ok:
                        changed+=1; d,ok=dd,okk
            new.append((a,b,d,ok))
        # bss/no-vote chunks between voted ones: if mapping not monotone, fix by neighbour
        R[lo]=new
    print('iter',it,'changed',changed)
pickle.dump(R,open('align.pkl','wb'))
