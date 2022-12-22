from aoc import get_input


def get_example():
    return [
        "        ...#",
        "        .#..",
        "        #...",
        "        ....",
        "...#.......#",
        "........#...",
        "..#....#....",
        "..........#.",
        "        ...#....",
        "        .....#..",
        "        .#......",
        "        ......#.",
        "",
        "10R5L5R10L4R5L5",
    ]


def parse_notes(lines: list[str]) -> (list[list[str]], str):
    return [list(line) for line in lines[:len(lines) - 2]], lines[-1]


def next_instruction(instructions: str, start: int) -> (str | int, int):
    first_digit = instructions[start:start + 1]
    if first_digit.isalpha():
        return first_digit, start + 1
    second_digit = instructions[start + 1:start + 2]
    if second_digit.isdigit():
        return int(first_digit + second_digit), start + 2
    return int(first_digit), start + 1


def follow_instructions(chart, instructions):
    y = 0
    x = chart[y].index(".")
    direction = 0  # right
    index = 0
    while index < len(instructions):
        instruction, index = next_instruction(instructions, index)
        if instruction == "R":
            direction = (direction + 1) % 4
        elif instruction == "L":
            direction = (direction - 1) % 4
        else:
            if direction == 0:  # right
                row = [c for c in chart[y] if c != " "]
                row_offset = chart[y].index(row[0])
                row_x = x - row_offset
                for i in range(instruction):
                    right_x = (row_x + 1) % len(row)
                    if row[right_x] == "#":
                        break
                    row_x = right_x
                x = row_offset + row_x
            elif direction == 1:  # down
                full_column = [chart[i][x] if x < len(chart[i]) else " " for i in range(len(chart))]
                column = [c for c in full_column if c != " "]
                column_offset = full_column.index(column[0])
                column_y = y - column_offset
                for i in range(instruction):
                    down_x = (column_y + 1) % len(column)
                    if column[down_x] == "#":
                        break
                    column_y = down_x
                y = column_offset + column_y
            elif direction == 2:  # left
                row = [c for c in chart[y] if c != " "]
                row_offset = chart[y].index(row[0])
                row_x = x - row_offset
                for i in range(instruction):
                    left_x = (row_x - 1) % len(row)
                    if row[left_x] == "#":
                        break
                    row_x = left_x
                x = row_offset + row_x
            else:  # up
                full_column = [chart[i][x] if x < len(chart[i]) else " " for i in range(len(chart))]
                column = [c for c in full_column if c != " "]
                column_offset = full_column.index(column[0])
                column_y = y - column_offset
                for i in range(instruction):
                    down_x = (column_y - 1) % len(column)
                    if column[down_x] == "#":
                        break
                    column_y = down_x
                y = column_offset + column_y

    return x, y, direction


def run_part_1():
    lines = get_input(22).splitlines()
    # lines = get_example()
    chart, instructions = parse_notes(lines)
    x, y, direction = follow_instructions(chart, instructions)
    print(1000 * (y + 1) + 4 * (x + 1) + direction)


def run_part_2():
    # lines = get_input(22).splitlines()
    lines = get_example()
    parsed_file = parse_notes(lines)


run_part_1()
run_part_2()
