from aoc import get_input

lines = get_input(1).splitlines()

calibrationLine = []
summed = 0
for line in lines:
    neo = line.replace("one", "o1ne").replace("two", "t2wo").replace("three", "th3ree").replace("four", "fo4ur").replace("five", "fi5ve").replace("six", "s6ix").replace("seven", "sev7en").replace("eight", "ei8ght").replace("nine", "ni9ne")
    start = -1
    for char in neo:
        if start == -1 and char.isdigit():
            start = int(char)
            break
    last = -1
    for char in neo[::-1]:
        if last == -1 and char.isdigit():
            last = int(char)
            break
    lineNumber = (start * 10) + last
    calibrationLine.append(lineNumber)
    summed += lineNumber

print(summed)
