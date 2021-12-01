import 'dart:math';

import 'package:advent_of_code_2019/src/intcodeComputer/Program.dart';

class HullPainter {
  static Point _moveNorth(Point position) => Point(position.x, position.y + 1);

  static Point _moveWest(Point position) => Point(position.x - 1, position.y);

  static Point _moveSouth(Point position) => Point(position.x, position.y - 1);

  static Point _moveEast(Point position) => Point(position.x + 1, position.y);

  Program _program;
  Map<Point, Panel> hull = {};
  Point _position = Point(0, 0);
  Point Function(Point) move = _moveNorth;

  HullPainter(this._program);

  void turnOn() {
    do {
      var panel = _read();
      _program.inputs.add(panel.color.index);
      _program.run();
      panel.color = PanelColor.values[_program.outputs.removeAt(0)];
      var turnDirection = _program.outputs.removeAt(0);
      switch (turnDirection) {
        case 0:
          _turnLeft();
          break;
        case 1:
          _turnRight();
          break;
      }
      _position = move(_position);
    } while (!_program.end);
  }

  Panel _read() {
    var panel = hull.putIfAbsent(_position, () => Panel());
    return panel;
  }

  void _turnLeft() {
    switch (move) {
      case _moveNorth:
        move = _moveWest;
        break;
      case _moveWest:
        move = _moveSouth;
        break;
      case _moveSouth:
        move = _moveEast;
        break;
      case _moveEast:
        move = _moveNorth;
        break;
    }
  }

  void _turnRight() {
    switch (move) {
      case _moveNorth:
        move = _moveEast;
        break;
      case _moveWest:
        move = _moveNorth;
        break;
      case _moveSouth:
        move = _moveWest;
        break;
      case _moveEast:
        move = _moveSouth;
        break;
    }
  }

  int countPainted() => hull.values.where((e) => e.painted).length;
}

class Panel {
  PanelColor _color = PanelColor.Black;
  bool _painted = false;

  bool get painted => _painted;

  PanelColor get color => _color;

  set color(var value) {
    _color = value;
    _painted = true;
  }

  Panel();
}

enum PanelColor {
  Black,
  White,
}
