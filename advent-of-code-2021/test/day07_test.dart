import 'package:test/test.dart';
import 'package:advent_of_code_2021/day.dart';

void main() {
  late Day day;
  setUp(() {
    return day = Day.input(
        7, [
      '16,1,2,0,4,2,7,1,2,14'
    ]);
  });
  group('Day07', () {
    test('.part1 1st example', () {
      expect(day.part1(), 37);
    });
    test('.part2 1st example', () {
      expect(day.part2(), 168);
    });
  });
}
