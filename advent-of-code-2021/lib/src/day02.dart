import '../day.dart';

class Day02 implements Day {
  final List<Command> _input;

  Day02(List<String> input) : _input = input.map((e) => Command(e)).toList();

  @override
  part1() {
    var position = _input.fold<Position>(Position(), (p, c) => c.run1(p));
    return position.horizontalPosition * position.depth;
  }

  @override
  part2() {
    var position = _input.fold<Position>(Position(), (p, c) => c.run2(p));
    return position.horizontalPosition * position.depth;
  }
}

class Position {
  int horizontalPosition;
  int depth;
  int aim;

  Position()
      : horizontalPosition = 0,
        depth = 0,
        aim = 0;
}

abstract class Command {
  abstract int quantity;

  factory Command(String command) {
    var foo = command.split(' ');
    var quantity = int.parse(foo[1]);
    switch (foo[0]) {
      case 'forward':
        return Forward(quantity);
      case 'down':
        return Down(quantity);
      case 'up':
        return Up(quantity);
    }
    throw ArgumentError();
  }

  Position run1(Position position);
  Position run2(Position position);
}

class Forward implements Command {
  @override
  int quantity;

  Forward(this.quantity);

  @override
  Position run1(Position position) {
    position.horizontalPosition += quantity;
    return position;
  }

  @override
  Position run2(Position position) {
    position.horizontalPosition += quantity;
    position.depth += position.aim * quantity;
    return position;
  }
}

class Down implements Command {
  @override
  int quantity;

  Down(this.quantity);

  @override
  Position run1(Position position) {
    position.depth += quantity;
    return position;
  }

  @override
  Position run2(Position position) {
    position.aim += quantity;
    return position;
  }
}

class Up implements Command {
  @override
  int quantity;

  Up(this.quantity);

  @override
  Position run1(Position position) {
    position.depth -= quantity;
    return position;
  }

  @override
  Position run2(Position position) {
    position.aim -= quantity;
    return position;
  }
}
