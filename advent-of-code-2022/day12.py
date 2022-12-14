import os

import matplotlib.pyplot as plt
import numpy as np
from colorama import Fore

from aoc import get_input


def get_example():
    return [
        "Sabqponm",
        "abcryxxl",
        "accszExk",
        "acctuvwj",
        "abdefghi",
    ]


def parse_terrain(lines: list[str]):
    start = ([line[0] for line in enumerate(lines) if "S" in line[1]][0], 0)
    end_x = [line[0] for line in enumerate(lines) if "E" in line[1]][0]
    end_y = [char[0] for char in enumerate(lines[end_x]) if "E" in char[1]][0]
    return lines, start, (end_x, end_y)


def run_part_1():
    lines = get_input(12).splitlines()
    # lines = get_example()
    terrain, start, end = parse_terrain(lines)
    visited = np.zeros([len(terrain), len(terrain[0])], dtype=int)
    queue = [(start[0], start[1], 0)]
    while len(queue) != 0:
        current_x, current_y, dist = queue.pop(0)
        visited[current_x][current_y] = 1
        if current_x == end[0] and current_y == end[1]:
            print(dist)
            break
        all_next = [(current_x + 1, current_y, dist + 1),
                    (current_x, current_y + 1, dist + 1),
                    (current_x - 1, current_y, dist + 1),
                    (current_x, current_y - 1, dist + 1)]
        current_height = parse_height(current_x, current_y, terrain)
        possible_next = [node for node in all_next if filter_next(current_height, node, terrain, visited, queue)]
        queue.extend(possible_next)
        print_terrain(terrain, visited, queue)


def parse_height(current_x, current_y, terrain):
    if terrain[current_x][current_y] == "E":
        current_height = "z"
    elif terrain[current_x][current_y] == "S":
        current_height = "a"
    else:
        current_height = terrain[current_x][current_y]
    return current_height


def filter_next(current_height, node, terrain, visited, queue):
    inside_bounds = 0 <= node[0] < len(terrain) and 0 <= node[1] < len(terrain[0])
    if not inside_bounds:
        return False
    not_visited = visited[node[0]][node[1]] == 0
    node_height = parse_height(node[0], node[1], terrain)
    not_higher = ord(current_height) + 1 >= ord(node_height)
    not_in_queue = not (node[0], node[1]) in [(q[0], q[1]) for q in queue]
    return inside_bounds and not_higher and not_visited and not_in_queue

number = 0
def print_terrain(terrain, visited, queue):
    global number
    foo = [[ord(c) - ord("a") for c in line] for line in terrain]
    bar = np.add(foo, visited * 10)
    np.clip(bar, 0, 30)
    fig, ax = plt.subplots()
    plt.axis("off")
    im = ax.imshow(bar)
    fig.tight_layout()
    plt.savefig(f"images/{number:04d}.png", bbox_inches="tight")
    plt.close(fig)
    number += 1


def get_position_color(terrain: list[str], visited, queue, x, y):
    letter = terrain[x][y]
    visited = visited[x][y]
    in_queue = (x, y) in [(q[0], q[1]) for q in queue]
    if visited == 1:
        color = Fore.GREEN
    elif in_queue:
        color = Fore.RED
    else:
        color = Fore.WHITE
    return color + letter


run_part_1()

def run_part_2():
    lines = get_input(12).splitlines()
    # lines = get_example()
    terrain, start, end = parse_terrain(lines)
    visited = np.zeros([len(terrain), len(terrain[0])], dtype=int)
    queue = [(end[0], end[1], 0)]
    while len(queue) != 0:
        current_x, current_y, dist = queue.pop(0)
        visited[current_x][current_y] = 1
        current_height = parse_height(current_x, current_y, terrain)
        if current_height == "a":
            print(dist)
            break
        all_next = [(current_x + 1, current_y, dist + 1),
                    (current_x, current_y + 1, dist + 1),
                    (current_x - 1, current_y, dist + 1),
                    (current_x, current_y - 1, dist + 1)]
        possible_next = [node for node in all_next if filter_next2(current_height, node, terrain, visited, queue)]
        queue.extend(possible_next)
        # print_terrain(terrain, visited, queue)


def filter_next2(current_height, node, terrain, visited, queue):
    inside_bounds = 0 <= node[0] < len(terrain) and 0 <= node[1] < len(terrain[0])
    if not inside_bounds:
        return False
    not_visited = visited[node[0]][node[1]] == 0
    node_height = parse_height(node[0], node[1], terrain)
    not_higher = ord(current_height) <= ord(node_height) + 1
    not_in_queue = not (node[0], node[1]) in [(q[0], q[1]) for q in queue]
    return inside_bounds and not_higher and not_visited and not_in_queue


run_part_2()
