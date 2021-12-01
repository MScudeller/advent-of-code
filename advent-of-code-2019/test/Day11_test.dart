import 'package:advent_of_code_2019/src/IntcodeComputer/Program.dart';
import 'package:test/test.dart';

void main() {
  group('HullPainter', ()
  {
    group('Part 1', () {
      test('Example 1', () {
        var program = Program('109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99')
          ..outputToUser = false
          ..run();
        expect(program.outputs.first, 109);
      });
      test('Example 2', () {
        var program = Program('1102,34915192,34915192,7,4,7,99,0')
          ..outputToUser = false
          ..run();
        expect(program.outputs.first.toString().length, 16);
      });
      test('Example 3', () {
        var program = Program('104,1125899906842624,99')
          ..outputToUser = false
          ..run();
        expect(program.outputs.first, 1125899906842624);
      });
    });
    group('Part 2', () {
    });
  });
}
