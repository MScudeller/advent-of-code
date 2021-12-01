import '../Day.dart';
import 'package:advent_of_code_2019/src/intcodeComputer/Program.dart';

class Day05 implements Day {
  String _input;

  Day05(List<String> stringInput) {
    _input = stringInput.first;
  }

  @override
  part1() {
    var program = Program(_input)
    ..inputToUser = false
    ..outputToUser = false
    ..inputs = [1];
    program.run();
    return program.outputs.last;
  }

  @override
  part2() {
    var program = Program(_input)
      ..inputToUser = false
      ..outputToUser = false
      ..inputs = [5];
    program.run();
    return program.outputs.last;
  }

}