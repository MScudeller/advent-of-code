import 'dart:io';

import 'Opcode.dart';
import 'opcodes/AdjustRelativeBase.dart';
import 'opcodes/End.dart';
import 'opcodes/Equals.dart';
import 'opcodes/Error.dart';
import 'opcodes/FalseJump.dart';
import 'opcodes/Input.dart';
import 'opcodes/LessThan.dart';
import 'opcodes/Multiply.dart';
import 'opcodes/Output.dart';
import 'opcodes/Sum.dart';
import 'opcodes/TrueJump.dart';

class Program {
  Map<int, int> _memory, _initialMemory;
  Map<int, Opcode> _operations;
  int _head = 0, relativeBase = 0;
  bool end = false, waitingInput = false;
  bool inputToUser = true, outputToUser = true;
  List<int> inputs = List<int>(), outputs = List<int>();

  Program(String memory) {
    _initialMemory = memory.split(',').map(int.parse).toList().asMap();
    reset();
    _operations = Map<int, Opcode>.fromIterable([
      Sum(),
      Multiply(),
      Input(),
      Output(),
      TrueJump(),
      FalseJump(),
      LessThan(),
      Equals(),
      AdjustRelativeBase(),
      End()
    ], key: (item) => item.code);
  }

  void run() {
    waitingInput = false;
    do {
      var value = readMemory();
      var operation = _buildOpcode(value);
      try {
        operation.run(this);
        operation.goNext(this);
      } on MissingInputException {
        waitingInput = true;
      }
    } while (!end && !waitingInput);
  }

  int readMemory() => readMemoryAt(_head);

  int readMemoryAt(int position) => _memory.putIfAbsent(position, () => 0);

  int readInput() => inputToUser ? readUserInput() : readProgramInput();

  int readUserInput() => int.parse(stdin.readLineSync());

  int readProgramInput() {
    if (inputs.isNotEmpty) return inputs.removeAt(0);
    throw MissingInputException();
  }

  void writeOutput(int value) {
    var func = outputToUser ? writeUserOutput : writeProgramOutput;
    return func(value);
  }

  void writeUserOutput(int value) => print(value);

  void writeProgramOutput(int value) {
    outputs.add(value);
  }

  Opcode _buildOpcode(int code) {
    return _operations.putIfAbsent(code % 100, () => Error(code))
      ..setMode(code)
      ..basePosition = _head
      ..relativeBase = relativeBase;
  }

  void writePosition(int position, int value) => _memory[position] = value;

  String getState() =>
      _memory.values.join(','); //this will jump the uncreated 0s

  void jump(int count) => _head += count;

  void jumpTo(int position) => _head = position;

  void reset() {
    _resetMemory();
    _resetInputs();
    _resetOutputs();
  }

  void _resetMemory() {
    _memory = Map.from(_initialMemory);
    _head = 0;
    end = false;
  }

  void _resetInputs() {
    inputs = List<int>();
  }

  void _resetOutputs() {
    outputs = List<int>();
  }
}

class MissingInputException implements Exception {}
