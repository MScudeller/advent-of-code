import 'package:test/test.dart';
import 'package:advent_of_code_2021/day.dart';

void main() {
  late Day day;
  setUp(() {
    return day = Day.input(
        5, [
    '0,9 -> 5,9',
    '8,0 -> 0,8',
    '9,4 -> 3,4',
    '2,2 -> 2,1',
    '7,0 -> 7,4',
    '6,4 -> 2,0',
    '0,9 -> 2,9',
    '3,4 -> 1,4',
    '0,0 -> 8,8',
    '5,5 -> 8,2',
    ]);
  });
  group('Day05', () {
    test('.part1 1st example', () {
      expect(day.part1(), 5);
    });
    test('.part2 1st example', () {
      expect(day.part2(), 12);
    });
  });
}
