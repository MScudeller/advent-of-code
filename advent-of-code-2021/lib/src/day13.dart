import 'dart:math';

import '../day.dart';

class Day13 implements Day {
  final Paper paper;
  final List<Fold> folds;

  factory Day13(List<String> input) {
    var fold = input.indexOf('');
    var coordinates = input.sublist(0, fold).map((e) {
      var c = e.split(',').map(int.parse).toList();
      return Point(c[0], c[1]);
    }).toList();
    var maxCoordinates = coordinates.reduce((value, element) =>
        Point(max(value.x, element.x), max(value.y, element.y)));
    var paperParam = List.generate(
        maxCoordinates.y + 1, (e) => List.filled(maxCoordinates.x + 1, false));

    for (var c in coordinates) {
      paperParam[c.y][c.x] = true;
    }
    var paper = Paper(paperParam);

    var folds = input.sublist(fold + 1).map((e) {
      var command = e.split(' ').last;
      var parts = command.split('=');
      var axis = parts[0] == 'x' ? Axis.x : Axis.y;
      var value = int.parse(parts[1]);
      return Fold(axis, value);
    }).toList();

    return Day13.n(paper, folds);
  }

  Day13.n(this.paper, this.folds);

  @override
  part1() {
    paper.fold(folds[0]);
    return paper.dots
        .map((e) => e.where((f) => f).length)
        .reduce((value, element) => value + element);
  }

  @override
  part2() {
    for (var fold in folds.sublist(1)) {
      paper.fold(fold);
    }
    print(paper);
    return null;
  }
}

class Fold {
  final Axis axis;
  final int value;

  Fold(this.axis, this.value);
}

class Paper {
  List<List<bool>> dots;

  Paper(this.dots);

  void fold(Fold command) {
    switch (command.axis) {
      case Axis.y:
        var half1 = dots.sublist(0, command.value);
        var half2 = dots.sublist(command.value + 1).reversed.toList();
        join(half1, half2);
        dots = half1;
        break;
      case Axis.x:
        var half1 = dots.map((e) => e.sublist(0, command.value)).toList();
        var half2 = dots
            .map((e) => e.sublist(command.value + 1).reversed.toList())
            .toList();
        join(half1, half2);
        dots = half1;
        break;
    }
  }

  void join(List<List<bool>> half1, List<List<bool>> half2) {
    for (int x = 0; x < half1.length; x++) {
      for (int y = 0; y < half1[0].length; y++) {
        half1[x][y] = half1[x][y] || half2[x][y];
      }
    }
  }

  @override
  String toString() {
    return dots.map((e) => e.map((f) => f ? '#' : '.').join()).join("\n");
  }
}

enum Axis {
  x,
  y,
}
