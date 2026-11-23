import pickle,bisect,struct,sys
from le import load
I=pickle.load(open('v10info.pkl','rb'))
fields=I['fields']; syms=I['syms']
d0,h0,o0,g0,img0=load('hockey10.exe'); d1,h1,o1,g1,img1=load('hockey11.exe')
def mk(img,objs):
    def get(a,n):
        for o in objs:
            if o['base']<=a and a+n<=o['base']+len(img[o['base']]): return img[o['base']][a-o['base']:a-o['base']+n]
            if o['base']<=a<o['base']+o['virtual_size']:
                b=img[o['base']][a-o['base']:a-o['base']+n]; return b+bytes(n-len(b))
        return None
    return get
G0=mk(img0,o0); G1=mk(img1,o1)
fpos=[f[0] for f in fields]
def masked(get,a,b,base_a):
    # mask 1.0 fields of [base_a, base_a+b-a) onto bytes from get(a..b)
    bb=bytearray(get(a,b-a))
    i=bisect.bisect_left(fpos,base_a-3)
    while i<len(fields) and fields[i][0]<base_a+(b-a):
        P,n=fields[i][0],fields[i][1]
        for k in range(n):
            j=P-base_a+k
            if 0<=j<len(bb): bb[j]=0
        i+=1
    return bytes(bb)
results={}
for (lo,hi0,hi1) in [(0x10000,0x10000+0x12C79B,0x10000+0x12D13B),(0x140000,0x14003C,0x14003C),(0x150000,0x150018,0x150018),(0x160000,0x160000+0x86C00,0x160000+0x86F30)]:
    bnd=sorted(a for a in syms if lo<=a<hi0 and any(not n.split('.')[-1].isdigit() or '.' not in n for n in syms[a]))
    bnd=sorted(set([lo]+bnd+[hi0]))
    chunks=list(zip(bnd,bnd[1:]))
    d=0; out=[]
    i=0
    while i<len(chunks):
        a,b=chunks[i]
        if masked(G0,a,b,a)==masked(G1,a+d,b+d,a): out.append((a,b,d,True)); i+=1; continue
        # resync: find delta for chunk j>i
        found=None
        for j in range(i+1,min(i+3000,len(chunks))):
            a2,b2=chunks[j]
            if b2-a2<12: continue
            m0=masked(G0,a2,b2,a2)
            mk_=bytearray(b2-a2)
            ii=bisect.bisect_left(fpos,a2-3)
            while ii<len(fields) and fields[ii][0]<b2:
                for k in range(fields[ii][1]):
                    jj=fields[ii][0]-a2+k
                    if 0<=jj<len(mk_): mk_[jj]=1
                ii+=1
            best=(0,0); s=0
            for k in range(len(m0)+1):
                if k==len(m0) or mk_[k]:
                    if k-s>best[1]-best[0] and len(set(m0[s:k]))>3: best=(s,k)
                    s=k+1
            if best[1]-best[0]<8: continue
            pat=m0[best[0]:best[1]]
            win0=a2+d-0x6000; win=G1(win0,0xC000) if G1(win0,0xC000) else None
            if win is None: continue
            p=win.find(pat)
            while p>=0:
                nd=win0+p-best[0]-a2
                ok=masked(G0,a2,b2,a2)==masked(G1,a2+nd,b2+nd,a2)
                if ok and j+1<len(chunks):
                    a3,b3=chunks[j+1]; ok=masked(G0,a3,b3,a3)==masked(G1,a3+nd,b3+nd,a3)
                if ok: found=(j,nd); break
                p=win.find(pat,p+1)
            if found: break
        if not found: print('lost at %X'%a); break
        j,nd=found
        for k in range(i,j): out.append((chunks[k][0],chunks[k][1],None,False))
        d=nd; i=j
    results[lo]=out
    ch=[c for c in out if not c[3]]
    print('obj %X: chunks %d changed %d final delta %X'%(lo,len(out),len(ch),d))
pickle.dump(results,open('align.pkl','wb'))
