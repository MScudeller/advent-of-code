from aoc import get_input

lines = get_input(1).splitlines()


def get_first_digit(line: str):
    for char in line:
        if char.isdigit():
            return int(char)


def get_calibration_value(line):
    return (get_first_digit(line) * 10) + get_first_digit(line[::-1])


print(sum([get_calibration_value(line) for line in lines]))


def add_spelled_digits(line):
    return (line.replace("one", "o1e")
            .replace("two", "t2o")
            .replace("three", "t3e")
            .replace("four", "f4r")
            .replace("five", "f5e")
            .replace("six", "s6x")
            .replace("seven", "s7n")
            .replace("eight", "e8t")
            .replace("nine", "n9e"))


print(sum([get_calibration_value(add_spelled_digits(line)) for line in lines]))
