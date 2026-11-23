import pickle,bisect,difflib
exec(open(__import__('os').path.join(__import__('os').path.dirname(__import__('os').path.abspath(__file__)), 'align2.py')).read().split('results={}')[0])
R=pickle.load(open('align.pkl','rb'))
for lo in R:
    out=R[lo]; new=[]
    i=0
    while i<len(out):
        if out[i][3]: new.append(out[i]); i+=1; continue
        j=i
        while j<len(out) and not out[j][3]: j+=1
        dprev=new[-1][2] if new else 0
        dnext=out[j][2] if j<len(out) else dprev
        for k in range(i,j):
            a,b=out[k][:2]
            m=masked(G0,a,b,a); hit=None
            for dd in (dprev,dnext):
                if m==masked(G1,a+dd,b+dd,a): hit=dd; break
            new.append((a,b,hit,hit is not None))
        i=j
    R[lo]=new
pickle.dump(R,open('align.pkl','wb'))
for lo in R:
    out=R[lo]; runs=[];cur=None
    for a,b,d,ok in out:
        if not ok:
            if cur and cur[1]==a: cur[1]=b; cur[2]+=1
            else: cur=[a,b,1]; runs.append(cur)
        else: cur=None
    print('obj %X runs %d bytes %d'%(lo,len(runs),sum(r[1]-r[0] for r in runs)))
    if lo==0x160000:
        for r in runs: print('  %X-%X %5d %3d %s'%(r[0],r[1],r[1]-r[0],r[2],syms[r[0]][0]))
