from aoc import get_input


def get_example():
    return [
        "498,4 -> 498,6 -> 496,6",
        "503,4 -> 502,4 -> 502,9 -> 494,9",
    ]


rock = "#"
air = "."
sand = "o"


def parse_rocks(lines: list[str]):
    v_slice = [[air for _ in range(900)] for _ in range(180)]  # max = 573, 172
    for line in lines:
        dots = line.split(" -> ")
        for i in range(len(dots) - 1):
            start_x, start_y = [int(a) for a in dots[i].split(",")]
            end_x, end_y = [int(a) for a in dots[i + 1].split(",")]
            add_rock(end_x, end_y, start_x, start_y, v_slice)
    return v_slice


def add_rock(end_x, end_y, start_x, start_y, v_slice):
    range_x = range(min(start_x, end_x), max(start_x, end_x) + 1, 1)
    range_y = range(min(start_y, end_y), max(start_y, end_y) + 1, 1)
    if len(range_x) == 1:
        x = range_x[0]
        for y in range_y:
            v_slice[y][x] = rock
    else:
        y = range_y[0]
        for x in range_x:
            v_slice[y][x] = rock


def drop_sand(v_slice, x, y):
    if v_slice[y][x] != air:
        return False
    sand_x, sand_y = x, y
    while True:
        if sand_y + 1 == len(v_slice):
            return False
        if v_slice[sand_y + 1][sand_x] == air:
            sand_y += 1
        elif v_slice[sand_y + 1][sand_x - 1] == air:
            sand_y += 1
            sand_x -= 1
        elif v_slice[sand_y + 1][sand_x + 1] == air:
            sand_y += 1
            sand_x += 1
        else:
            v_slice[sand_y][sand_x] = sand
            return True


def run_part_1():
    lines = get_input(14).splitlines()
    # lines = get_example()
    v_slice = parse_rocks(lines)
    count = 0
    while drop_sand(v_slice, 500, 0):
        count += 1
    print(count)


def run_part_2():
    lines = get_input(14).splitlines()
    # lines = get_example()
    v_slice = parse_rocks(lines)
    last = 0
    for i in range(-1, -len(v_slice), -1):
        if rock in v_slice[i]:
            last = i
            break

    bottom = len(v_slice) + last + 2
    add_rock(len(v_slice[0]) - 1, bottom, 0, bottom, v_slice)
    count = 0
    while drop_sand(v_slice, 500, 0):
        count += 1
    print(count)


run_part_1()
run_part_2()
