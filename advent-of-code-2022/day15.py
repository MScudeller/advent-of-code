import functools

from aoc import get_input


def get_example():
    return [
        "Sensor at x=2, y=18: closest beacon is at x=-2, y=15",
        "Sensor at x=9, y=16: closest beacon is at x=10, y=16",
        "Sensor at x=13, y=2: closest beacon is at x=15, y=3",
        "Sensor at x=12, y=14: closest beacon is at x=10, y=16",
        "Sensor at x=10, y=20: closest beacon is at x=10, y=16",
        "Sensor at x=14, y=17: closest beacon is at x=10, y=16",
        "Sensor at x=8, y=7: closest beacon is at x=2, y=10",
        "Sensor at x=2, y=0: closest beacon is at x=2, y=10",
        "Sensor at x=0, y=11: closest beacon is at x=2, y=10",
        "Sensor at x=20, y=14: closest beacon is at x=25, y=17",
        "Sensor at x=17, y=20: closest beacon is at x=21, y=22",
        "Sensor at x=16, y=7: closest beacon is at x=15, y=3",
        "Sensor at x=14, y=3: closest beacon is at x=15, y=3",
        "Sensor at x=20, y=1: closest beacon is at x=15, y=3",
    ]


reach = "#"
nothing = "."
sensor = "S"
Beacon = "B"


def distance(x1, y1, x2, y2):
    x_min = min(x1, x2)
    y_min = min(y1, y2)
    x_max = max(x1, x2)
    y_max = max(y1, y2)
    return x_max - x_min + y_max - y_min


def parse_sensor(line):
    split = line[12:].split(",")
    s_x = int(split[0])
    s_y = int(split[1][3:].split(":")[0])

    beacon_split = line.split("beacon is at x=")[1]
    b_x = int(beacon_split.split(",")[0])
    b_y = int(beacon_split.split(",")[1].split("=")[1])
    dist = distance(s_x, s_y, b_x, b_y)
    return s_x, s_y, dist, b_x, b_y


def parse_sensors(lines):
    sensors = []
    beacons = []
    for line in lines:
        s_x, s_y, dist, b_x, b_y = parse_sensor(line)
        sensors.append((s_x, s_y, dist))
        beacons.append((b_x, b_y))
        pass
    return sensors, beacons


def run_part_1():
    # lines, foo = get_input(15).splitlines(), 2000000
    lines, foo = get_example(), 10
    sensors, beacons = parse_sensors(lines)
    foo_sensors = [set(range(x - (dist - abs(y - foo)), x + (dist - abs(y - foo)) + 1)) for x, y, dist in sensors if
                   y - dist <= foo <= y + dist]
    foo_range = functools.reduce(lambda a, b: a.union(b), foo_sensors)
    foo_beacons = [bx for bx, by in beacons if by == foo]
    for beacon in foo_beacons:
        foo_range.discard(beacon)
    print(len(foo_range))
    pass


def find_perimeter(s_x, s_y, dist):
    dist = dist + 1
    for i in range(dist):
        yield s_x + i, s_y + dist - i
        yield s_x - i, s_y - dist + i
        yield s_x + dist - i, s_y + i
        yield s_x - dist + i, s_y - i


def is_in_range(x, y, sensors):
    for s_x, s_y, dist in sensors:
        if distance(x, y, s_x, s_y) <= dist:
            return True
    return False


def run_part_2():
    lines, foo = get_input(15).splitlines(), 4000000
    # lines, foo = get_example(), 20
    sensors, beacons = parse_sensors(lines)
    possibilities = [find_perimeter(x, y, dist) for x, y, dist in sensors]
    for poss in possibilities:
        for x, y in poss:
            if not is_in_range(x, y, sensors) and 0 <= x <= foo and 0 <= y <= foo:
                print((x * 4000000) + y)
                return


run_part_1()
run_part_2()
