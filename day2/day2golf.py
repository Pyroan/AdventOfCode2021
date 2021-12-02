d={}
for l in open('day2.txt'):d[l[0]]=d.get(l[0],0)+int(l.split()[1])
print(d['f']*(d['d']-d['u']))
