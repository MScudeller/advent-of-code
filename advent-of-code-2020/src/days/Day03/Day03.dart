import 'dart:math';

import '../Day.dart';

class Day03 implements Day {
  final List<String> _input;

  Day03(this._input);

  @override
  part1() {
    return _CountTrees(3, 1);
  }

  int _CountTrees(int paceRight, int paceDown) {
    var slope = _Slope(_input, paceRight, paceDown);
    int trees = 0;
    while (!slope.HasTraversed()) {
      slope.Step();
      if (slope.IsTree()) {
        trees++;
      }
    }
    return trees;
  }

  @override
  part2() {
    return _CountTrees(1, 1)
        * _CountTrees(3, 1)
        * _CountTrees(5, 1)
        * _CountTrees(7, 1)
        * _CountTrees(1, 2);
  }
}

class _Slope {
  List<String> _pattern;
  int _patternWidth;
  int _patternHeight;
  Point<int> _pace;
  Point<int> _currentPosition;


  _Slope(this._pattern, int paceRight, int paceDown) {
    _patternWidth = _pattern[0].length;
    _patternHeight = _pattern.length;
    _pace = Point(paceRight, paceDown);
    _currentPosition = Point(0, 0);
  }

  Step() {
    _currentPosition = _currentPosition + _pace;
    if (_currentPosition.x >= _patternWidth) {
      _currentPosition -= Point(_patternWidth, 0);
    }
  }

  bool IsTree() {
    return _pattern[_currentPosition.y][_currentPosition.x] == "#";
  }

  bool HasTraversed() {
    return _currentPosition.y == _patternHeight - 1;
  }
}
