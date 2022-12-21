import re

import numpy as np

from aoc import get_input


def get_example():
    return [
        "1",
        "2",
        "-3",
        "3",
        "-2",
        "0",
        "4",
    ]


def parse_file(lines):
    return [int(line) for line in lines]


def run_part_1():
    lines = get_input(20).splitlines()
    # lines = get_example()
    parsed_file = parse_file(lines)
    index0 = parsed_file.index(0)
    file = list(enumerate(parsed_file))
    arranged_file = file.copy()
    for f in file:
        index = arranged_file.index(f)
        arranged_file.pop(index)
        new_index = (index + f[1])
        calculated_index = new_index % len(arranged_file)
        arranged_file.insert(calculated_index, f)
        pass
    index0 = arranged_file.index((index0, 0))
    index1 = (1000 + index0) % len(file)
    value1 = arranged_file[index1][1]
    index2 = (2000 + index0) % len(file)
    value2 = arranged_file[index2][1]
    index3 = (3000 + index0) % len(file)
    value3 = arranged_file[index3][1]
    print(value1 + value2 + value3)



def run_part_2():
    lines = get_input(20).splitlines()
    # lines = get_example()
    parsed_file = [line * 811589153 for line in parse_file(lines)]
    index0 = parsed_file.index(0)
    file = list(enumerate(parsed_file))
    arranged_file = file.copy()
    for i in range(10):
        for f in file:
            index = arranged_file.index(f)
            arranged_file.pop(index)
            new_index = (index + f[1])
            calculated_index = new_index % len(arranged_file)
            arranged_file.insert(calculated_index, f)
            pass
        pass
    index0 = arranged_file.index((index0, 0))
    index1 = (1000 + index0) % len(file)
    value1 = arranged_file[index1][1]
    index2 = (2000 + index0) % len(file)
    value2 = arranged_file[index2][1]
    index3 = (3000 + index0) % len(file)
    value3 = arranged_file[index3][1]
    print(value1 + value2 + value3)


run_part_1()
run_part_2()
