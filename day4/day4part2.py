
with open('day4.txt') as f:
    l = f.read().split('\n\n')
    numbers = map(int, l[0].split(','))
    boards = []
    truths = []
    for m in l[1:]:
        boards.append([list(map(lambda x:int(x.strip()), line.split()))
                       for line in m.split('\n')])
        t = []
        for i in range(5):
            t.append([False]*5)
        truths.append(t)


def is_winner(board):
    return any([sum(line) >= 5 for line in board])or any([sum([line[b] for line in board]) >= 5 for b in range(5)])


for n in numbers:
    for k in range(len(boards)):
        # mark the number
        for i in range(5):
            for j in range(5):
                if boards[k][i][j] == n:
                    truths[k][i][j] = True
        # check if winning
        if all(is_winner(t) for t in truths):
            # if there's a winner, get the score & exit
            score = 0
            for i in range(5):
                for j in range(5):
                    if not truths[k][i][j]:
                        score += boards[k][i][j]
            score *= n
            print(score)
            exit(0)
