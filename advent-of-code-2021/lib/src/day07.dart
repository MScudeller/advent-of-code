import 'dart:math';

import '../day.dart';

class Day07 implements Day {
  final List<int> _input;
  final int biggest;

  factory Day07(List<String> input) {
    var list = input.first.split(',').map(int.parse).toList();
    var big = list.reduce((value, element) => max(value, element));
    return Day07.n(list, big);
  }

  Day07.n(this._input, this.biggest);

  @override
  part1() {
    return List.generate(biggest, (i) => i)
        .map((i) => _input
            .map((e) => abs(e, i))
            .reduce((value, element) => value + element))
        .reduce((value, element) => min(value, element));
  }

  int abs(int e, int i) => (e - i).abs();

  @override
  part2() {
    return List.generate(biggest, (i) => i)
        .map((i) => _input
            .map((e) => summation(e, i))
            .reduce((value, element) => value + element))
        .reduce((value, element) => min(value, element));
  }

  double summation(int e, int i) {
    var dist = abs(e, i);
    return (dist + 1) * dist / 2;
  }
}
