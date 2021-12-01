import '../Day.dart';

class Day01 implements Day {
  final List<int> _input;

  Day01(List<String> stringInput) :
    this._input = stringInput.map(int.parse).toList();


  @override
  dynamic part1() {
    for(int i = 0; i < _input.length; i++) {
      var iValue = _input[i];
      for(int j = i + 1; j < _input.length; j++) {
        var jValue = _input[j];
        if (iValue + jValue == 2020) {
          return iValue * jValue;
        }
      }
    }
  }

  @override
  dynamic part2() {
    for(int i = 0; i < _input.length; i++) {
      var iValue = _input[i];
      for(int j = i + 1; j < _input.length; j++) {
        var jValue = _input[j];
        for(int k = j + 1; k < _input.length; k++) {
          var kValue = _input[k];
          if (iValue + jValue + kValue == 2020) {
            return iValue * jValue * kValue;
          }
        }
      }
    }
  }
}
