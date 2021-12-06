import 'package:test/test.dart';
import 'package:advent_of_code_2021/day.dart';

void main() {
  late Day day;
  setUp(() {
    return day = Day.input(
        6, [
      '3,4,3,1,2'
    ]);
  });
  group('Day06', () {
    test('.part1 1st example', () {
      expect(day.part1(), 5934);
    });
    test('.part2 1st example', () {
      expect(day.part2(), 26984457539);
    });
  });
}
