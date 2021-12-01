import 'package:advent_of_code_2019/src/days/Day03/Day03.dart';
import 'package:test/test.dart';

void main() {
  Day03 day;
  setUp(() {
    day = Day03([]);
  });
  tearDown(() {
    day = null;
  });
  group('Part 1', () {
    test('Example 1', () {
      day.plot(['R8,U5,L5,D3', 'U7,R6,D4,L4']);
      expect(day.runWire(), 6);
    });
    test('Example 2', () {
      day.plot([
        'R75,D30,R83,U83,L12,D49,R71,U7,L72',
        'U62,R66,U55,R34,D71,R55,D58,R83'
      ]);
      expect(day.runWire(), 159);
    });
    test('Example 3', () {
      day.plot([
        'R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51',
        'U98,R91,D20,R16,D67,R40,U7,R15,U6,R7'
      ]);
      expect(day.runWire(), 135);
    });
  });
  group('Part 2', () {
    test('Example 1', () {
      day.plot(['R8,U5,L5,D3', 'U7,R6,D4,L4']);
      expect(day.runWire2(), 30);
    });
    test('Example 2', () {
      day.plot([
        'R75,D30,R83,U83,L12,D49,R71,U7,L72',
        'U62,R66,U55,R34,D71,R55,D58,R83'
      ]);
      expect(day.runWire2(), 610);
    });
    test('Example 3', () {
      day.plot([
        'R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51',
        'U98,R91,D20,R16,D67,R40,U7,R15,U6,R7'
      ]);
      expect(day.runWire2(), 410);
    });
  });
}
