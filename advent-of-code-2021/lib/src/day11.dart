import 'dart:math';

import '../day.dart';

class Day11 implements Day {
  final List<String> _input;

  Day11(this._input);

  @override
  part1() {
    var matrix = buildMatrix();
    var count = 0;
    var flat = matrix.expand((e) => e).toList();
    for (int i = 1; i <= 100; i++) {
      for (var octopus in flat) {
        octopus.step();
      }
      while (flat.any((e) => e.canFlash())) {
        var octopus = flat.firstWhere((e) => e.canFlash());
        if (octopus.tryFlash(matrix)) {
          count++;
        }
      }
      continue;
    }
    return count;
  }

  List<List<Octopus>> buildMatrix() {
    var matrix = _input
        .map((e) => e.split('').map(int.parse).map((e) => Octopus(e)).toList())
        .toList();
    for (int x = 0; x < matrix.length; x++) {
      for (int y = 0; y < matrix[0].length; y++) {
        matrix[x][y].coordinate = Point(x, y);
      }
    }
    return matrix;
  }

  @override
  part2() {
    var matrix = buildMatrix();
    var flat = matrix.expand((e) => e).toList();
    var step = 0;
    while (true) {
      step++;
      for (var octopus in flat) {
        octopus.step();
      }
      while (flat.any((e) => e.canFlash())) {
        var octopus = flat.firstWhere((e) => e.canFlash());
        octopus.tryFlash(matrix);
      }
      if (flat.every((e) => e.hasFlashed())) {
        return step;
      }
    }
  }
}

class Octopus {
  late final Point<int> coordinate;
  int energy;

  Octopus(this.energy);

  void step() {
    energy++;
  }

  bool canFlash() => energy > 9;

  bool hasFlashed() => energy == 0;

  bool tryFlash(List<List<Octopus>> matrix) {
    if (!canFlash()) {
      return false;
    }

    energy = 0;
    getAdjacentOctopuses(matrix).forEach((e) => e.addEnergy());
    return true;
  }

  void addEnergy() {
    if (!hasFlashed()) {
      energy++;
    }
  }

  List<Octopus> getAdjacentOctopuses(List<List<Octopus>> matrix) {
    var width = matrix.length;
    var length = matrix[0].length;
    return [
      Point(coordinate.x - 1, coordinate.y - 1),
      Point(coordinate.x, coordinate.y - 1),
      Point(coordinate.x + 1, coordinate.y - 1),
      Point(coordinate.x - 1, coordinate.y),
      Point(coordinate.x + 1, coordinate.y),
      Point(coordinate.x - 1, coordinate.y + 1),
      Point(coordinate.x, coordinate.y + 1),
      Point(coordinate.x + 1, coordinate.y + 1),
    ]
        .where((p) => p.x >= 0 && p.x < width && p.y >= 0 && p.y < length)
        .map((e) => matrix[e.x][e.y])
        .toList();
  }

  @override
  String toString() {
    return energy.toString();
  }
}
