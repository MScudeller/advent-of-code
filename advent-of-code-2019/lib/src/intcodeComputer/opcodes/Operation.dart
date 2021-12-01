import '../Opcode.dart';

abstract class Operation extends Opcode {

  @override
  int get parameterQuantity => 3;

  @override
  void run(Program program) {
    var value1 = readValue(0, program);
    var value2 = readValue(1, program);
    var funcValue = func(value1, value2);
    writeValue(2, program, funcValue);
  }

  int func(int value1, int value2);
}