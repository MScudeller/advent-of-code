from aoc import get_input

day_input = get_input(10)
example_1 = """.....
.S-7.
.|.|.
.L-J.
....."""
example_2 = """-L|F7
7S-7|
L|7||
-L-J|
L|-JF"""
example_3 = """..F7.
.FJ|.
SJ.L7
|F--J
LJ..."""
example_4 = """7-F7-
.FJ|7
SJLL7
|F--J
LJ.LJ"""


def prepare_map(input_text):
    input_map = input_text.splitlines()
    padded_map = ["." + line + "." for line in input_map]
    columns = len(padded_map[0])
    padded_map.insert(0, "." * columns)
    padded_map.append("." * columns)
    return padded_map


def find_adjacent_positions(i: int, j: int):
    return [(i + 1, j), (i - 1, j), (i + 1, j), (i, j - 1)]


def find_connected_pipes(pipe, input_map):
    possible_connections = {
        "S": [(1, 0), (-1, 0), (0, 1), (0, -1)],
        "|": [(1, 0), (-1, 0)],
        "-": [(0, 1), (0, -1)],
        "L": [(-1, 0), (0, 1)],
        "J": [(-1, 0), (0, -1)],
        "7": [(1, 0), (0, -1)],
        "F": [(1, 0), (0, 1)],
    }

    possible_pieces = {
        (1, 0): "|LJS",
        (-1, 0): "|F7S",
        (0, 1): "-J7S",
        (0, -1): "-LFS",
    }

    connected = []

    for connection in possible_connections[pipe[2]]:
        connection_y = pipe[0] + connection[0]
        connection_x = pipe[1] + connection[1]
        connection_symbol = input_map[connection_y][connection_x]
        if connection_symbol in possible_pieces[connection]:
            connected.append((connection_y, connection_x, connection_symbol, None))

    return connected


def part1(input_text):
    input_map = prepare_map(input_text)
    mapped = {(i, j): (i, j, c, 0) for i, line in enumerate(input_map) for j, c in enumerate(line) if c == "S"}
    to_be_mapped = find_connected_pipes(list(mapped.values())[0], input_map)
    while len(to_be_mapped) > 0:
        pipe = to_be_mapped.pop(0)
        connected = find_connected_pipes(pipe, input_map)
        min_dist = None
        for c in connected:
            if (c[0], c[1]) in mapped:
                mapped_connected = mapped[(c[0], c[1])]
                if min_dist is None:
                    min_dist = mapped_connected[3]
                else:
                    min_dist = min(min_dist, mapped_connected[3])
            else:
                to_be_mapped.append(c)
        mapped[(pipe[0], pipe[1])] = (pipe[0], pipe[1], input_map[pipe[0]][pipe[1]], min_dist + 1)

    return list(mapped.values())[-1][-1]


print(part1(example_1))
print(part1(example_2))
print(part1(example_3))
print(part1(example_4))
print(part1(day_input))

example_5 = """...........
.S-------7.
.|F-----7|.
.||.....||.
.||.....||.
.|L-7.F-J|.
.|..|.|..|.
.L--J.L--J.
..........."""
example_6 = """.F----7F7F7F7F-7....
.|F--7||||||||FJ....
.||.FJ||||||||L7....
FJL7L7LJLJ||LJ.L-7..
L--J.L7...LJS7F-7L7.
....F-J..F7FJ|L7L7L7
....L7.F7||L7|.L7L7|
.....|FJLJ|FJ|F7|.LJ
....FJL-7.||.||||...
....L---J.LJ.LJLJ..."""
example_7 = """FF7FSF7F7F7F7F7F---7
L|LJ||||||||||||F--J
FL-7LJLJ||||||LJL-77
F--JF--7||LJLJ7F7FJ-
L---JF-JLJ.||-FJLJJ7
|F|F-JF---7F7-L7L|7|
|FFJF7L7F-JF7|JL---7
7-L-JL7||F7|L7F-7F7|
L.L7LFJ|||||FJL7||LJ
L7JLJL-JLJLJL--JLJ.L"""


def part2(input_text):
    input_map = prepare_map(input_text)
    mapped = {(i, j): (i, j, c, 0) for i, line in enumerate(input_map) for j, c in enumerate(line) if c == "S"}
    to_be_mapped = find_connected_pipes(list(mapped.values())[0], input_map)
    while len(to_be_mapped) > 0:
        pipe = to_be_mapped.pop(0)
        connected = find_connected_pipes(pipe, input_map)
        min_dist = None
        for c in connected:
            if (c[0], c[1]) in mapped:
                mapped_connected = mapped[(c[0], c[1])]
                if min_dist is None:
                    min_dist = mapped_connected[3]
                else:
                    min_dist = min(min_dist, mapped_connected[3])
            else:
                to_be_mapped.append(c)
        mapped[(pipe[0], pipe[1])] = (pipe[0], pipe[1], input_map[pipe[0]][pipe[1]], min_dist + 1)

    return list(mapped.values())[-1][-1]


print(part2(example_5))
print(part2(example_6))
print(part2(example_7))
print(part2(day_input))
