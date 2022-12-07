from aoc import get_input

lines = get_input(7).splitlines()

# lines = ["$ cd /",
#          "$ ls",
#          "dir a",
#          "14848514 b.txt",
#          "8504156 c.dat",
#          "dir d",
#          "$ cd a",
#          "$ ls",
#          "dir e",
#          "29116 f",
#          "2557 g",
#          "62596 h.lst",
#          "$ cd e",
#          "$ ls",
#          "584 i",
#          "$ cd ..",
#          "$ cd ..",
#          "$ cd d",
#          "$ ls",
#          "4060174 j",
#          "8033020 d.log",
#          "5626152 d.ext",
#          "7214296 k",
#          ]


commands = [i for i in enumerate(lines) if i[1].startswith("$")]


def func(i: int):
    start = commands[i][0]
    end = commands[i + 1][0] if i != len(commands) - 1 else len(lines)
    return lines[start:end]


commands2 = [func(i[0]) for i in enumerate(commands)]

folders = {}
current = ''
for command in commands2:
    if command[0].startswith("$ cd /"):
        current = ''
    elif command[0].startswith("$ cd .."):
        current = current[0:current.rfind("/")]
    elif command[0].startswith("$ cd "):
        current = f"{current}/{command[0][5:]}"
    elif command[0].startswith("$ ls"):
        result = command[1:]
        file_sum = sum([int(file.split(" ")[0]) for file in result if not file.startswith("dir")])
        for key in folders.keys():
            if current.startswith(key):
                folders.update({key: folders.get(key) + file_sum})
        folders.update({current: file_sum})

print(sum([folder for folder in folders.values() if folder <= 100000]))

space_free = 70000000 - folders.get("")
space_needed = 30000000 - space_free

print(min([folder for folder in folders.values() if folder >= space_needed]))
