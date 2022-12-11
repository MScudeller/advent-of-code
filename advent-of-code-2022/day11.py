import math

from aoc import get_input


def get_example():
    return [
        "Monkey 0:",
        "  Starting items: 79, 98",
        "  Operation: new = old * 19",
        "  Test: divisible by 23",
        "    If true: throw to monkey 2",
        "    If false: throw to monkey 3",
        "",
        "Monkey 1:",
        "  Starting items: 54, 65, 75, 74",
        "  Operation: new = old + 6",
        "  Test: divisible by 19",
        "    If true: throw to monkey 2",
        "    If false: throw to monkey 0",
        "",
        "Monkey 2:",
        "  Starting items: 79, 60, 97",
        "  Operation: new = old * old",
        "  Test: divisible by 13",
        "    If true: throw to monkey 1",
        "    If false: throw to monkey 3",
        "",
        "Monkey 3:",
        "  Starting items: 74",
        "  Operation: new = old + 3",
        "  Test: divisible by 17",
        "    If true: throw to monkey 0",
        "    If false: throw to monkey 1",
    ]


def parse_monkeys(lines):
    monkeys = []
    for i in range(int((len(lines) + 1) / 7)):
        starting_line = i * 7
        starting_items = [int(item) for item in lines[starting_line + 1][18:].split(", ")]
        operation = (lambda x, y: x * y) if lines[starting_line + 2][23:24] == "*" else (lambda x, y: x + y)
        operation_amount = lines[starting_line + 2][25:]
        test = int(lines[starting_line + 3][21:])
        test_true = int(lines[starting_line + 4][29:])
        test_false = int(lines[starting_line + 5][30:])
        monkeys.append([starting_items, operation, operation_amount, test, test_true, test_false, 0])
    return monkeys


def simulate(monkeys, stop, worry_modifier):
    for j in range(stop):
        for m in monkeys:
            for item in m[0]:
                value = item if m[2] == "old" else int(m[2])
                operation = m[1]
                result = operation(item, value)
                result = worry_modifier(result)
                if (result % m[3]) == 0:
                    monkeys[m[4]][0].append(result)
                else:
                    monkeys[m[5]][0].append(result)
                m[6] += 1
            m[0].clear()
    active = [m[6] for m in monkeys]
    active.sort(reverse=True)
    return active[0] * active[1]


def run():
    lines = get_input(11).splitlines()
    # lines = get_example()
    monkeys = parse_monkeys(lines)
    print(simulate(monkeys, 20, lambda x: x // 3))
    monkeys = parse_monkeys(lines)
    mmc = math.prod(m[3] for m in monkeys)
    print(simulate(monkeys, 10000, lambda x: x % mmc))


run()
