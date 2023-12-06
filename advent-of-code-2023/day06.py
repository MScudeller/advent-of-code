from aoc import get_input

# day_input = """Time:      7  15   30
# Distance:  9  40  200"""

day_input = get_input(6)
lines = day_input.splitlines()


def get_races(lines):
    times = [int(t) for t in lines[0].split(" ") if t.isdigit()]
    dists = [int(d) for d in lines[1].split(" ") if d.isdigit()]
    return list(zip(times, dists))


def is_winnable(hold_time, total_time, record):
    return hold_time * (total_time - hold_time) > record


def get_winnable_races(races):
    a = 1
    for race in races:
        a *= sum([1 for time in range(race[0]) if is_winnable(time, race[0], race[1])])

    return a


print(get_winnable_races(get_races(lines)))


def get_races2(lines: list[str]):
    times = int(lines[0].split(":")[1].replace(" ", ""))
    dists = int(lines[1].split(":")[1].replace(" ", ""))
    return [(times, dists)]


print(get_winnable_races(get_races2(lines)))
