from aoc import get_input

input_line = get_input(6).splitlines()[0]


def find_marker(signal: str, size: int):
    for x in range(len(signal)):
        marker = signal[x:x + size]
        if len(set(marker)) == size:
            print(f"marker {marker} found after reading {x + size}")
            break


find_marker(input_line, 4)
find_marker(input_line, 14)
