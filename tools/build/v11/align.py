import os as _os, sys as _sys
REPO = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys,os,struct,json,bisect,pickle
sys.path.insert(0,_os.path.join(REPO, 'tools')); sys.path.insert(0,_os.path.join(REPO, 'tools/build'))
import link_src as L
from le import load
ROOT=REPO
segs=L.read_layout()
# relocation fields and symbols of 1.0
fields=[]  # (P,size,kind,target)
syms={}    # addr -> [names]
gsym={}
loaded=[]
for sg in segs:
    d,secs,sy,rels=L.read_elf(os.path.join(ROOT,'build/obj',os.path.splitext(sg['src'])[0]+'.o'))
    si=[i for i,s in enumerate(secs) if s['name']=='s_%05X'%sg['start']][0]
    for s in sy:
        if s['shndx']==si and s['type']!=3 and s['name'] and not s['name'].startswith('s_'):
            syms.setdefault(sg['start']+s['value'],[]).append(s['name'])
            if s['bind']==1: gsym[s['name']]=sg['start']+s['value']
    loaded.append((sg,d,secs,sy,rels,si))
for sg,d,secs,sy,rels,si in loaded:
    sec=secs[si]; buf=d[sec['off']:sec['off']+sec['size']] if sec['type']!=8 else bytes(sec['size'])
    for o,symi,typ in rels.get(si,[]):
        s=sy[symi]
        S=gsym[s['name']] if s['shndx']==0 else sg['start']+s['value']
        P=sg['start']+o
        if typ==23: fields.append((P,1,'r',S+struct.unpack_from('<b',buf,o)[0]+1)); continue
        add=struct.unpack_from('<i',buf,o)[0]
        if typ in (1,9): fields.append((P,4,'a',S+add))
        elif typ==2: fields.append((P,4,'r',S+add+4))
fields.sort()
pickle.dump(dict(fields=fields,syms=syms,gsym=gsym,segs=segs),open('v10info.pkl','wb'))
print('fields',len(fields),'symbols',len(syms))
