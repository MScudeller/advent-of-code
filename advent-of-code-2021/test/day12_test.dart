import 'package:advent_of_code_2021/day.dart';
import 'package:test/test.dart';

void main() {
  late Day day;
  setUp(() {
    day = Day.input(12, [
      'start-A',
      'start-b',
      'A-c',
      'A-b',
      'b-d',
      'A-end',
      'b-end',
    ]);
  });
  group('Day12', () {
    test('.part1 1st example 1', () {
      expect(day.part1(), 10);
    });
    test('.part2 1st example', () {
      expect(day.part2(), 36);
    });
  });
}
