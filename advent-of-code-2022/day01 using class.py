from aoc import get_input


class Elf:
    number: int
    caloriesCarried: int = 0

    def __init__(self, number):
        self.number = number


lines = get_input(1).splitlines()
elves = []
elf = Elf(0)
for line in lines:
    if line == "":
        elves.append(elf)
        elf = Elf(elf.number + 1)
    else:
        elf.caloriesCarried += int(line)
elves.insert()
elves.sort(reverse=True, key=lambda e: e.caloriesCarried)

print(elves[0].caloriesCarried)
print(elves[0].caloriesCarried + elves[1].caloriesCarried + elves[2].caloriesCarried)
