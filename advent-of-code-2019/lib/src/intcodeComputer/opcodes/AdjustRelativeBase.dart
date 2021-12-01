import '../Opcode.dart';

class AdjustRelativeBase extends Opcode {
  @override
  int get code => 9;

  @override
  int get parameterQuantity => 1;

  @override
  void run(Program program) {
    var value = readValue(0, program);
    program.relativeBase += value;
  }
}