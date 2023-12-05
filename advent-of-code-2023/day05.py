from aoc import get_input

# day_input = """seeds: 79 14 55 13
#
# seed-to-soil map:
# 50 98 2
# 52 50 48
#
# soil-to-fertilizer map:
# 0 15 37
# 37 52 2
# 39 0 15
#
# fertilizer-to-water map:
# 49 53 8
# 0 11 42
# 42 0 7
# 57 7 4
#
# water-to-light map:
# 88 18 7
# 18 25 70
#
# light-to-temperature map:
# 45 77 23
# 81 45 19
# 68 64 13
#
# temperature-to-humidity map:
# 0 69 1
# 1 0 69
#
# humidity-to-location map:
# 60 56 37
# 56 93 4"""

day_input = get_input(5)
almanac = day_input.split("\n\n")
initial_seeds = [int(s) for s in almanac[0].split("ds: ")[1].split(" ")]


def map_seed(numbers_str, seed):
    numbers = [int(n) for n in numbers_str.split(" ")]
    if numbers[1] <= seed <= numbers[1] + numbers[2]:
        return numbers[0] + seed - numbers[1], True

    return seed, False


def run_map(step: str, seeds: list[int]):
    map_lines = step.splitlines()[1:]
    next_seeds: list[int] = []
    for seed in seeds:
        for map_line in map_lines:
            seed, seed_changed = map_seed(map_line, seed)
            if seed_changed:
                break

        next_seeds.append(seed)

    return next_seeds


def run_almanac(seeds):
    for almanac_step in almanac[1:]:
        seeds = run_map(almanac_step, seeds)

    return min(seeds)


seeds_part1 = initial_seeds.copy()
print("part 1")
print(run_almanac(seeds_part1))


def map_seed2(numbers, seed):
    if seed[2]:
        return [seed]

    seed_start = seed[0]
    seed_end = seed_start + seed[1] - 1
    map_start = numbers[1]
    map_end = map_start + numbers[2] - 1
    conversion = numbers[0] - map_start

    # whole seed inside map
    if map_start <= seed_start <= seed_end <= map_end:
        return [(seed_start + conversion, seed[1], True)]

    # seed partially inside map starting before
    if seed_start < map_start <= seed_end <= map_end:
        return [(seed_start, map_start - seed_start - 1, False),
                (map_start + conversion, seed_end - map_start + 1, True)]

    # seed partially inside ending after
    if map_start <= seed_start <= map_end <= seed_end:
        return [(seed_start + conversion, map_end - seed_start + 1, True),
                (map_end, seed_end - map_end + 1, False)]

    # whole map inside seed
    if seed_start <= map_start <= map_end <= seed_end:
        return [(seed_start, map_start - seed_start - 1, False),
                (map_start + conversion, map_end - map_start + 1, True),
                (map_end + 1, seed_end - map_end, False)]

    # whole seed outside map
    return [seed]


def run_map2(step: str, seeds: list[(int, int)]):
    map_lines = step.splitlines()[1:]
    next_seeds = []
    for map_line in map_lines:
        map_numbers = [int(n) for n in map_line.split(" ")]
        for seed in seeds:
            splits = map_seed2(map_numbers, seed)
            next_seeds.extend(splits)

        seeds = next_seeds.copy()
        next_seeds = []

    return [(s[0], s[1], False) for s in seeds]


def run_almanac2(seeds):
    for step in almanac[1:]:
        seeds = run_map2(step, seeds)

    return min(map(lambda x: x[0], seeds))


seeds_part1_for_part2 = [(initial_seeds[i], 1, False) for i in range(int(len(initial_seeds)))]
print("part 1 done with part 2 code:")
print(run_almanac2(seeds_part1_for_part2))

seeds_part2 = [(initial_seeds[i * 2], initial_seeds[i * 2 + 1], False) for i in range(int(len(initial_seeds) / 2))]
print("part 2")
print(run_almanac2(seeds_part2))
