import '../Opcode.dart';

abstract class Jump extends Opcode {
  bool _jumped;
  @override
  int get parameterQuantity => 2;

  @override
  void run(Program program) {
    _jumped = false;
    var value1 = readValue(0, program);
    var value2 = readValue(1, program);

    if (shouldJump(value1)) {
      program.jumpTo(value2);
      _jumped = true;
    }
  }

  bool shouldJump(int value);

  @override
  void goNext(Program program) {
    if (!_jumped){
      super.goNext(program);
    }
  }
}