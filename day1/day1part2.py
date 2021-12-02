with open('day1.txt') as f:
    depths = list(map(int, f.readlines()))
count = 0
for i in range(1, len(depths)-2):
    if sum(depths[i:i+3]) > sum(depths[i-1:i+2]):
        count += 1
print(count)
