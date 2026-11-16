import struct,sys
def load(path):
    d=open(path,'rb').read()
    le=struct.unpack_from('<I',d,0x3C)[0]
    if d[le:le+2]!=b'LE':
        le=d.find(b'LE\0\0')
    h=le
    pgsz=struct.unpack_from('<I',d,h+0x28)[0]; lastpg=struct.unpack_from('<I',d,h+0x2C)[0]
    objtab=h+struct.unpack_from('<I',d,h+0x40)[0]; nobj=struct.unpack_from('<I',d,h+0x44)[0]
    pmap=h+struct.unpack_from('<I',d,h+0x48)[0]; npages=struct.unpack_from('<I',d,h+0x14)[0]
    dpo=struct.unpack_from('<I',d,h+0x80)[0]
    eip=struct.unpack_from('<I',d,h+0x1C)[0]
    objs=[]
    for i in range(nobj):
        vs,base,fl,pi,pc,_=struct.unpack_from('<6I',d,objtab+24*i)
        img=bytearray(vs)
        for k in range(pc):
            pn=pi+k
            off=dpo+(pn-1)*pgsz
            n=lastpg if pn==npages else pgsz
            img[k*pgsz:k*pgsz+n]=d[off:off+n][:max(0,vs-k*pgsz)]
        objs.append((base,vs,bytes(img)))
    return objs,eip,h
if __name__=='__main__':
    o,e,h=load(sys.argv[1]); print(hex(h),hex(e),[(hex(b),hex(v)) for b,v,_ in o])
