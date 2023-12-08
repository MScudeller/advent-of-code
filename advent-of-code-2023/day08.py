import math
from aoc import get_input

# day_input = """RL
#
# AAA = (BBB, CCC)
# BBB = (DDD, EEE)
# CCC = (ZZZ, GGG)
# DDD = (DDD, DDD)
# EEE = (EEE, EEE)
# GGG = (GGG, GGG)
# ZZZ = (ZZZ, ZZZ)"""

# day_input = """LLR
#
# AAA = (BBB, BBB)
# BBB = (AAA, ZZZ)
# ZZZ = (ZZZ, ZZZ)"""

# day_input = """LR
#
# 11A = (11B, XXX)
# 11B = (XXX, 11Z)
# 11Z = (11B, XXX)
# 22A = (22B, XXX)
# 22B = (22C, 22C)
# 22C = (22Z, 22Z)
# 22Z = (22B, 22B)
# XXX = (XXX, XXX)"""

day_input = get_input(8)
lines = day_input.splitlines()


def get_next(position, instructions):
    return instructions[position % len(instructions)]


def parse_graph(graph):
    return {line[:3]: (line[:3], line[7:10], line[12:15]) for line in graph}


def count_steps(graph, current, commands, condition):
    i = 0
    while condition(current[0]):
        command = get_next(i, commands)
        current = graph[current[command]]
        i += 1
    return i


parsed_graph = parse_graph(lines[2::])
parsed_command = [int(c) for c in lines[0].replace("L", "1").replace("R", "2")]
print(count_steps(parsed_graph, parsed_graph["AAA"], parsed_command, lambda x: x != "ZZZ"))


def count_steps_ghosted(graph, commands):
    starting = [graph[k] for k in graph.keys() if k.endswith("A")]
    all_counts = [count_steps(graph, c, commands, lambda x: x[-1] != "Z") for c in starting]
    return math.lcm(*all_counts)


print(count_steps_ghosted(parsed_graph, parsed_command))
