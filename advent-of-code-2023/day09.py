from aoc import get_input

test_input = """0 3 6 9 12 15
1 3 6 10 15 21
10 13 16 21 30 45"""

day_input = get_input(9)
lines = day_input.splitlines()


def parse_history(line):
    return [int(s) for s in line.split(" ")]


def get_diff_line(history):
    return [history[n + 1] - history[n] for n in range(len(history) - 1)]


def predict(history):
    predict_table = [history]
    for i in range(len(history)):
        diff_line = get_diff_line(predict_table[-1])
        predict_table.append(diff_line)
        if all([n == 0 for n in diff_line]):
            break

    predict_table[-1].append(0)
    for i in range(len(predict_table) - 1)[::-1]:
        last_delta = predict_table[i+1][-1]
        last = predict_table[i][-1]
        predict_table[i].append(last + last_delta)
        first_delta = predict_table[i+1][0]
        first = predict_table[i][0]
        predict_table[i].insert(0, first - first_delta)

    return predict_table[0][0], predict_table[0][-1]


def part(histories):
    predicted = [predict(h) for h in histories]
    return sum(p[0] for p in predicted), sum(p[1] for p in predicted)


print(part([parse_history(h) for h in test_input.splitlines()]))
print(part([parse_history(h) for h in day_input.splitlines()]))
