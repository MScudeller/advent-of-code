import 'dart:math';

import 'package:advent_of_code_2019/src/days/Day11/HullPainter.dart';
import 'package:advent_of_code_2019/src/intcodeComputer/Program.dart';

import '../Day.dart';

class Day11 extends Day {
  String _input;

  Day11(List<String> stringInput) {
    _input = stringInput.first;
  }

  @override
  part1() {
    var program = Program(_input)
      ..inputToUser = false
      ..outputToUser = false;
    var painter = HullPainter(program);
    painter.turnOn();
    return painter.countPainted();
  }

  @override
  part2() {
    var program = Program(_input)
      ..inputToUser = false
      ..outputToUser = false;
    var painter = HullPainter(program)
      ..hull.putIfAbsent(
          Point(0, 0), () => Panel()..color = PanelColor.White);
    painter.turnOn();

    var minPoint = painter.hull.keys
        .reduce((p1, p2) => Point(min(p1.x, p2.x), min(p1.y, p2.y)));
    var maxPoint = painter.hull.keys
        .reduce((p1, p2) => Point(max(p1.x, p2.x), max(p1.y, p2.y)));
    var xSize = maxPoint.x - minPoint.x + 1;
    var ySize = maxPoint.y - minPoint.y + 1;
    var map = [
      for (var i = 0; i < xSize; i++)
        [
          for (var j = 0; j < ySize; j++)
            !painter.hull.containsKey(Point(i + minPoint.x, j + minPoint.y))
                ? 0
                : painter
                    .hull[Point(i + minPoint.x, j + minPoint.y)].color.index
        ]
    ];
    printHull(map);
  }

  printHull(List<List<int>> hull) {
    var chars = {0: '\u2588', 1: '\u2591', 2: '\u2593'};
    for (var i = hull[0].length-1; i >=0 ; i--) {
      var lineString = '';
      for (var j = 0; j < hull.length; j++) {
        lineString += chars[hull[j][i]];
      }
      print(lineString);
    }
  }
}
