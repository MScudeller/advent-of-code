import 'dart:math';

import '../day.dart';

class Day05 implements Day {
  final List<Line> _input; // ignore: unused_field

  Day05(List<String> input) : _input = input.map((e) => Line(e)).toList();

  @override
  part1() {
    var lines = _input.where((element) => element.isStraight()).toList();
    var maxX = lines.fold<int>(
        0,
        (previousValue, element) =>
            max(previousValue, max(element.xTo, element.xFrom)));
    var maxY = lines.fold<int>(
        0,
        (previousValue, element) =>
            max(previousValue, max(element.yTo, element.yFrom)));
    var grid =
        List.generate(maxX + 1, (i) => List.generate(maxY + 1, (j) => 0));
    for (var line in lines) {
      if (line.isVertical()) {
        var y = line.yFrom;
        var from = min(line.xFrom, line.xTo);
        var to = max(line.xFrom, line.xTo);
        for (int x = from; x <= to; x++) {
          grid[x][y] = grid[x][y] + 1;
        }
      }
      if (line.isHorizontal()) {
        var x = line.xFrom;
        var from = min(line.yFrom, line.yTo);
        var to = max(line.yFrom, line.yTo);
        for (int y = from; y <= to; y++) {
          grid[x][y] = grid[x][y] + 1;
        }
      }
    }

    var expand =
        grid.expand((row) => row.where((cell) => cell >= 2).toList()).toList();
    return expand.length;
  }

  @override
  part2() {
    var maxX = _input.fold<int>(
        0,
        (previousValue, element) =>
            max(previousValue, max(element.xTo, element.xFrom)));
    var maxY = _input.fold<int>(
        0,
        (previousValue, element) =>
            max(previousValue, max(element.yTo, element.yFrom)));
    var grid =
        List.generate(maxX + 1, (i) => List.generate(maxY + 1, (j) => 0));
    for (var line in _input) {
      if (line.isVertical()) {
        var y = line.yFrom;
        var from = min(line.xFrom, line.xTo);
        var to = max(line.xFrom, line.xTo);
        for (int x = from; x <= to; x++) {
          grid[x][y] = grid[x][y] + 1;
        }
      } else if (line.isHorizontal()) {
        var x = line.xFrom;
        var from = min(line.yFrom, line.yTo);
        var to = max(line.yFrom, line.yTo);
        for (int y = from; y <= to; y++) {
          grid[x][y] = grid[x][y] + 1;
        }
      } else {
        var firstX = min(line.xFrom, line.xTo);
        var firstY = line.xFrom == firstX ? line.yFrom : line.yTo;

        var lastX = max(line.xFrom, line.xTo);
        var lastY = line.xFrom == lastX ? line.yFrom : line.yTo;
        var count = lastX - firstX;

        if (firstY > lastY) {
          //going up
          for (int i = 0; i <= count; i++) {
            grid[firstX + i][firstY - i] = grid[firstX + i][firstY - i] + 1;
          }
        } else {
          for (int i = 0; i <= count; i++) {
            grid[firstX + i][firstY + i] = grid[firstX + i][firstY + i] + 1;
          }
        }
      }
    }

    var expand =
        grid.expand((row) => row.where((cell) => cell >= 2).toList()).toList();
    return expand.length;
  }
}

class Line {
  int xFrom;
  int yFrom;
  int xTo;
  int yTo;

  factory Line(String line) {
    var reg = RegExp('(\\d*),(\\d*) -> (\\d*),(\\d*)');
    var list = reg.allMatches(line).first.groups([1, 2, 3, 4]);
    var matches = list.map((e) => int.parse(e!)).toList();
    return Line.all(matches[0], matches[1], matches[2], matches[3]);
  }

  Line.all(this.xFrom, this.yFrom, this.xTo, this.yTo);

  bool isStraight() => xFrom == xTo || yFrom == yTo;

  bool isVertical() => yFrom == yTo;

  bool isHorizontal() => xFrom == xTo;
}
