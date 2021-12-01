import '../Day.dart';

class Day01 implements Day {
  List<int> _input;

  Day01(List<String> stringInput) {
    _input = stringInput.map(int.parse).toList();
  }

  @override
  dynamic part1() {
    return _input.map(getRequiredFuel).reduce(_sum);
  }

  int getRequiredFuel(int mass) => (mass ~/ 3) - 2;

  int _sum(int mass1, int mass2) => mass1 + mass2;

  @override
  dynamic part2() {
    return _input.map(getRequiredFuel2).reduce(_sum);
  }

  int getRequiredFuel2(int mass) {
    var fuel = getRequiredFuel(mass);
    if (fuel > 0) {
      return fuel + getRequiredFuel2(fuel);
    }
    return 0;
  }
}
