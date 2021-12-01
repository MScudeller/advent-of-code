import '../Opcode.dart';

class Input extends Opcode {
  @override
  int get code => 3;

  @override
  int get parameterQuantity => 1;

  @override
  void run(Program program) {
    var read = program.readInput();
    writeValue(0, program, read);
  }
}