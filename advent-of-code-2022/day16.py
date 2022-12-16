import functools

from aoc import get_input


class Valve:
    name: str
    flow_rate: int
    leads_to: list
    is_open: bool

    def __init__(self, name, flow_rate):
        self.name = name
        self.flow_rate = flow_rate
        self.leads_to = []
        self.is_open = False

    def add_tunnel(self, valve):
        if valve not in self.leads_to:
            self.leads_to.append(valve)
            valve.leads_to.append(self)

    def max_value(self, hop: int, pre_visited: set):
        value = 0 if self.is_open or self in pre_visited else (self.flow_rate * hop)
        visited = pre_visited.copy()
        visited.add(self)
        next_valves = [v for v in self.leads_to if v not in visited]
        if len(next_valves) == 0:
            return self, value, hop

        valves = [valve.max_value(hop - 1, visited) for valve in next_valves]
        valves.append((self, value, hop))
        return max(valves, key=lambda v: v[1])


def get_example():
    return [
        "Valve AA has flow rate=0; tunnels lead to valves DD, II, BB",
        "Valve BB has flow rate=13; tunnels lead to valves CC, AA",
        "Valve CC has flow rate=2; tunnels lead to valves DD, BB",
        "Valve DD has flow rate=20; tunnels lead to valves CC, AA, EE",
        "Valve EE has flow rate=3; tunnels lead to valves FF, DD",
        "Valve FF has flow rate=0; tunnels lead to valves EE, GG",
        "Valve GG has flow rate=0; tunnels lead to valves FF, HH",
        "Valve HH has flow rate=22; tunnel leads to valve GG",
        "Valve II has flow rate=0; tunnels lead to valves AA, JJ",
        "Valve JJ has flow rate=21; tunnel leads to valve II",
    ]


def parse_valve(line):
    split = line.split(" ")
    name = split[1]
    flow_rate = int(split[4][5:len(split[4])-1])
    if len(line.split("tunnels lead to valves")) > 1:
        leads_to = [lead.strip() for lead in line.split("tunnels lead to valves")[1].split(",")]
    else:
        leads_to = [line.split("tunnel leads to valve")[1].strip()]

    return Valve(name, flow_rate), leads_to


def parse_valves(lines):
    valves = {}
    for line in lines:
        valve, v_leads_to = parse_valve(line)
        for lead in v_leads_to:
            if lead in valves.keys():
                valves[lead].add_tunnel(valve)
        valves.update({valve.name: valve})

    return valves


def biggest_flow_rate(a, b):
    return a[1] - b[1]


def run_part_1():
    # lines = get_input(16).splitlines()
    lines = get_example()
    valves = parse_valves(lines)
    current = valves["AA"]
    pressure_released = 0
    total_pressure_released = 0
    for minute in range(30):
        print(f"== Minute {minute + 1} ==")
        total_pressure_released += pressure_released
        print(f"releasing {pressure_released} pressure")
        if current[1] == 0 or current[3]:
            next_valves = [valves[v] for v in current[2] if not valves[v][3]]
            next_valves.sort(key=functools.cmp_to_key(biggest_flow_rate), reverse=True)
            current = valves[next_valves[0][0]]
            print(f"You move to valve {current[0]}.")
        elif not current[3]:
            print(f"You open valve {current[0]}.")
            valves[current[0]][3] = True
            pressure_released += current[1]
    print(total_pressure_released)


def run_part_1a():
    # lines = get_input(16).splitlines()
    lines = get_example()
    valves = parse_valves(lines)
    current = valves["AA"]
    total_pressure_released = current.max_value(30, set())
    print(total_pressure_released)



def run_part_2():
    # lines = get_input(16).splitlines()
    lines = get_example()
    valves = parse_valves(lines)
    pass


run_part_1a()
run_part_2()
