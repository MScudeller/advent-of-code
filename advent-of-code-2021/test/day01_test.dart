import 'package:test/test.dart';
import 'package:advent_of_code_2021/day.dart';

void main() {
  late Day day;
  setUp(() {
    return day = Day.input(1,
        ['199', '200', '208', '210', '200', '207', '240', '269', '260', '263']);
  });
  group('Day01', () {
    group('.part1', () {
      test('.part1 1st example', () {
        expect(day.part1(), 7);
      });
      test('.part2 1st example', () {
        expect(day.part2(), 5);
      });
    });
  });
}
