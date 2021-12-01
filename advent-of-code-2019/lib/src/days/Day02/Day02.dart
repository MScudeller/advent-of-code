import '../Day.dart';
import 'package:advent_of_code_2019/src/intcodeComputer/Program.dart';

class Day02 implements Day {
  String _input;

  Day02(List<String> stringInput) {
    _input = stringInput.first;
  }

  @override
  dynamic part1() {
    return runTrial(12, 2);
  }

  int runTrial(int noun, int verb) {
    var program = Program(_input);
    program.writePosition(1, noun);
    program.writePosition(2, verb);
    program.run();
    return program.readMemoryAt(0);
  }

  @override
  dynamic part2() {
    for(int noun = 0; noun < 100; noun++) {
      for(int verb = 0; verb < 100; verb++) {
        var result = runTrial(noun,verb);
        if (result == 19690720) {
          return 100 * noun + verb;
        }
      }
    }
  }
}
