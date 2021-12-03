with open('day3.txt') as f:
    l = list(map(str.strip, f.readlines()))
oxy = l[:]
i = 0
while len(oxy) != 1:
    oxy = list(filter(lambda x: x[i] == ('1' if (sum([int(b[i])
                                                      for b in oxy]) >= len(oxy)/2) else '0'), oxy))
    i += 1
co2 = l[:]
i = 0
while len(co2) != 1:
    co2 = list(filter(lambda x: x[i] == ('0' if (sum([int(b[i])
                                                      for b in co2]) >= len(co2)/2) else '1'), co2))
    i += 1
print(int(oxy[0], 2)*int(co2[0], 2))
