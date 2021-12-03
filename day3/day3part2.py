with open('day3.txt') as f:
    l = f.readlines()


def f(r, s):
    q = l[:]
    i = 0
    while len(q) != 1:
        q = list(filter(lambda x: x[i] == (r if sum([int(b[i])
                                                     for b in q]) >= len(q)/2 else s), q))
        i += 1
    return int(q[0], 2)


print(f('1', '0')*f('0', '1'))
