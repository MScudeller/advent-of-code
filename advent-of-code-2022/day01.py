from aoc import get_input

lines = get_input(1).splitlines()

elves = []
elf = 0
for line in lines:
    if line == "":
        elves.append(elf)
        elf = 0
    else:
        elf += int(line)


elves = list(enumerate(elves, start=1))
elves.sort(reverse=True, key=lambda e: e[1])

print(elves[0][1])
print(elves[0][1]+elves[1][1]+elves[2][1])
