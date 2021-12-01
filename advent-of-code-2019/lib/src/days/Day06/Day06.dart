import 'dart:collection';

import 'package:advent_of_code_2019/src/days/Day.dart';

class Day06 implements Day {
  Universe universe;

  Day06(List<String> input) {
    universe = Universe(input);
  }

  @override
  part1() {
    var example = Universe([
      'COM)B',
      'B)C',
      'C)D',
      'D)E',
      'E)F',
      'B)G',
      'G)H',
      'D)I',
      'E)J',
      'J)K',
      'K)L'
    ]);
    assert(example.getTotalOrbits() == 42);

    return universe.getTotalOrbits();
  }

  @override
  part2() {
    var example = Universe([
      'COM)B',
      'B)C',
      'C)D',
      'D)E',
      'E)F',
      'B)G',
      'G)H',
      'D)I',
      'E)J',
      'J)K',
      'K)L',
      'K)YOU',
      'I)SAN'
    ]);
    assert(example.getMinimumTransfer('SAN', 'YOU') == 4);
    return universe.getMinimumTransfer('SAN', 'YOU');
  }
}

class Universe {
  HashSet<Planet> _orbits = HashSet<Planet>();

  Universe(List<String> relations) {
    for (var relation in relations) {
      var planets = relation.split(')');
      var planet1 = containsOrAdd(planets[0]);
      containsOrAdd(planets[1])..orbits = planet1;
    }
  }

  Planet containsOrAdd(String planetName) {
    var planet = Planet(planetName);
    if (!_orbits.contains(planet)) {
      _orbits.add(planet);
    }
    return _orbits.lookup(planet);
  }

  int getTotalOrbits() {
    return _orbits.map((p) => p.orbitCount).reduce((c1, c2) => c1 + c2);
  }

  int getMinimumTransfer(String planetOneName, String planetTwoName) {
    var one = _orbits.singleWhere((p) => p.name == planetOneName);
    var two = _orbits.singleWhere((p) => p.name == planetTwoName);
    var root = _findRoot(one, two);
    var distOne = one.toList().indexOf(root);
    var distTwo = two.toList().indexOf(root);
    return distOne + distTwo;

  }
  Planet _findRoot(Planet one, Planet two) {
    var planet1Set = one.toSet();
    for (var planet in two) {
      if (planet1Set.contains(planet)) {
        return planet;
      }
    }
    return null;
  }
}

class Planet extends IterableMixin {
  Planet orbits;
  String name;
  int _orbitCount;

  Planet(this.name);

  int get orbitCount {
    if (_orbitCount != null) return _orbitCount;
    _orbitCount = orbits != null ? orbits.orbitCount + 1 : 0;
    return _orbitCount;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Planet && runtimeType == other.runtimeType && name == other.name;

  @override
  int get hashCode => name.hashCode;

  @override
  Iterator get iterator => PlanetIterator()..current = this;
}

class PlanetIterator extends Iterator {
  @override
  Planet current;

  @override
  bool moveNext() {
    if (current.orbits == null) return false;
    current = current.orbits;
    return true;
  }
}
