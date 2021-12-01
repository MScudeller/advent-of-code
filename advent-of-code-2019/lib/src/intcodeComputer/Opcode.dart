import 'Program.dart';
export 'Program.dart';

abstract class Opcode {
  int relativeBase;
  int basePosition;
  List<ParameterMode> paramModes = [];

  int get code;

  int get parameterQuantity;

  setMode(int code) {
    paramModes = [];
    var modes = code ~/ 100;
    for (var i = 0; i < parameterQuantity; i++) {
      paramModes.add(ParameterMode.values[(modes % 10)]);
      modes = modes ~/ 10;
    }
  }

  int readValue(int position, Program program) {
    var input = program.readMemoryAt(basePosition + position + 1);
    switch (paramModes[position]) {
      case ParameterMode.position:
        return program.readMemoryAt(input);
        break;
      case ParameterMode.immediate:
        return input;
        break;
      case ParameterMode.relative:
        return program.readMemoryAt(relativeBase + input);
        break;
    }
    return null;
  }

  void writeValue(int position, Program program, int value) {
    var input = program.readMemoryAt(basePosition + position + 1);
    switch (paramModes[position]) {
      case ParameterMode.position:
        return program.writePosition(input, value);
        break;
      case ParameterMode.immediate:
        return program.writePosition(basePosition + position, value);
        break;
      case ParameterMode.relative:
        return program.writePosition(relativeBase + input, value);
        break;
    }
    ;
    return null;
  }

  void run(Program program);

  void goNext(Program program) {
    program.jump(parameterQuantity + 1);
  }
}

enum ParameterMode { position, immediate, relative }
