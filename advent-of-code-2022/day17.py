import functools

from aoc import get_input


def get_example():
    return [
        ">>><<><>><<<>><>>><<<>>><<<><<<>><>><<>>",
    ]


rocks = {
    0: [".......",
        ".......",
        ".......",
        "..@@@@."],
    1: [".......",
        ".......",
        ".......",
        "...@...",
        "..@@@..",
        "...@..."],
    2: [".......",
        ".......",
        ".......",
        "..@@@..",
        "....@..",
        "....@.."],
    3: [".......",
        ".......",
        ".......",
        "..@....",
        "..@....",
        "..@....",
        "..@...."],
    4: [".......",
        ".......",
        ".......",
        "..@@...",
        "..@@..."]
}


def get_rock(i):
    rock_id = i % 5
    return rocks[rock_id]


def get_gust_direction(gust_directions, i):
    gust_id = i % len(gust_directions)
    return gust_directions[gust_id], gust_id + 1


def parse_gust_directions(lines):
    return lines[0]


def try_move_right(drawing: list[str], rock_height: int):
    rock_index = 0
    for line in drawing:
        if "@" not in line:
            rock_index += 1
        else:
            break
    rock = [drawing[i + rock_index] for i in range(rock_height)]
    if all(r[6] == "." and "#" not in r for r in rock):
        for i, r in enumerate(rock):
            drawing[i + rock_index] = r[:6].rjust(7, ".")
        return

    pass
    if all(r.rindex("@") != 6 and r[r.rindex("@") + 1] == "." for r in rock):
        for index in range(rock_height):
            i = drawing[index + rock_index].rindex("@") + 1
            drawing[index + rock_index] = replace_index(drawing[index + rock_index], i, "@")
            l = drawing[index + rock_index].index("@")
            drawing[index + rock_index] = replace_index(drawing[index + rock_index], l, ".")


def try_move_left(drawing: list[str], rock_height):
    rock_index = 0
    for line in drawing:
        if "@" not in line:
            rock_index += 1
        else:
            break
    rock = [drawing[i + rock_index] for i in range(rock_height)]
    if all(r[0] == "." and "#" not in r for r in rock):
        for i, r in enumerate(rock):
            drawing[i + rock_index] = r[1:7].ljust(7, ".")
        return

    if all(r.index("@") != 0 and r[r.index("@") - 1] == "." for r in rock):
        for index in range(rock_height):
            i = drawing[index + rock_index].index("@") - 1
            drawing[index + rock_index] = replace_index(drawing[index + rock_index], i, "@")
            l = drawing[index + rock_index].rindex("@")
            drawing[index + rock_index] = replace_index(drawing[index + rock_index], l, ".")


def get_indexes(line, chars):
    return set(i for i, c in enumerate(line) if c in chars)


def try_move_down(drawing, rock_height):
    if len(drawing) == rock_height:
        for i in range(rock_height):
            new_line = drawing[i].replace("@", "#")
            drawing[i] = new_line
        return False

    if drawing[rock_height] == ".......":
        drawing.pop(rock_height)
        return True

    rock_index = 0
    for line in drawing:
        if "@" not in line:
            rock_index += 1
        else:
            break
    merging_lines = [drawing[i + rock_index] for i in range(rock_height + 1)]
    merging_lines_pair = [(get_indexes(merging_lines[i], ["@"]), get_indexes(merging_lines[i + 1], ["#", "-"])) for i in
                          range(rock_height)]
    if all(a.isdisjoint(b) for a, b in merging_lines_pair):
        for index, item in reversed(list(enumerate(merging_lines_pair))):
            a, b = item
            for i in a:
                drawing[index + rock_index + 1] = replace_index(drawing[index + rock_index + 1], i, "@")
                drawing[index + rock_index] = replace_index(drawing[index + rock_index], i, ".")
        if drawing[0] == ".......":
            drawing.pop(0)
        return True

    for i in range(rock_height):
        new_line = drawing[i + rock_index].replace("@", "#")
        drawing[i + rock_index] = new_line
    return False


def replace_index(word, index, char):
    result = word[0:index] + char + word[index + 1:]
    return result


def print_drawing(drawing):
    print("\n".join(drawing))
    print("\n")


def run_part_1():
    lines, rock_count = get_input(17).splitlines(), 2022
    # lines, rock_count = get_example(), 2022
    gust_directions = parse_gust_directions(lines)
    gust_i = 0
    start = []
    for i in range(rock_count):
        rock = get_rock(i)
        rock_height = len(rock) - 3
        start.reverse()
        start.extend(rock)
        start.reverse()
        moved_down = True
        while moved_down:
            direction, gust_i = get_gust_direction(gust_directions, gust_i)
            if direction == ">":
                try_move_right(start, rock_height)
            else:
                try_move_left(start, rock_height)
            moved_down = try_move_down(start, rock_height)
    print(len(start))


def fast_forward(drawing, directions, rock_height):
    direction = sum(-1 if d == "<" else 1 for d in directions)
    if direction != 0:
        f = try_move_left if direction < 0 else try_move_right
        for i in range(abs(direction)):
            f(drawing, rock_height)
    for i in range(3):
        try_move_down(drawing, rock_height)


def run_part_2():
    lines, rock_count = get_input(17).splitlines(), 1000000000000
    # lines, rock_count = get_example(), 1000000000000
    gust_directions = parse_gust_directions(lines)
    gust_i = 0
    start = []
    for i in range(rock_count):
        rock = get_rock(i)
        rock_height = len(rock) - 3
        start.reverse()
        start.extend(rock)
        start.reverse()
        moved_down = True
        while moved_down:
            direction, gust_i = get_gust_direction(gust_directions, gust_i)
            if direction == ">":
                try_move_right(start, rock_height)
            else:
                try_move_left(start, rock_height)
            moved_down = try_move_down(start, rock_height)
    print(len(start))


# run_part_1()
run_part_2()
