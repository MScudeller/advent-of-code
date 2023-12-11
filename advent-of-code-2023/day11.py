from aoc import get_input

example_input = """...#......
.......#..
#.........
..........
......#...
.#........
.........#
..........
.......#..
#...#....."""
day_input = get_input(11)


def prepare_map(inp: str, qty: int):
    foo = qty - 1
    input_map = [[(c, 1) for c in list(line)] for line in inp.splitlines()]
    for i in range(len(input_map))[::-1]:
        if all([c == "." for c, _ in input_map[i]]):
            for f in input_map[i]:
                input_map.pop(i)
                input_map.insert(i, [(".", qty)] * len(input_map[i]))

    for j in range(len(input_map[0]))[::-1]:
        column = [input_map[i][j] for i in range(len(input_map))]
        if all([c == "." for c, _ in column]):
            for i in range(len(input_map)):
                input_map[i].pop(j)
                input_map[i].insert(j, (".", qty))

    return input_map


def find_galaxies(complete_map: list[list[(str, int)]]):
    return [(x, y, c) for x, line in enumerate(complete_map) for y, c in enumerate(line) if c[0] == "#"]


def find_paths(galaxies):
    found_paths = set()
    for g1 in galaxies:
        for g2 in galaxies:
            if g1 != g2 and (g2, g1) not in found_paths:
                found_paths.add((g1, g2))

    return found_paths


def get_distance(path, prepared_map):
    p1, p2 = path
    dist = 0
    for d in range(min(p1[0], p2[0]), max(p1[0], p2[0])):
        dist += prepared_map[d][p1[1]][1]
    for d in range(min(p1[1], p2[1]), max(p1[1], p2[1])):
        dist += prepared_map[p1[0]][d][1]
    return dist


def run(inp, qty):
    prepared_map = prepare_map(inp, qty)
    found_galaxies = find_galaxies(prepared_map)
    paths = find_paths(found_galaxies)
    return sum([get_distance(path, prepared_map) for path in paths])


print(run(example_input, 2))
print(run(day_input, 2))
print(run(example_input, 10))
print(run(example_input, 100))
print(run(day_input, 1000000))

