import '../Opcode.dart';

class Output extends Opcode {
  @override
  int get code => 4;

  @override
  int get parameterQuantity => 1;

  @override
  void run(Program program) {
    var value = readValue(0, program);
    program.writeOutput(value);
  }
}