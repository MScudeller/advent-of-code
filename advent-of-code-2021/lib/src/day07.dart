import 'dart:math';

import '../day.dart';

class Day07 implements Day {
  final List<int> _input;

  Day07(List<String> input)
      : _input = input.first.split(',').map(int.parse).toList();

  @override
  part1() {
    var biggest = _input.fold<int>(
        0, (previousValue, element) => max(previousValue, element));
    var a = List.generate(biggest, (i) => i);
    return a
        .map((i) => _input
            .map((e) => (e - i).abs())
            .reduce((value, element) => value + element))
        .reduce((value, element) => min(value, element));
  }

  @override
  part2() {
    var biggest = _input.fold<int>(
        0, (previousValue, element) => max(previousValue, element));
    var a = List.generate(biggest, (i) => i);
    return a
        .map((i) => _input
            .map((e) {
              var dist = (e - i).abs();
              return (dist + 1) * dist / 2;
            })
            .reduce((value, element) => value + element))
        .reduce((value, element) => min(value, element));
  }
}
