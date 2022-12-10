from aoc import get_input

lines = get_input(10).splitlines()

# lines = [
#     "addx 15",
#     "addx -11",
#     "addx 6",
#     "addx -3",
#     "addx 5",
#     "addx -1",
#     "addx -8",
#     "addx 13",
#     "addx 4",
#     "noop",
#     "addx -1",
#     "addx 5",
#     "addx -1",
#     "addx 5",
#     "addx -1",
#     "addx 5",
#     "addx -1",
#     "addx 5",
#     "addx -1",
#     "addx -35",
#     "addx 1",
#     "addx 24",
#     "addx -19",
#     "addx 1",
#     "addx 16",
#     "addx -11",
#     "noop",
#     "noop",
#     "addx 21",
#     "addx -15",
#     "noop",
#     "noop",
#     "addx -3",
#     "addx 9",
#     "addx 1",
#     "addx -3",
#     "addx 8",
#     "addx 1",
#     "addx 5",
#     "noop",
#     "noop",
#     "noop",
#     "noop",
#     "noop",
#     "addx -36",
#     "noop",
#     "addx 1",
#     "addx 7",
#     "noop",
#     "noop",
#     "noop",
#     "addx 2",
#     "addx 6",
#     "noop",
#     "noop",
#     "noop",
#     "noop",
#     "noop",
#     "addx 1",
#     "noop",
#     "noop",
#     "addx 7",
#     "addx 1",
#     "noop",
#     "addx -13",
#     "addx 13",
#     "addx 7",
#     "noop",
#     "addx 1",
#     "addx -33",
#     "noop",
#     "noop",
#     "noop",
#     "addx 2",
#     "noop",
#     "noop",
#     "noop",
#     "addx 8",
#     "noop",
#     "addx -1",
#     "addx 2",
#     "addx 1",
#     "noop",
#     "addx 17",
#     "addx -9",
#     "addx 1",
#     "addx 1",
#     "addx -3",
#     "addx 11",
#     "noop",
#     "noop",
#     "addx 1",
#     "noop",
#     "addx 1",
#     "noop",
#     "noop",
#     "addx -13",
#     "addx -19",
#     "addx 1",
#     "addx 3",
#     "addx 26",
#     "addx -30",
#     "addx 12",
#     "addx -1",
#     "addx 3",
#     "addx 1",
#     "noop",
#     "noop",
#     "noop",
#     "addx -9",
#     "addx 18",
#     "addx 1",
#     "addx 2",
#     "noop",
#     "noop",
#     "addx 9",
#     "noop",
#     "noop",
#     "noop",
#     "addx -1",
#     "addx 2",
#     "addx -37",
#     "addx 1",
#     "addx 3",
#     "noop",
#     "addx 15",
#     "addx -21",
#     "addx 22",
#     "addx -6",
#     "addx 1",
#     "noop",
#     "addx 2",
#     "addx 1",
#     "noop",
#     "addx -10",
#     "noop",
#     "noop",
#     "addx 20",
#     "addx 1",
#     "addx 2",
#     "addx 2",
#     "addx -6",
#     "addx -11",
#     "noop",
#     "noop",
#     "noop",
# ]

clock = 1
x = 1
strengths = 0
ctr = [["." for i in range(40)] for j in range(6)]


def draw_on_ctr():
    cycle = clock % 240
    row = int(cycle / 40)
    column = (cycle % 40) - 1
    sprite = (x % 40) - 1
    ctr[row][column] = "🟩" if sprite <= column <= sprite + 2 else "🟫"


def print_on_signal():
    global strengths
    if clock in [20, 60, 100, 140, 180, 220]:
        strength = clock * x
        strengths += strength


for line in lines:
    print_on_signal()
    draw_on_ctr()
    if line == "noop":
        clock += 1
    elif line.startswith("addx"):
        clock += 1
        command = line.split(" ")
        print_on_signal()
        draw_on_ctr()
        x += int(command[1])
        clock += 1

print(strengths)

print("\n".join("".join(pixel) for pixel in ctr))
pass
