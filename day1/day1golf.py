d=list(map(int,open('day1.txt')))
for x in[1,3]:print(sum([d[i+x]>d[i]for i in range(len(d)-x)]))