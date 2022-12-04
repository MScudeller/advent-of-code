file = open("inputs/day03", "r")
lines = file.readlines()


def split_compartments(line: str) -> (str, str):
    half_length = len(line) // 2
    return line[:half_length], line[half_length:]


def get_common_item(rucksack: (str, str)):
    intersection = set(rucksack[0]).intersection(set(rucksack[1]))
    intersection.discard("\n")
    return list(intersection)[0]


def to_priority(item: str):
    priority = ord(item) - 96
    return priority if priority > 0 else priority + 58


def get_badge(group: (str, str, str)):
    intersection = set(group[0]).intersection(set(group[1])).intersection(set(group[2]))
    intersection.discard("\n")
    return list(intersection)[0]


print(sum([to_priority(get_common_item(split_compartments(line))) for line in lines]))
print(sum([to_priority(get_badge(lines[i:i + 3])) for i in range(0, len(lines), 3)]))
