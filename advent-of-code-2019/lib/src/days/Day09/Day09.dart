import 'package:advent_of_code_2019/src/intcodeComputer/Program.dart';

import '../Day.dart';

class Day09 extends Day {
  String _input;

  Day09(List<String> stringInput) {
    _input = stringInput.first;
  }

  @override
  part1() {
    var program = Program(_input)
    ..inputToUser = false
    ..inputs = [1]
    ..outputToUser = false;
    program.run();
    return program.outputs.first;
  }

  @override
  part2() {
    var program = Program(_input)
      ..inputToUser = false
      ..inputs = [2]
      ..outputToUser = false;
    program.run();
    return program.outputs.first;
  }

}