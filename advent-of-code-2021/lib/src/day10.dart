import '../day.dart';

class Day10 implements Day {
  final List<String> _input;

  Day10(this._input);

  static final Set<String> open = {
    '(',
    '[',
    '{',
    '<',
  };

  static final Map<String, String> close = {
    ')': '(',
    ']': '[',
    '}': '{',
    '>': '<',
  };

  @override
  part1() {
    var illegalCharacters = List<String>.empty(growable: true);
    for (var line in _input) {
      var stack = Stack<String>();
      for (var char in line.split('')) {
        if (open.contains(char)) {
          stack.push(char);
        } else if (close.containsKey(char)) {
          if (stack.pop() != close[char]) {
            illegalCharacters.add(char);
            break;
          }
        }
      }
    }

    return illegalCharacters.map((e) {
      switch (e) {
        case ')':
          return 3;
        case ']':
          return 57;
        case '}':
          return 1197;
        case '>':
          return 25137;
        default:
          throw Error();
      }
    }).reduce((value, element) => value + element);
  }

  @override
  part2() {
    var incompleteEnding = List<String>.empty(growable: true);
    var foo = close.map((key, value) => MapEntry(value, key));
    for (var line in _input) {
      var stack = Stack<String>();
      var isCorrupt = false;
      for (var char in line.split('')) {
        if (open.contains(char)) {
          stack.push(char);
        } else if (close.containsKey(char)) {
          if (stack.pop() != close[char]) {
            isCorrupt = true;
            break;
          }
        }
      }
      if (!isCorrupt) {
        incompleteEnding.add(stack._stack
            .map((e) => foo[e])
            .toList()
            .reversed
            .join());
      }
    }

    var pointsPer = incompleteEnding.map((e) {
      var score = 0;
      for (var char in e.split('')) {
        score = score * 5;
        switch (char) {
          case ')':
            score += 1;
            break;
          case ']':
            score += 2;
            break;
          case '}':
            score += 3;
            break;
          case '>':
            score += 4;
            break;
        }
      }
      return score;
    }).toList()..sort();

    return pointsPer[pointsPer.length~/2];
  }
}

class Stack<T> {
  final List<T> _stack = List.empty(growable: true);

  T pop() => _stack.removeLast();

  void push(T value) => _stack.add(value);

  T peek() => _stack.last;
}
