from aoc import get_input

day_input = """seeds: 79 1 14 1 55 1 13 1

seed-to-soil map:
50 98 2
52 50 48

soil-to-fertilizer map:
0 15 37
37 52 2
39 0 15

fertilizer-to-water map:
49 53 8
0 11 42
42 0 7
57 7 4

water-to-light map:
88 18 7
18 25 70

light-to-temperature map:
45 77 23
81 45 19
68 64 13

temperature-to-humidity map:
0 69 1
1 0 69

humidity-to-location map:
60 56 37
56 93 4"""

# day_input = get_input(5)
maps = day_input.split("\n\n")


def map_seed(numbers_str, seed):
    numbers = [int(n) for n in numbers_str.split(" ")]
    if numbers[1] <= seed <= numbers[1] + numbers[2]:
        return numbers[0]+seed-numbers[1], True
    return seed, False


def run_map(mapa: str, seeds: list[int]):
    foo = mapa.splitlines()

    bar: list[int] = []
    for s in seeds:
        for f in foo[1:]:
            s, seed_changed = map_seed(f, s)
            if seed_changed:
                break
        bar.append(s)
    return bar


seeds = [int(s) for s in maps[0].split("ds: ")[1].split(" ")]

for mapa in maps[1:]:
    seeds = run_map(mapa, seeds)

print(min(seeds))


def map_seed2(numbers_str, seed):
    if seed[2]:
        return [seed]
    numbers = [int(n) for n in numbers_str.split(" ")]
    seed_start = seed[0]
    seed_end = seed_start + seed[1]
    map_start = numbers[1]
    map_end = map_start + numbers[2]
    if map_start <= seed_start <= seed_end <= map_end:  # whole seed inside map - done
        return [(numbers[0] + seed_start - map_start, seed[1], True)]

    if seed_start < map_start <= seed_end <= map_end:  # seed partially inside map starting before - missing map calc
        return [(seed_start, map_start - seed_start, False), (numbers[0], seed_end - map_start, True)]

    if map_start <= seed_start <= map_end <= seed_end:  # seed partially inside ending after - done
        return [(numbers[0] + seed_start - map_start, map_end - seed_start, True), (map_end, seed_end - map_end, False)]

    if seed_start <= map_start <= map_end <= seed_end:  # whole map inside seed - missing map calc
        return [(seed_start, map_start - seed_start, False),
                (numbers[0], map_end - map_start, True),
                (map_end, seed_end - map_end, False)]

    # if seed_end <= map_start or map_end <= seed_start:  # whole seed outside map up or down
    return [seed]


def run_map2(mapa: str, seeds: list[(int, int)]):
    foo = mapa.splitlines()
    seeds2 = []
    for f in foo[1:]:
        for s in seeds:
            splits = map_seed2(f, s)
            seeds2.extend(splits)
        seeds = seeds2.copy()
        seeds2 = []
    return seeds


seeds2 = [(seeds[i], seeds[i+1], False) for i in range(int(len(seeds)/2))]

for mapa in maps[1:]:
    seeds2 = run_map2(mapa, seeds2)


print(min(map(lambda x: x[0], seeds2)))

