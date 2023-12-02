from aoc import get_input

lines = get_input(2).splitlines()


def parse_cubes(check):
    r, g, b = 0, 0, 0
    for cube in check.split(", "):
        value, color = cube.split(" ")
        if color == "red":
            r = int(value)
        if color == "green":
            g = int(value)
        if color == "blue":
            b = int(value)
    return r, g, b


def parse_line(line):
    game = line.split(": ")
    return int(game[0].split(" ")[1]), [parse_cubes(check) for check in game[1].split("; ")]


def check_game(checks):
    max_r, max_g, max_b = 12, 13, 14
    return (not [check[0] for check in checks if check[0] > max_r]
            and not [check[1] for check in checks if check[1] > max_g]
            and not [check[2] for check in checks if check[2] > max_b])


games = [parse_line(line) for line in lines]

print(sum([game_number for game_number, checks in games if check_game(checks)]))


def get_power(checks):
    max_r, max_g, max_b = 0, 0, 0
    for check in checks:
        if check[0] > max_r:
            max_r = check[0]
        if check[1] > max_g:
            max_g = check[1]
        if check[2] > max_b:
            max_b = check[2]
    return max_r * max_g * max_b


print(sum([get_power(checks) for _, checks in games]))
