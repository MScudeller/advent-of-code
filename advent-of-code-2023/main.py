file = open("inputs/day01", "r")
lines = file.readlines()

elves = []
elf = 0
for line in lines:
    if line == "\n":
        elves.append(elf)
        elf = 0
    else:
        elf += int(line)


foo = list(zip(range(1, len(elves)-1), elves))

bar = foo.sort(reverse=True, key=lambda e: e[1])

print(foo[0][1])
print(foo[0][1]+foo[1][1]+foo[2][1])
