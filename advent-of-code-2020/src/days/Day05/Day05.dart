import '../Day.dart';

class Day05 implements Day {
  final List<String> _input; // ignore: unused_field

  Day05(this._input);

  @override
  part1() {
    var orderedSeats = _input
        .map((e) => _Seat(e))
        .toList()
        ..sort();
    return orderedSeats.last.id;
  }

  @override
  part2() {
    var orderedSeats = _input
        .map((e) => _Seat(e))
        .toList()
        ..sort();
    var current = orderedSeats.first.id;
    for (var seat in orderedSeats) {
      if (current != seat.id) {
        return current;
      }

      current++;
    }
  }
}

class _Seat implements Comparable<_Seat> {
  final int row;
  final int column;

  int get id => row * 8 + column;

  _Seat(String code)
      : row = _BinarySearch("F", "B", 127, 0).DoStuff(code),
        column = _BinarySearch("L", "R", 7, 0).DoStuff(code);

  @override
  int compareTo(_Seat other) {
    return id - other.id;
  }
}

class _BinarySearch {
  final String rightChar;
  final String leftChar;
  int maxValue;
  int minValue;

  _BinarySearch(this.rightChar, this.leftChar, this.maxValue, this.minValue);

  int DoStuff(String code) {
    for (var i = 0; i < code.length; i++) {
      var char = code[i];
      var possibilities = maxValue - minValue + 1;
      if (char == rightChar) {
        maxValue -= possibilities ~/ 2;
      } else if (char == leftChar) {
        minValue += possibilities ~/ 2;
      }
    }

    if (minValue == maxValue) {
      return minValue;
    }

    throw Exception("wat");
  }
}
