from aoc import get_input

# inp = """Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
# Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
# Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
# Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
# Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
# Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11"""

day_input = get_input(4)
lines = day_input.splitlines()


def parse_card(line):
    card_split = line.split(": ")
    card_name = card_split[0].split("d ")[1].strip()
    card_numbers = card_split[1]
    split = card_numbers.split(" | ")
    winning_numbers = [int(s) for s in split[0].split(" ") if s.strip() != ""]
    numbers = [int(s) for s in split[1].split(" ") if s.strip() != ""]
    return int(card_name), winning_numbers, numbers


def get_worth(card):
    lucky_numbers = [c for c in card[2] if c in card[1]]
    points = len(lucky_numbers)
    return int(pow(2, points - 1))


print(sum([get_worth(parse_card(line)) for line in lines]))

foo = [1 for line in lines]


def get_worth2(card):
    lucky_numbers = [c for c in card[2] if c in card[1]]
    points = len(lucky_numbers)
    qtd = foo[card[0]-1]
    for i in range(points):
        foo[card[0] + i] = foo[card[0] + i] + qtd
    return


for line in lines:
    get_worth2(parse_card(line))

print(sum(foo))
