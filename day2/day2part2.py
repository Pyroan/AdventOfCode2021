with open('day2.txt') as f:
    l = [l.split(' ')for l in f]
x, y, aim = 0, 0, 0
for d in l:
    if d[0] == 'forward':
        x += int(d[1])
        y += aim * int(d[1])
    elif d[0] == 'down':
        aim += int(d[1])
    elif d[0] == 'up':
        aim -= int(d[1])
print(x*y)
