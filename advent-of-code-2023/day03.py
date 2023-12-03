from aoc import get_input

lines = get_input(3).splitlines()
rows = len(lines)
columns = len(lines[0])


def is_symbol(c: str):
    return not c.isdigit() and c != "."


def find_adjacent_positions(i: int, j: int):
    adjacent = [(x, y) for x in range(i - 1, i + 2) if 0 <= x < rows for y in range(j - 1, j + 2) if 0 <= y < columns]
    adjacent.remove((i, j))
    return adjacent


def get_digits(positions):
    adjacent_digits = [position for position in positions if lines[position[0]][position[1]].isdigit()]
    digits = set()
    for digit in adjacent_digits:
        first_position = digit
        while first_position[1] - 1 >= 0 and lines[first_position[0]][first_position[1] - 1].isdigit():
            first_position = (digit[0], first_position[1] - 1)
        digits.add(first_position)
    return digits


def get_full_digit(x, y):
    last_y = y
    while last_y < columns and lines[x][last_y].isdigit():
        last_y += 1
    return int(lines[x][y:last_y])


symbols = [(i, j) for i, line in enumerate(lines) for j, char in enumerate(line) if is_symbol(char)]
foo = [get_digits(find_adjacent_positions(i, j)) for i, j in symbols]
bar = set([item for sublist in foo for item in sublist])
print(sum(get_full_digit(pos[0], pos[1]) for pos in bar))


def is_potential_gear(c: str):
    return c == "*"


def gear_ratio(gear):
    gl = list(gear)
    g0 = get_full_digit(gl[0][0], gl[0][1])
    g1 = get_full_digit(gl[1][0], gl[1][1])
    return g0 * g1


symbols = [(i, j) for i, line in enumerate(lines) for j, char in enumerate(line) if is_potential_gear(char)]
foo = [get_digits(find_adjacent_positions(i, j)) for i, j in symbols]
filtered = filter(lambda a: len(a) == 2, foo)

print(sum(gear_ratio(pos) for pos in filtered))
