import re

import numpy as np

from aoc import get_input


def get_example():
    return [
        "Blueprint 1: Each ore robot costs 4 ore. Each clay robot costs 2 ore. Each obsidian robot costs 3 ore and 14 clay. Each geode robot costs 2 ore and 7 obsidian.",
        "Blueprint 2: Each ore robot costs 2 ore. Each clay robot costs 3 ore. Each obsidian robot costs 3 ore and 8 clay. Each geode robot costs 3 ore and 12 obsidian.",
    ]


def parse_blueprints(lines):
    return [parse_blueprint(line) for line in lines]


def parse_blueprint(line):
    ident, ore_robot_ore_cost, clay_robot_ore_cost, obsidian_robot_ore_cost, obsidian_robot_clay_cost, geode_robot_ore_cost, geode_robot_obsidian_cost = re.search(
        r"Blueprint (\d*): Each ore robot costs (\d*) ore. Each clay robot costs (\d*) ore. Each obsidian robot costs (\d*) ore and (\d*) clay. Each geode robot costs (\d*) ore and (\d*) obsidian.",
        line).groups()
    return (int(ident), int(ore_robot_ore_cost), int(clay_robot_ore_cost), int(obsidian_robot_ore_cost), int(obsidian_robot_clay_cost), int(geode_robot_ore_cost), int(geode_robot_obsidian_cost))


def run_part_1():
    # lines = get_input(19).splitlines()
    lines = get_example()
    blueprints = parse_blueprints(lines)
    instructions_list = [ # example
        ["c", "c", "c", "b", "c", "b"],
        ["o", "o", "c", "c", "c", "c", "c", "b", "c", "b", "b", "b", "c", "b", "g", "b", "g", "b", "g", "b"],
    ]
    # instructions_list = [ # input
    #     ["o", "o", "o", "c", "c", "c", "c", "c", "c", "c", "b", "c", "b", "c", "b", "c", "g"],
    #     #["o", "o", "c", "c", "c", "c", "c", "b", "c", "b", "b", "b", "c", "b", "g", "b", "g", "b", "g", "b"],
    # ]
    for i in range(len(instructions_list)):
        instructions = instructions_list[i]
        blueprint = blueprints[i]
        should_print = i == 0
        quality_level = simulate(blueprint, instructions, should_print)


def simulate(blueprint, instructions, should_print):
    ident, ore_robot_ore_cost, clay_robot_ore_cost, obsidian_robot_ore_cost, obsidian_robot_clay_cost, geode_robot_ore_cost, geode_robot_obsidian_cost = blueprint
    inventory = [0, 0, 0, 0]
    robots = [1, 0, 0, 0]
    building_robot = [0, 0, 0, 0]
    instructions_index = 0
    for m in range(1, 25):
        log(should_print, f"== minute {m} ==")
        instruction = instructions[instructions_index] if instructions_index < len(instructions) else "g"
        log(should_print, f"will try to construct {instruction}")
        if instruction == "o":
            if inventory[0] >= ore_robot_ore_cost:
                inventory[0] -= ore_robot_ore_cost
                building_robot[0] += 1
                log(should_print, f"spent ore:{ore_robot_ore_cost} to produce 1 ore robot")
                instructions_index += 1
            else:
                log(should_print, f"need {ore_robot_ore_cost} ore.")
        elif instruction == "c":
            if inventory[0] >= clay_robot_ore_cost:
                inventory[0] -= clay_robot_ore_cost
                building_robot[1] += 1
                log(should_print, f"spent ore:{clay_robot_ore_cost} to produce 1 clay robot")
                instructions_index += 1
            else:
                log(should_print, f"need {clay_robot_ore_cost} ore.")
        elif instruction == "b":
            if inventory[0] >= obsidian_robot_ore_cost and inventory[1] >= obsidian_robot_clay_cost:
                inventory[0] -= obsidian_robot_ore_cost
                inventory[1] -= obsidian_robot_clay_cost
                building_robot[2] += 1
                log(should_print,
                    f"spent ore:{obsidian_robot_ore_cost}, clay:{obsidian_robot_clay_cost} to produce 1 obsidian robot")
                instructions_index += 1
            else:
                log(should_print, f"need {obsidian_robot_ore_cost} ore and {obsidian_robot_clay_cost} clay.")
        elif instruction == "g":
            if inventory[0] >= geode_robot_ore_cost and inventory[2] >= geode_robot_obsidian_cost:
                inventory[0] -= geode_robot_ore_cost
                inventory[2] -= geode_robot_obsidian_cost
                building_robot[3] += 1
                log(should_print,
                    f"spent ore:{geode_robot_ore_cost}, obsidian:{geode_robot_obsidian_cost} to produce 1 geode robot")
                instructions_index += 1
            else:
                log(should_print, f"need {geode_robot_ore_cost} ore and {geode_robot_obsidian_cost} obsidian.")
        inventory = np.add(inventory, robots)
        log(should_print, f"{robots[0]} ore robots and {inventory[0]} ore")
        log(should_print, f"{robots[1]} clay robots and {inventory[1]} clay")
        log(should_print, f"{robots[2]} obsidian robots and {inventory[2]} obsidian")
        log(should_print, f"{robots[3]} geode robots and {inventory[3]} geode")
        robots = np.add(robots, building_robot)
        building_robot = [0, 0, 0, 0]
        log(should_print, "\n")
    return ident * inventory[3]


def log(should_print, msg):
    if should_print:
        print(msg)


def run_part_2():
    # lines = get_input(19).splitlines()
    lines = get_example()
    blueprints = parse_blueprints(lines)


run_part_1()
run_part_2()
