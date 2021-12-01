import '../Day.dart';

class Day02 implements Day {
  final List<String> _input; // ignore: unused_field

  Day02(this._input);

  @override
  part1() {
    return _input
        .map((e) => _PasswordPolicy(e))
        .where((element) => element.IsValidSled())
        .length;
  }

  @override
  part2() {
    return _input
        .map((e) => _PasswordPolicy(e))
        .where((element) => element.IsValidToboggan())
        .length;
  }
}

class _PasswordPolicy {
  int _min;
  int _max;
  String _letter;
  String _value;

  _PasswordPolicy(String pass) {
    var exp = RegExp(r"([\d]+)-([\d]+) (.*): (.*)");
    var matches = exp
        .firstMatch(pass)
        .groups([1, 2, 3, 4]);

    _min = int.parse(matches[0]);
    _max = int.parse(matches[1]);
    _letter = matches[2];
    _value = matches[3];
  }

  IsValidSled() {
    var count = _value.split(_letter).length - 1;
    return _min <= count && count <= _max;
  }

  IsValidToboggan() {
    var minChar = _value.substring(_min - 1, _min);
    var maxChar = _value.substring(_max - 1, _max);
    return minChar == _letter && maxChar != _letter || minChar != _letter && maxChar == _letter;
  }
}
