import 'package:advent_of_code_2019/src/days/Day.dart';
import 'package:advent_of_code_2019/src/intcodeComputer/Program.dart';
import 'dart:math';

class Day07 implements Day {
  String _input;

  Day07(List<String> stringInput) {
    _input = stringInput.first;
  }

  @override
  part1() {
    return getMaxSignal(_input);
  }

  int getMaxSignal(String initialProgram) {
    var values = [0, 1, 2, 3, 4];
    var configurations = Permutation(values, 5).result;

    var maxResult = 0;
    for (var configuration in configurations) {
      var result = runAmplifiers(initialProgram, configuration, 0);
      maxResult = max(maxResult, result);
    }
    return maxResult;
  }

  int runAmplifiers(String initialProgram, List<int> configuration, int start) {
    var program = Program(initialProgram)
      ..outputToUser = false
      ..inputToUser = false;
    int output = start;
    for (var input in configuration) {
      program.inputs = [input, output];
      program.run();
      output = program.outputs.isEmpty ? null : program.outputs.first;
      program.reset();
    }

    return output;
  }

  @override
  part2() {
    return getMaxSignal2(_input);
  }

  int getMaxSignal2(String initialProgram) {
    var values = [5, 6, 7, 8, 9];
    var configurations = Permutation(values, 5).result;

    var maxResult = 0;
    for (var configuration in configurations) {
      var result = runAmplifiers2(initialProgram, configuration, 0);
      maxResult = max(maxResult, result);
    }
    return maxResult;
  }

  int runAmplifiers2(String initialProgram, List<int> configurations,
      int start) {
    var programs = [for (var config in configurations) Program(initialProgram)
      ..outputToUser = false
      ..inputToUser = false
      ..inputs = [config]
    ];
    int input = start;
    var halted = false;
    while (!halted) {
      for (var program in programs) {
        program.inputs.add(input);
        program.run();
        input = program.outputs.isEmpty ? null : program.outputs.last;
      }
      halted = programs.last.end;
    }

    return input;
  }
}

class Permutation<T> {

  Permutation(List<T> pool, int maxElements) {
    this._permutations = [];
    this._permutate([], pool, maxElements);
  }

  List<List<T>> get result => this._permutations;
  List<List<T>> _permutations;

  void _permutate(List<T> permutation, List<T> pool, int maxElements) {
    int n = pool.length;
    if (n > 0 && permutation.length < maxElements) {
      for (int i = 0; i < n; i++) {
        List<T> newPermutation = List.from(permutation);
        newPermutation.add(pool[i]);
        List<T> newPool = List.from(pool);
        newPool.removeAt(i);
        this._permutate(newPermutation, newPool, maxElements);
      }
    } else {
      this._permutations.add(permutation);
    }
  }
}