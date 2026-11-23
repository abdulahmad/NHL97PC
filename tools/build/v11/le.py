import os as _os, sys as _sys
REPO = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import struct,sys
sys.path.insert(0,_os.path.join(REPO, 'tools/build'))
import rebuild_exe as R
def load(p):
    d=open(p,'rb').read()
    le=struct.unpack_from('<I',d,0x3c)[0]
    hdr={}
    for o,t,k in R.LE_HDR:
        hdr[k]=struct.unpack_from('<'+t,d,le+o)[0]
    objs=[]
    for n in range(hdr['num_objects']):
        vs,base,flags,pmi,pmn,res=struct.unpack_from('<6I',d,le+hdr['object_table_off']+24*n)
        objs.append(dict(virtual_size=vs,base=base,flags=flags,page_map_index=pmi,page_count=pmn))
    np_=hdr['num_pages']
    offs=struct.unpack_from('<%dI'%(np_+1),d,le+hdr['fixup_page_table_off'])
    frt=le+hdr['fixup_record_table_off']
    pages=R.parse_fixup_records(d,frt,offs,np_)
    ins=[R.unblock(r) for r in pages]
    glob=R.fixups_to_global(objs,ins)
    data_abs=hdr['data_pages_off']
    img={}
    mem=bytearray()
    for o in objs:
        fs=data_abs+(o['page_map_index']-1)*4096
        b=d[fs:fs+o['page_count']*4096]
        img[o['base']]=b
    return d,hdr,objs,glob,img
if __name__=='__main__':
    for p in sys.argv[1:]:
        d,h,objs,g,img=load(p)
        print(p,len(d),'eip obj',h.get('eip_object'),hex(h.get('eip',0)),'pages',h['num_pages'],'fixups',len(g))
        for o in objs: print('  base %X vsize %X pages %d flags %X'%(o['base'],o['virtual_size'],o['page_count'],o['flags']))
