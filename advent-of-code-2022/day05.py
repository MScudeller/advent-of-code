from aoc import get_input
import copy

lines = get_input(5).splitlines()

initialState = lines[:8]


def get_crate(stack: int, position: int) -> str:
    return initialState[8 - position][stack * 4 - 3]


initial_stacks = [[get_crate(i, j) for j in range(1, 9) if get_crate(i, j) != ' '] for i in range(1, 10)]
movements = lines[10:]


def run_crate_mover_movement(move: str):
    offset = 1 if len(move) == 19 else 0
    count = int(move[5:6 + offset])
    from_stack = int(move[12 + offset])
    to_stack = int(move[17 + offset])
    for x in range(count):
        crate = stacks1[from_stack-1].pop()
        stacks1[to_stack-1].append(crate)


stacks1 = copy.deepcopy(initial_stacks)
for movement in movements:
    run_crate_mover_movement(movement)

print(''.join([stack[len(stack) - 1] for stack in stacks1]))


def run_crate_mover_9001_movement(move: str):
    offset = 1 if len(move) == 19 else 0
    count = int(move[5:6 + offset])
    from_stack = int(move[12 + offset])
    to_stack = int(move[17 + offset])
    for x in range(count):
        crate = stacks2[from_stack-1].pop(len(stacks2[from_stack-1])-count+x)
        stacks2[to_stack-1].append(crate)


stacks2 = copy.deepcopy(initial_stacks)
for movement in movements:
    run_crate_mover_9001_movement(movement)

print(''.join([stack[len(stack)-1] for stack in stacks2]))
