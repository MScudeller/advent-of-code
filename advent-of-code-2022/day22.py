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


def follow_instructions_cube(chart, instructions):
    chunk_size = 50
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
            for i in range(instruction):
                if direction == 0:  # right
                    right_x = (x + 1)
                    right_y = y
                    right_direction = direction
                    if right_x == len(chart[y]):
                        # if out 2R: in 5L
                        if x // chunk_size == 2 and y // chunk_size == 0:
                            right_x = x - chunk_size
                            right_y = chunk_size * 3 - 1 - y
                            right_direction = 2
                        # if out 3R: in 2U
                        if x // chunk_size == 1 and y // chunk_size == 1:
                            right_x = y + chunk_size
                            right_y = chunk_size - 1
                            right_direction = 3
                        # if out 5R: in 2L
                        if x // chunk_size == 1 and y // chunk_size == 2:
                            right_x = x + chunk_size
                            right_y = chunk_size - 1 - (y - 2 * chunk_size)  # 0 -> 49, 49 -> 0
                            right_direction = 2
                        # if out 6R: in 5U
                        pass
                    if chart[right_y][right_x] == "#":
                        break
                    x = right_x
                    y = right_y
                    direction = right_direction
                elif direction == 1:  # down
                    down_x = x
                    down_y = y + 1
                    down_direction = direction
                    if down_y == len(chart):
                        # compute next position
                        pass
                    if chart[down_y][down_x] == "#":
                        break
                    y = down_y
                    x = down_x
                    direction = down_direction
                elif direction == 2:  # left
                    left_x = (x - 1)
                    left_y = y
                    left_direction = direction
                    if left_x == -1 or chart[left_y][left_x] == " ":
                        # compute next position
                        pass
                    if chart[left_y][left_x] == "#":
                        break
                    x = left_x
                    y = left_y
                    direction = left_direction
                else:  # 3 up
                    up_x = x
                    up_y = y - 1
                    up_direction = direction
                    if up_y == -1 or chart[up_y][up_x] == " ":
                        # compute next position
                        pass
                    if chart[up_y][up_x] == "#":
                        break
                    y = up_y
                    x = up_x
                    direction = up_direction

    return x, y, direction


def run_part_2():
    lines = get_input(22).splitlines()
    # lines = get_example()
    chart, instructions = parse_notes(lines)
    x, y, direction = follow_instructions_cube(chart, instructions)
    print(1000 * (y + 1) + 4 * (x + 1) + direction)



run_part_1()
run_part_2()
