import 'package:test/test.dart';
import 'package:advent_of_code_2021/day.dart';

void main() {
  late Day day;
  setUp(() {
    return day = Day.input(3, [
      '00100',
      '11110',
      '10110',
      '10111',
      '10101',
      '01111',
      '00111',
      '11100',
      '10000',
      '11001',
      '00010',
      '01010'
    ]);
  });
  group('Day03', () {
    test('.part1 1st example', () {
      expect(day.part1(), 198);
    });
    test('.part2 1st example', () {
      expect(day.part2(), 230);
    });
  });
}
