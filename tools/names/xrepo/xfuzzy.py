# xfuzzy.py OLD NEW: for generic-named OLD blocks without an exact twin, find the most similar NEW block (difflib on
# masked instructions); prints OLD NEW ratio second-best when ratio>=0.85 and clearly ahead of the second best.
import sys,collections,hashlib,difflib,re
sys.argv=[sys.argv[0],'--mask']+sys.argv[1:]
exec(open(__import__('os').path.join(__import__('os').path.dirname(__file__),'xmatch.py')).read().split("a=blocks(sys.argv[1])")[0])
a=blocks(sys.argv[1]); b=blocks(sys.argv[2])
def h(s): return hashlib.md5('\n'.join(s).encode()).hexdigest()
hb=collections.Counter(h(x[1]) for x in b)
idx=collections.defaultdict(set)
def grams(seq):
    ops=[s.split()[0] for s in seq]
    return set(tuple(ops[i:i+4]) for i in range(len(ops)-3))
gb=[grams(y[1]) for y in b]
for j,g in enumerate(gb):
    for t in g: idx[t].add(j)
for x in a:
    if not GEN.match(x[0]) or hb[h(x[1])]: continue
    if len(x[1])<8: continue
    g=grams(x[1]); cnt=collections.Counter()
    for t in g:
        if len(idx[t])<200:
            for j in idx[t]: cnt[j]+=1
    best=[]
    for j,_ in cnt.most_common(15):
        y=b[j]
        r=difflib.SequenceMatcher(None,x[1],y[1],autojunk=False).ratio()
        best.append((r,y[0],j))
    best.sort(reverse=True)
    if best and best[0][0]>=0.85 and (len(best)<2 or best[0][0]-best[1][0]>=0.05):
        print('%s\t%s\t%.2f\t%.2f\t%s'%(x[0],best[0][1],best[0][0],best[1][0] if len(best)>1 else 0,x[3].split('/src/')[1]))
