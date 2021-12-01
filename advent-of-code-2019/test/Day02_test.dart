import 'package:advent_of_code_2019/src/IntcodeComputer/Program.dart';
import 'package:test/test.dart';

void main() {
  group('Program', () {
    test('Example 1', () {
      var program = Program('1,0,0,0,99')..run();
      expect(program.getState(), '2,0,0,0,99');
    });
    test('Example 2', () {
      var program = Program('2,3,0,3,99')..run();
      expect(program.getState(), '2,3,0,6,99');
    });
    test('Example 3', () {
      var program = Program('2,4,4,5,99,0')..run();
      expect(program.getState(), '2,4,4,5,99,9801');
    });
    test('Example 4', () {
      var program = Program('1,1,1,4,99,5,6,0,99')..run();
      expect(program.getState(), '30,1,1,4,2,5,6,0,99');
    });
  });
}
