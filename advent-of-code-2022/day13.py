import functools

from aoc import get_input


def get_example():
    return [
        "[1, 1, 3, 1, 1]",
        "[1, 1, 5, 1, 1]",
        "",
        "[[1], [2, 3, 4]]",
        "[[1], 4]",
        "",
        "[9]",
        "[[8, 7, 6]]",
        "",
        "[[4, 4], 4, 4]",
        "[[4, 4], 4, 4, 4]",
        "",
        "[7, 7, 7, 7]",
        "[7, 7, 7]",
        "",
        "[]",
        "[3]",
        "",
        "[[[]]]",
        "[[]]",
        "",
        "[1, [2, [3, [4, [5, 6, 7]]]], 8, 9]",
        "[1, [2, [3, [4, [5, 6, 0]]]], 8, 9]",
    ]


def parse_line(line, pointer):
    if not line.startswith("["):
        raise "foo"
    pointer += 1
    signal = []
    value = 0
    while pointer < len(line):
        if line[pointer] == "[":
            s, pointer = parse_line(line, pointer)
            signal.append(s)
        if line[pointer] == "]":
            return signal, pointer
        if "0" <= line[pointer] <= "9":
            value = (value * 10) + int(line[pointer])
            if not ("0" <= line[pointer + 1] <= "9"):
                signal.append(value)
                value = 0
        pointer += 1
    return signal, pointer


def parse_signal(lines):
    signals_amount = (len(lines) + 1) // 3
    signals = []
    for i in range(signals_amount):
        first = eval(lines[i * 3])
        second = eval(lines[i * 3 + 1])
        signals.append((first, second))
    return signals


def compare(x, y):
    # print(f"Compare {x} vs {y}")
    if isinstance(x, int) and isinstance(y, int):
        if x < y:
            # print("Left side is smaller, so inputs are in the right order")
            return True
        elif x > y:
            # print("Right side is smaller, so inputs are not in the right order")
            return False
        return None
    elif isinstance(x, list) and isinstance(y, list):
        mini = min(len(x), len(y))
        for i in range(mini):
            r = compare(x[i], y[i])
            if r is None:
                continue
            else:
                return r
        if len(x) < len(y):
            # print("Left side ran out of items, so inputs are in the right order")
            return True
        elif len(x) > len(y):
            # print("Right side ran out of items, so inputs are not in the right order")
            return False

    elif isinstance(x, int):
        return compare([x], y)
    else:
        return compare(x, [y])


def run_part_1():
    lines = get_input(13).splitlines()
    # lines = get_example()
    parsed = parse_signal(lines)

    signal_ = [i + 1 for i, signal in enumerate(parsed) if compare(signal[0], signal[1])]
    print(sum(signal_))
    pass


def sort_compare(x, y):
    # print(f"Compare {x} vs {y}")
    if isinstance(x, int) and isinstance(y, int):
        if x < y:
            # print("Left side is smaller, so inputs are in the right order")
            return 1
        elif x > y:
            # print("Right side is smaller, so inputs are not in the right order")
            return -1
        return 0
    elif isinstance(x, list) and isinstance(y, list):
        mini = min(len(x), len(y))
        for i in range(mini):
            r = sort_compare(x[i], y[i])
            if r == 0:
                continue
            else:
                return r
        if len(x) < len(y):
            # print("Left side ran out of items, so inputs are in the right order")
            return 1
        elif len(x) > len(y):
            # print("Right side ran out of items, so inputs are not in the right order")
            return -1
        return 0

    elif isinstance(x, int):
        return sort_compare([x], y)
    else:
        return sort_compare(x, [y])


def run_part_2():
    lines = get_input(13).splitlines()
    # lines = get_example()
    signals = [eval(signal) for signal in lines if signal != ""]
    first = [[2]]
    second = [[6]]
    signals.extend([first, second])
    signals.sort(key=functools.cmp_to_key(sort_compare), reverse=True)
    foo = signals.index(first) + 1
    bar = signals.index(second) + 1
    print(foo * bar)
    pass


run_part_1()
run_part_2()
