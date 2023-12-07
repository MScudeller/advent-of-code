from aoc import get_input
from collections import Counter

# day_input = """32T3K 765
# T55J5 684
# KK677 28
# KTJJT 220
# QQQJA 483"""

day_input = get_input(7)
lines = day_input.splitlines()
card_dict_part1 = {"A": 12, "K": 11, "Q": 10, "J": 9, "T": 8, "9": 7, "8": 6, "7": 5, "6": 4, "5": 3, "4": 2, "3": 1, "2": 0 }
card_dict_part2 = {"A": 12, "K": 11, "Q": 10, "T": 9, "9": 8, "8": 7, "7": 6, "6": 5, "5": 4, "4": 3, "3": 2, "2": 1, "J": 0 }


def parse_hand(line: str):
    hand = line.split(" ")
    cards = hand[0]
    bid = int(hand[1])
    return cards, bid


def get_hand_value_calculated(hand: str):
    sorted_hand = sorted(hand[0])
    if sorted_hand[0] == sorted_hand[1] == sorted_hand[2] == sorted_hand[3] == sorted_hand[4]:
        return 6
    if sorted_hand[0] == sorted_hand[1] == sorted_hand[2] == sorted_hand[3] or sorted_hand[1] == sorted_hand[2] == sorted_hand[3] == sorted_hand[4]:
        return 5
    if sorted_hand[0] == sorted_hand[1] and sorted_hand[3] == sorted_hand[4] and (sorted_hand[2] == sorted_hand[1] or sorted_hand[2] == sorted_hand[3]):
        return 4
    if sorted_hand[0] == sorted_hand[1] == sorted_hand[2] or sorted_hand[1] == sorted_hand[2] == sorted_hand[3] or sorted_hand[2] == sorted_hand[3] == sorted_hand[4]:
        return 3
    if ((sorted_hand[0] == sorted_hand[1] and (sorted_hand[2] == sorted_hand[3] or sorted_hand[3] == sorted_hand[4]))
            or (sorted_hand[1] == sorted_hand[2] and sorted_hand[3] == sorted_hand[4])):
        return 2
    if sorted_hand[0] == sorted_hand[1] or sorted_hand[1] == sorted_hand[2] or sorted_hand[2] == sorted_hand[3] or sorted_hand[3] == sorted_hand[4]:
        return 1
    return 0


def get_hand_value1(hand: str):
    counter = Counter(hand[0]).most_common()
    if counter[0][1] == 5:
        return 6
    if counter[0][1] == 4:
        return 5
    if counter[0][1] == 3 and counter[1][1] == 2:
        return 4
    if counter[0][1] == 3:
        return 3
    if counter[0][1] == 2 and counter[1][1] == 2:
        return 2
    if counter[0][1] == 2:
        return 1
    return 0


def get_power(hand):
    return sum([pow(13, i) * card_dict_part1[c] for i, c in enumerate(hand[0][::-1])]) + (get_hand_value_calculated(hand) * pow(13, 5))


hands = [(get_power(hand), hand[0], hand[1]) for hand in [parse_hand(p) for p in lines]]
print(sum([i * f[2] for i, f in enumerate(sorted(hands, key=lambda f: f[0]), start=1)]))


def get_hand_value2(hand: str):
    counter = Counter(hand[0])
    jacks = counter["J"]
    counter["J"] = 0
    most_common_cards = counter.most_common()
    if (most_common_cards[0][1] + jacks) == 5:
        return 6
    if (most_common_cards[0][1] + jacks) == 4:
        return 5
    if (most_common_cards[0][1] + jacks) == 3 and most_common_cards[1][1] == 2 or most_common_cards[0][1] == 3 and (most_common_cards[1][1] + jacks) == 2:
        return 4
    if (most_common_cards[0][1] + jacks) == 3:
        return 3
    if most_common_cards[0][1] == 2 and most_common_cards[1][1] == 2:
        return 2
    if (most_common_cards[0][1] + jacks) == 2:
        return 1
    return 0


def get_power2(hand):
    return sum([pow(13, i) * card_dict_part2[c] for i, c in enumerate(hand[0][::-1])]) + (get_hand_value2(hand) * pow(13, 5))


hands = [(get_power2(hand), hand[0], hand[1]) for hand in [parse_hand(p) for p in lines]]
print(sum([i * f[2] for i, f in enumerate(sorted(hands, key=lambda f: f[0]), start=1)]))
