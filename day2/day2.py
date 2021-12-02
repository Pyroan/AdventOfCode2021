with open('day2.txt') as f:
    l = [l.split(' ')for l in f]
x, y = 0, 0
for d in l:
    if d[0] == 'forward':
        x += int(d[1])
    elif d[0] == 'down':
        y += int(d[1])
    elif d[0] == 'up':
        y -= int(d[1])
print(x*y)
