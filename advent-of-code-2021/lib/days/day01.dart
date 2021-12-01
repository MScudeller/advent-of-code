import 'day.dart';

class Day01 implements Day {
  final List<int> _input;

  Day01(List<String> stringInput) : _input = stringInput.map(int.parse).toList();

  @override
  part1() {
    return getIncreasedCount(_input);
  }

  int getIncreasedCount(List<int> depths) {
    var count = 0;
    for(int i = 0; i < depths.length - 1; i++) {
      var iValue = depths[i];
      var jValue = depths[i+1];
      if (jValue > iValue) {
        count++;
      }
    }
    return count;
  }

  @override
  part2() {
    var sums = getMeasurementsSum(_input);
    return getIncreasedCount(sums);
  }

  List<int> getMeasurementsSum(List<int> measurements) {
    var sums = List<int>.empty(growable: true);
    for(int i = 0; i < measurements.length - 2; i++) {
      var iValue = measurements[i];
      var jValue = measurements[i+1];
      var kValue = measurements[i+2];
      sums.add(iValue + jValue + kValue);
    }
    return sums;
  }
}
