import 'dart:io';
import 'dart:math';

import 'package:advent_of_code_2019/src/intcodeComputer/Opcode.dart';

import '../Day.dart';

class Day13 implements Day {
  String _input;

  Day13(List<String> input) : this._input = input.first;

  @override
  part1() {
    var program = Program(_input);
    var arcade = Arcade(program)..start();
    return arcade.screen.values.where((e) => e == TileType.Block).length;
  }

  @override
  part2() {
    var code = _input.replaceRange(0, 1, '2');
    var program = Program(code);
    var arcade = Arcade(program)..start();

    return arcade.score;
  }
}

class Arcade {
  final Program program;
  Map<Point, TileType> screen = {};
  int score = 0;

  Arcade(this.program) {
    program.inputToUser = false;
    program.outputToUser = false;
  }

  start() {
    while (!program.end) {
      program.run();
      while (program.outputs.isNotEmpty) {
        readTile();
      }
      //printScreen();
      program.inputs.add(readJoystick());
    }
  }

  readTile() {
    var x = program.outputs.removeAt(0);
    var y = program.outputs.removeAt(0);
    var id = program.outputs.removeAt(0);
    if (x == -1 && y == 0) {
      score = id;
      return;
    }

    screen[Point(x, y)] = TileType.values[id];
  }

  void printScreen() {
    var last = screen.keys.last;
    for (var i = 0; i <= last.y; ++i) {
      var list = List<TileType>();
      for (var j = 0; j < last.x; ++j) {
        list.add(screen[Point(j, i)]);
      }
      printLine(list);
    }
    print('');
    print('');
  }

  void printLine(List<TileType> line) {
    var chars = {
      0: '\u25A2',
      1: '\u25A4',
      2: '\u25A3',
      3: '\u25AC',
      4: '\u25CF'
    };

    var lineString = '';
    for (var j = 0; j < line.length; j++) {
      lineString += chars[line[j].index];
    }
    print(lineString);
  }

  int readJoystick() {
    var ballEntry = screen.entries.singleWhere((e) => e.value == TileType.Ball);
    var paddleEntry = screen.entries.singleWhere((e) => e.value == TileType.Paddle);

    return (ballEntry.key.x-paddleEntry.key.x).sign;
  }
}

enum TileType { Empty, Wall, Block, Paddle, Ball }
