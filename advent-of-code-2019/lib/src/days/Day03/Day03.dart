import 'dart:math';

import '../Day.dart';

class Day03 implements Day {
  List<String> _stringInput;
  var _gridCenter = 0;
  Map<Point, WireSection> _points = Map();

  Point<int> u(Point<int> previous) => Point<int>(previous.x, previous.y + 1);

  Point<int> d(Point<int> previous) => Point<int>(previous.x, previous.y - 1);

  Point<int> l(Point<int> previous) => Point<int>(previous.x - 1, previous.y);

  Point<int> r(Point<int> previous) => Point<int>(previous.x + 1, previous.y);

  Day03(List<String> stringInput) {
    _stringInput = stringInput;
  }

  void plot(List<String> stringInput) {
    var wireNumber = 0;
    for (var wire in stringInput) {
      var list = wire.split(',');
      var head = WireSection(Point<int>(_gridCenter, _gridCenter));
      for (var line in list) {
        var command = line.substring(0, 1);
        var value = int.parse(line.substring(1));
        switch (command) {
          case 'U':
            head = walk(head, value, wireNumber, u);
            break;
          case 'D':
            head = walk(head, value, wireNumber, d);
            break;
          case 'L':
            head = walk(head, value, wireNumber, l);
            break;
          case 'R':
            head = walk(head, value, wireNumber, r);
            break;
        }
      }
      wireNumber++;
    }
  }

  WireSection walk(WireSection last, int value, int wireNumber,
      Point<int> Function(Point<int> previous) operation) {
    var head = last;
    var lastStep = last.steps[wireNumber];
    for (var step = lastStep + 1; step <= lastStep + value; step++) {
      var headPoint = operation(head.point);

      var section =
          _points.putIfAbsent(headPoint, () => WireSection(headPoint));
      if (section.steps[wireNumber] == 0) {
        section.steps[wireNumber] = step;
      }
      head = section;
    }
    return head;
  }

  @override
  part1() {
    _points.clear();
    plot(_stringInput);
    var real = runWire();
    return real;
  }

  int runWire() {
    var crosses = _points.values
        .where((element) => element.steps[0] != 0 && element.steps[1] != 0)
        .toList();
    crosses
        .sort((a, b) => a.distanceFromCenter.compareTo(b.distanceFromCenter));
    return crosses.first.distanceFromCenter;
  }

  @override
  part2() {
    plot(_stringInput);
    var real = runWire2();
    return real;
  }

  int runWire2() {
    var crosses = _points.values
        .where((element) => element.steps[0] != 0 && element.steps[1] != 0)
        .toList();
    crosses.sort((a, b) => a.effort.compareTo(b.effort));
    return crosses.first.effort;
  }
}

class WireSection {
  Point<int> point;
  List<int> steps = [0, 0];

  int get distanceFromCenter => (point.x).abs() + (point.y).abs();

  int get effort => steps[0] + steps[1];

  WireSection(Point<num> key) {
    point = key;
  }
}
