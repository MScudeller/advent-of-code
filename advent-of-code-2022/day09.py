from aoc import get_input

lines = get_input(9).splitlines()

# lines = ['R 4',
#          'U 4',
#          'L 3',
#          'D 1',
#          'R 4',
#          'D 1',
#          'L 5',
#          'R 2',
#          ]
# lines = ['R 5',
#          'U 8',
#          'L 8',
#          'D 3',
#          'R 17',
#          'D 10',
#          'L 25',
#          'U 20',
#          ]

Hx, Hy, Tx, Ty = 0, 0, 0, 0
positions = {(Tx, Ty): 1}
for line in lines:
    command = line.split(" ")
    direction = command[0]
    amount = int(command[1])
    for i in range(amount):
        if direction == "U":
            Hy += 1
        elif direction == "D":
            Hy -= 1
        elif direction == "R":
            Hx += 1
        elif direction == "L":
            Hx -= 1

        if not (set(range(Hx - 1, Hx + 2)).__contains__(Tx) and set(range(Hy - 1, Hy + 2)).__contains__(Ty)):
            if Tx == Hx and Hy - Ty > 0:
                Ty += 1
            elif Tx == Hx and Hy - Ty < 0:
                Ty -= 1
            elif Ty == Hy and Hx - Tx > 0:
                Tx += 1
            elif Ty == Hy and Hx - Tx < 0:
                Tx -= 1
            elif direction == "U":
                Tx = Hx
                Ty += 1
            elif direction == "D":
                Tx = Hx
                Ty -= 1
            elif direction == "R":
                Ty = Hy
                Tx += 1
            elif direction == "L":
                Ty = Hy
                Tx -= 1

            positions.update({(Tx, Ty): 1})

print(len(positions.values()))


Hx, Hy = 0, 0
T1x, T1y = 0, 0
T2x, T2y = 0, 0
T3x, T3y = 0, 0
T4x, T4y = 0, 0
T5x, T5y = 0, 0
T6x, T6y = 0, 0
T7x, T7y = 0, 0
T8x, T8y = 0, 0
T9x, T9y = 0, 0

positions = {(T9x, T9y): 1}


def follow(Hx: int, Hy: int, Tx: int, Ty: int, is_last: bool):
    if not (Hx - 1 <= Tx <= Hx + 1 and Hy - 1 <= Ty <= Hy + 1):
        if Tx == Hx and Hy - Ty > 0:
            Ty += 1
        elif Tx == Hx and Hy - Ty < 0:
            Ty -= 1
        elif Ty == Hy and Hx - Tx > 0:
            Tx += 1
        elif Ty == Hy and Hx - Tx < 0:
            Tx -= 1
        elif Hy - Ty > 1 and Hx - Tx > 1:
            Tx += 1
            Ty += 1
        elif Hy - Ty > 1 and Hx - Tx < -1:
            Tx -= 1
            Ty += 1
        elif Hy - Ty < -1 and Hx - Tx > 1:
            Tx += 1
            Ty -= 1
        elif Hy - Ty < -1 and Hx - Tx < -1:
            Tx -= 1
            Ty -= 1
        elif Hy - Ty > 1:
            Tx = Hx
            Ty += 1
        elif Hy - Ty < -1:
            Tx = Hx
            Ty -= 1
        elif Hx - Tx > 1:
            Ty = Hy
            Tx += 1
        elif Hx - Tx < -1:
            Ty = Hy
            Tx -= 1

        if is_last:
            positions.update({(Tx, Ty): 1})

    return Tx, Ty


for line in lines:
    command = line.split(" ")
    direction = command[0]
    amount = int(command[1])
    for i in range(amount):
        if direction == "U":
            Hy += 1
        elif direction == "D":
            Hy -= 1
        elif direction == "R":
            Hx += 1
        elif direction == "L":
            Hx -= 1

        T1x, T1y = follow(Hx, Hy, T1x, T1y, False)
        T2x, T2y = follow(T1x, T1y, T2x, T2y, False)
        T3x, T3y = follow(T2x, T2y, T3x, T3y, False)
        T4x, T4y = follow(T3x, T3y, T4x, T4y, False)
        T5x, T5y = follow(T4x, T4y, T5x, T5y, False)
        T6x, T6y = follow(T5x, T5y, T6x, T6y, False)
        T7x, T7y = follow(T6x, T6y, T7x, T7y, False)
        T8x, T8y = follow(T7x, T7y, T8x, T8y, False)
        T9x, T9y = follow(T8x, T8y, T9x, T9y, True)
        pass

print(len(positions.values()))
pass
