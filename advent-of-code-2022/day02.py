from aoc import get_input

lines = get_input(2).splitlines()

def my_play(line: str): return {'X': 1, 'Y': 2, 'Z': 3, }.get(line[2])


def outcome(line: str):
    elf = line[0]
    my = line[2]
    if (elf == 'A' and my == 'X') or (elf == 'B' and my == 'Y') or (elf == 'C' and my == 'Z'):
        return 3
    elif (elf == 'A' and my == 'Y') or (elf == 'B' and my == 'Z') or (elf == 'C' and my == 'X'):
        return 6
    else:
        return 0


def outcome2(line: str): return {'X': 0, 'Y': 3, 'Z': 6, }.get(line[2])


def my_play2(line: str):
    elf = line[0]
    my = line[2]
    if (elf == 'C' and my == 'Z') or (elf == 'A' and my == 'Y') or (elf == 'B' and my == 'X'):
        return 1
    elif (elf == 'A' and my == 'Z') or (elf == 'B' and my == 'Y') or (elf == 'C' and my == 'X'):
        return 2
    else:
        return 3


print(sum([my_play(line) + outcome(line) for line in lines]))
print(sum([my_play2(line) + outcome2(line) for line in lines]))
