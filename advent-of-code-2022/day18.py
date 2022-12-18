from aoc import get_input


def get_example():
    return [
        "2, 2, 2",
        "1, 2, 2",
        "3, 2, 2",
        "2, 1, 2",
        "2, 3, 2",
        "2, 2, 1",
        "2, 2, 3",
        "2, 2, 4",
        "2, 2, 6",
        "1, 2, 5",
        "3, 2, 5",
        "2, 1, 5",
        "2, 3, 5",
    ]


def parse_cubes(lines):
    return [[int(i) for i in line.split(",")] for line in lines]


def run_part_1():
    lines = get_input(18).splitlines()
    # lines = get_example()
    cubes = parse_cubes(lines)
    foo = 0
    for x, y, z in cubes:
        sides = 0
        if [x + 1, y, z] not in cubes:
            sides += 1
        if [x - 1, y, z] not in cubes:
            sides += 1
        if [x, y + 1, z] not in cubes:
            sides += 1
        if [x, y - 1, z] not in cubes:
            sides += 1
        if [x, y, z + 1] not in cubes:
            sides += 1
        if [x, y, z - 1] not in cubes:
            sides += 1
        foo += sides
    print(foo)


def get_adjacent_cubes(cube):
    x, y, z = cube
    return [
        [x + 1, y, z],
        [x - 1, y, z],
        [x, y + 1, z],
        [x, y - 1, z],
        [x, y, z + 1],
        [x, y, z - 1]
    ]


def flood(cubes, cube, boundaries):
    min_x, max_x, min_y, max_y, min_z, max_z = boundaries
    count = 0
    queue = [cube]
    checked = []
    while len(queue) != 0:
        c = queue.pop(0)
        x, y, z = c
        if min_x <= x <= max_x and min_y <= y <= max_y and min_z <= z <= max_z and c not in cubes:
            side_cubes = get_adjacent_cubes(c)
            surface_cubes = [s for s in side_cubes if s in cubes]
            count += len(surface_cubes)
            queue.extend([s for s in side_cubes if s not in checked and s not in cubes and s not in queue])
        checked.append(c)
    return count


def run_part_2():
    lines = get_input(18).splitlines()
    # lines = get_example()
    cubes = parse_cubes(lines)

    minx, maxx, miny, maxy, minz, maxz = 99, 0, 99, 0, 99, 0
    for x, y, z in cubes:
        minx = min(minx, x)
        maxx = max(maxx, x)
        miny = min(miny, y)
        maxy = max(maxy, y)
        minz = min(minz, z)
        maxz = max(maxz, z)

    count = flood(cubes, [0, 0, 0], [minx - 1, maxx + 1, miny - 1, maxy + 1, minz - 1, maxz + 1])
    print(count)


run_part_1()
run_part_2()
