import '../Opcode.dart';

class End extends Opcode {
  @override
  int get code => 99;

  @override
  int get parameterQuantity => 0;

  @override
  void run(Program program) => program.end = true;
}