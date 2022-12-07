from aoc import get_input

lines = get_input(4).splitlines()


def split_sets(line):
    elves = line.split(",")
    elf1_sectors = elves[0].split("-")
    elf1 = set(range(int(elf1_sectors[0]), int(elf1_sectors[1]) + 1))
    elf2_sectors = elves[1].split("-")
    elf2 = set(range(int(elf2_sectors[0]), int(elf2_sectors[1]) + 1))
    return elf1, elf2


def has_overlap(line: str):
    elf1, elf2 = split_sets(line)
    return elf1.issuperset(elf2) or elf2.issuperset(elf1)


print(len([line for line in lines if has_overlap(line)]))


def has_intersection(line: str):
    elf1, elf2 = split_sets(line)
    return len(elf1.intersection(elf2)) > 0


print(len([line for line in lines if has_intersection(line)]))
