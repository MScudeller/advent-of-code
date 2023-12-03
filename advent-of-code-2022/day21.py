import re

import numpy as np

from aoc import get_input


def get_example():
    return [
        "root: pppw + sjmn",
        "dbpl: 5",
        "cczh: sllz + lgvd",
        "zczc: 2",
        "ptdq: humn - dvpt",
        "dvpt: 3",
        "lfqf: 4",
        "humn: 5",
        "ljgn: 2",
        "sjmn: drzm * dbpl",
        "sllz: 4",
        "pppw: cczh / lfqf",
        "lgvd: ljgn * ptdq",
        "drzm: hmdt - zczc",
        "hmdt: 32",
    ]


def parse_monkeys(lines):
    return {line[:4]: line[6:] for line in lines}


def calc1(name: str, monkeys: dict[str]):
    value: str = monkeys[name]
    if value.isnumeric():
        return int(value)
    monkey1 = calc1(value[:4], monkeys)
    operation = value[5:6]
    monkey2 = calc1(value[7:11], monkeys)
    return eval(f"{monkey1}{operation}{monkey2}")


def run_part_1():
    lines = get_input(21).splitlines()
    # lines = get_example()
    monkeys = parse_monkeys(lines)
    root = calc1("root", monkeys)
    print(root)
    pass


def calc2(name: str, monkeys: dict[str]):
    if name == "humn":
        return "x"
    value: str = monkeys[name]
    if value.isnumeric():
        return str(int(value))
    monkey1_name = value[:4]
    monkey1 = calc2(monkey1_name, monkeys)
    operation = "=" if name == "root" else value[5:6]
    monkey2_name = value[7:11]
    monkey2 = calc2(monkey2_name, monkeys)
    if monkey1.isnumeric() and monkey2.isnumeric():
        return str(int(eval(f"{monkey1}{operation}{monkey2}")))
    return f"({monkey1}{operation}{monkey2})"


def run_part_2():
    lines = get_input(21).splitlines()
    # lines = get_example()
    monkeys = parse_monkeys(lines)
    root = calc2("root", monkeys)
    print(root)
    pass


run_part_1()
run_part_2()
