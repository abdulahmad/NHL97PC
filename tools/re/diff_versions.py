# Routine-level diff of two HOCKEY.EXE builds (1.0 vs patch 1.1): fixup bytes masked, branch targets ignored.
# usage: python3 -I tools/re/diff_versions.py build/HOCKEY.EXE <1.1 HOCKEY.EXE>   (needs pip iced-x86; run from repo root)
import struct,sys,pickle,re
sys.path.insert(0,'.')
from le_obj import load
from iced_x86 import Decoder, Formatter, FormatterSyntax, FlowControl
def fixmask(path):
    d=open(path,'rb').read()
    objs,eip,h=load(path)
    npages=struct.unpack_from('<I',d,h+0x14)[0]; pgsz=struct.unpack_from('<I',d,h+0x28)[0]
    fpt=h+struct.unpack_from('<I',d,h+0x68)[0]; frt=h+struct.unpack_from('<I',d,h+0x6C)[0]
    offs=struct.unpack_from('<%dI'%(npages+1),d,fpt)
    objtab=h+struct.unpack_from('<I',d,h+0x40)[0]
    vs,base,fl,pi,pc,_=struct.unpack_from('<6I',d,objtab)
    img=bytes(objs[0][2]); mask=bytearray(len(img))
    for p in range(pi-1,pi-1+pc):
        pos,end=frt+offs[p],frt+offs[p+1]
        while pos<end:
            s,f=d[pos],d[pos+1]
            so=struct.unpack_from('<h',d,pos+2)[0]
            pos+= 9 if f&0x10 else 7
            a=(p-(pi-1))*pgsz+so
            for k in range(4 if s==7 else 6):
                if 0<=a+k<len(img): mask[a+k]=1
    zimg=bytes(0 if mask[i] else img[i] for i in range(len(img)))
    return base,zimg,mask
def norm(img,mask,base,s,e):
    dec=Decoder(32,img[s:e],ip=base+s)
    toks=[]
    for ins in dec:
        o=ins.ip-base; b=bytearray(img[o:o+ins.len])
        for k in range(ins.len):
            if mask[o+k]: b[k]=0
        if ins.flow_control in (FlowControl.CALL,FlowControl.UNCONDITIONAL_BRANCH,FlowControl.CONDITIONAL_BRANCH) and ins.is_call_near or ins.is_jmp_near or ins.is_jcc_near or ins.is_jmp_short or ins.is_jcc_short or ins.is_loop or ins.is_jcx_short:
            toks.append(('%s'%ins.mnemonic,))
        else: toks.append(bytes(b))
    return toks
b0,i0,m0=fixmask(sys.argv[1]); b1,i1,m1=fixmask(sys.argv[2])
F=pickle.load(open('tools/funcs.pkl','rb'))['funcs']
F=[f for f in F if f['kind']=='proc' and f['end']>f['start']]
delta=0; changed=[]
def wildsearch(s,e):
    n=min(e-s,32)
    pat=b''.join(b'.' if m0[s+k] else re.escape(bytes([i0[s+k]])) for k in range(n))
    return [m.start()-s for m in re.finditer(pat,i1,re.S)]
for fn in F:
    s=fn['start']-b0; e=fn['end']-b0
    t0=norm(i0,m0,b0,s,e)
    ok=False
    for dl in [delta]+[x for x in wildsearch(s,e) if x!=delta][:20]:
        if s+dl<0 or e+dl>len(i1): continue
        if norm(i1,m1,b1,s+dl,e+dl)==t0: delta=dl; ok=True; break
    if not ok: changed.append((fn['name'],hex(fn['start']),e-s,hex(delta)))
print(len(changed),'of',len(F))
for c in changed: print(*c)
