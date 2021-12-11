import 'package:test/test.dart';
import 'package:advent_of_code_2021/day.dart';

void main() {
  late Day day;
  setUp(() {
    return day = Day.input(11, [
      '5483143223',
      '2745854711',
      '5264556173',
      '6141336146',
      '6357385478',
      '4167524645',
      '2176841721',
      '6882881134',
      '4846848554',
      '5283751526',
    ]);
  });
  group('Day11', () {
    test('.part1 1st example', () {
      expect(day.part1(), 1656);
    });
    test('.part2 1st example', () {
      expect(day.part2(), 195);
    });
  });
}
