with open('day3.txt') as f:
    l = f.readlines()
gamma, epsilon = '', ''
for a in range(len(l[0])-1):
    if sum([int(b[a]) for b in l]) > len(l)//2:
        gamma += "1"
        epsilon += "0"
    else:
        gamma += "0"
        epsilon += "1"
print(int(gamma, 2)*int(epsilon, 2))
