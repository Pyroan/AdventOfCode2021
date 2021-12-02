with open('day1.txt') as f:
    depths = list(map(int, f.readlines()))
count = 0
for i in range(1, len(depths)):
    if depths[i] > depths[i-1]:
        count += 1
print(count)
