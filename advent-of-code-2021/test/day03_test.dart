import 'package:test/test.dart';
import 'package:advent_of_code_2021/day.dart';

void main() {
  late Day day;
  setUp(() {
    return day = Day.input(
        3, []);
  });
  group('Day03', () {
    test('.part1 1st example', () {
      expect(day.part1(), null);
    });
    test('.part2 1st example', () {
      expect(day.part2(), null);
    });
  });
}
