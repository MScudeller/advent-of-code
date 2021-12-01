import '../Day.dart';

class Day04 implements Day {
  String _input;
  List<String> _possible;

  Day04(List<String> stringInput) {
    _input = stringInput.first;
    var range = _input.split('-').map(int.parse).toList();
    _possible = [for (var i = range[0]; i <= range[1]; i++) i.toString()];
  }

  @override
  part1() {
    assert(testNumber('111111') == true);
    assert(testNumber('223450') == false);
    assert(testNumber('123789') == false);

    _possible.retainWhere(testNumber);
    return _possible.length;
  }

  bool testNumber(String element) {
    int lastDigit;
    bool atLeastOneDouble = false;
    for (var i in element.runes) {
      var digit = int.parse(String.fromCharCode(i));
      if (digit == lastDigit) {
        atLeastOneDouble = true;
      }
      if (digit < (lastDigit ?? 0)) {
        return false;
      }
      lastDigit = digit;
    }
    return atLeastOneDouble;
  }

  @override
  part2() {
    assert(testNumberPart2('112233') == true);
    assert(testNumberPart2('123444') == false);
    assert(testNumberPart2('111122') == true);

    _possible.retainWhere(testNumberPart2);
    return _possible.length;
  }

  bool testNumberPart2(String element) {
    int lastDigit;
    bool atLeastOneDouble = false;
    bool isDouble = false;
    int repeatingCount = 0;
    for (var i in element.runes) {
      var digit = int.parse(String.fromCharCode(i));
      if (digit == lastDigit) {
        repeatingCount++;
        if (repeatingCount == 1) {
          isDouble = true;
        } else {
          isDouble = false;
        }
      } else {
        atLeastOneDouble = atLeastOneDouble || isDouble;
        isDouble = false;
        repeatingCount = 0;
      }
      if (digit < (lastDigit ?? 0)) {
        //this test is not needed anymore
        return false;
      }
      lastDigit = digit;
    }
    return atLeastOneDouble || isDouble;
  }
}
