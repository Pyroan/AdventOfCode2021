def f(r,s,i=0,q=open('day3.txt').readlines()):
 while len(q)-1:q,i=list(filter(lambda x:int(x[i])==(s==(sum(int(b[i])for b in q)>=len(q)/2)!=r),q)),i+1
 return int(q[0],2)
print(f(1,0)*f(0,1))