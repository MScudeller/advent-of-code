import 'package:advent_of_code_2019/src/IntcodeComputer/Program.dart';
import 'package:test/test.dart';

void main() {
  group('Program', ()
  {
    group('Part 1', () {
      test('Example 1', () {
        var program = Program('3,0,4,0,99')
          ..inputToUser = false
          ..outputToUser = false
          ..inputs = [50]
          ..run();
        expect(program.outputs.first, 50);
      });
      test('Example 2', () {
        var program = Program('1002,4,3,4,33')
          ..run();
        expect(program.getState(), '1002,4,3,4,99');
      });
      test('Example 3', () {
        var program = Program('1101,100,-1,4,0')
          ..run();
        expect(program.getState(), '1101,100,-1,4,99');
      });
    });
    group('Part 2', () {
      test('position mode - 50 Equal to 8', () {
        var program = Program('3,9,8,9,10,9,4,9,99,-1,8')
          ..inputToUser = false
          ..outputToUser = false
          ..inputs = [50]
          ..run();
        expect(program.outputs.first, 0);
      });
      test('position mode - 8 Equal to 8', () {
        var program = Program('3,9,8,9,10,9,4,9,99,-1,8')
          ..inputToUser = false
          ..outputToUser = false
          ..inputs = [8]
          ..run();
        expect(program.outputs.first, 1);
      });
      test('position mode - 4 less than 8', () {
        var program = Program('3,9,7,9,10,9,4,9,99,-1,8')
          ..inputToUser = false
          ..outputToUser = false
          ..inputs = [4]
          ..run();
        expect(program.outputs.first, 1);
      });
      test('position mode - 8 less than 8', () {
        var program = Program('3,9,7,9,10,9,4,9,99,-1,8')
          ..inputToUser = false
          ..outputToUser = false
          ..inputs = [8]
          ..run();
        expect(program.outputs.first, 0);
      });
      test('position mode - 50 less than 8', () {
        var program = Program('3,9,7,9,10,9,4,9,99,-1,8')
          ..inputToUser = false
          ..outputToUser = false
          ..inputs = [50]
          ..run();
        expect(program.outputs.first, 0);
      });
      test('immediate mode - 50 Equal to 8', () {
        var program = Program('3,3,1108,-1,8,3,4,3,99')
          ..inputToUser = false
          ..outputToUser = false
          ..inputs = [50]
          ..run();
        expect(program.outputs.first, 0);
      });
      test('immediate mode - 8 Equal to 8', () {
        var program = Program('3,3,1108,-1,8,3,4,3,99')
          ..inputToUser = false
          ..outputToUser = false
          ..inputs = [8]
          ..run();
        expect(program.outputs.first, 1);
      });
      test('immediate mode - 50 less than 8', () {
        var program = Program('3,3,1107,-1,8,3,4,3,99')
          ..inputToUser = false
          ..outputToUser = false
          ..inputs = [4]
          ..run();
        expect(program.outputs.first, 1);
      });
      test('immediate mode - 50 less than 8', () {
        var program = Program('3,3,1107,-1,8,3,4,3,99')
          ..inputToUser = false
          ..outputToUser = false
          ..inputs = [8]
          ..run();
        expect(program.outputs.first, 0);
      });
      test('immediate mode - 50 less than 8', () {
        var program = Program('3,3,1107,-1,8,3,4,3,99')
          ..inputToUser = false
          ..outputToUser = false
          ..inputs = [50]
          ..run();
        expect(program.outputs.first, 0);
      });
      test('position mode - Jump', () {
        var program = Program('3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9')
          ..inputToUser = false
          ..outputToUser = false
          ..inputs = [0]
          ..run();
        expect(program.outputs.first, 0);
      });
      test('position mode - Jump 2', () {
        var program = Program('3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9')
          ..inputToUser = false
          ..outputToUser = false
          ..inputs = [50]
          ..run();
        expect(program.outputs.first, 1);
      });
      test('immediate mode - Jump', () {
        var program = Program('3,3,1105,-1,9,1101,0,0,12,4,12,99,1')
          ..inputToUser = false
          ..outputToUser = false
          ..inputs = [0]
          ..run();
        expect(program.outputs.first, 0);
      });
      test('immediate mode - Jump 2', () {
        var program = Program('3,3,1105,-1,9,1101,0,0,12,4,12,99,1')
          ..inputToUser = false
          ..outputToUser = false
          ..inputs = [50]
          ..run();
        expect(program.outputs.first, 1);
      });
      test('larger example 1', () {
        var program = Program('3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99')
          ..inputToUser = false
          ..outputToUser = false
          ..inputs = [4]
          ..run();
        expect(program.outputs.first, 999);
      });
      test('larger example 2', () {
        var program = Program('3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99')
          ..inputToUser = false
          ..outputToUser = false
          ..inputs = [8]
          ..run();
        expect(program.outputs.first, 1000);
      });
      test('larger example 3', () {
        var program = Program('3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99')
          ..inputToUser = false
          ..outputToUser = false
          ..inputs = [50]
          ..run();
        expect(program.outputs.first, 1001);
      });
    });
  });
}
