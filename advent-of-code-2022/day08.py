from aoc import get_input

lines = get_input(8).splitlines()


# lines = ['30373',
#          '25512',
#          '65332',
#          '33549',
#          '35390',
#          ]


def check_tree_visibility(x: int, y: int):
    if x == 0 or y == 0 or x == (len(lines) - 1) or y == (len(lines[0]) - 1):
        return True
    tree_height = lines[x][y]

    visible = True
    for i in range(x):
        test_height = lines[i][y]
        if tree_height <= test_height:
            visible = False
            break

    if visible:
        return True

    visible = True
    for i in range(len(lines) - 1, x, -1):
        test_height = lines[i][y]
        if tree_height <= test_height:
            visible = False
            break

    if visible:
        return True

    visible = True
    for j in range(y):
        test_height = lines[x][j]
        if tree_height <= test_height:
            visible = False
            break

    if visible:
        return True

    visible = True
    for j in range(len(lines[0]) - 1, y, -1):
        test_height = lines[x][j]
        if tree_height <= test_height:
            visible = False
            break

    return visible


foo = []
for k in enumerate(lines):
    for m in enumerate(k[1]):
        if check_tree_visibility(k[0], m[0]):
            foo.append(1)

print(sum(foo))


def count_tree_visibility(x: int, y: int):
    if x == 0 or y == 0 or x == (len(lines) - 1) or y == (len(lines[0]) - 1):
        return 0
    tree_height = lines[x][y]
    score = 1
    tree_count = 0  # up
    for i in range(x - 1, -1, -1):
        test_height = lines[i][y]
        if tree_height <= test_height:
            tree_count = tree_count + 1
            break
        tree_count = tree_count + 1

    score = score * tree_count

    tree_count = 0  # down
    for i in range(x + 1, len(lines)):
        test_height = lines[i][y]
        if tree_height <= test_height:
            tree_count = tree_count + 1
            break
        tree_count = tree_count + 1

    score = score * tree_count

    tree_count = 0  # left
    for j in range(y - 1, -1, -1):
        test_height = lines[x][j]
        if tree_height <= test_height:
            tree_count = tree_count + 1
            break
        tree_count = tree_count + 1

    score = score * tree_count

    tree_count = 0  # right
    for j in range(y + 1, len(lines[0])):
        test_height = lines[x][j]
        if tree_height <= test_height:
            tree_count = tree_count + 1
            break
        tree_count = tree_count + 1

    score = score * tree_count
    return score


bar = []
for k in enumerate(lines):
    for m in enumerate(k[1]):
        bar.append(count_tree_visibility(k[0], m[0]))

print(max(bar))
pass
