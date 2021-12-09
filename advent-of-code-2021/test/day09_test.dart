import 'package:advent_of_code_2021/day.dart';
import 'package:test/test.dart';

void main() {
  late Day day;
  setUp(() {
    return day = Day.input(9, [
      '2199943210',
      '3987894921',
      '9856789892',
      '8767896789',
      '9899965678',
    ]);
  });
  group('Day03', () {
    test('.part1 1st example', () {
      expect(day.part1(), 15);
    });
    test('.part2 1st example', () {
      expect(day.part2(), 1134);
    });
  });
}
