import 'package:test/test.dart';
import 'package:advent_of_code_2021/day.dart';

void main() {
  late Day day;
  setUp(() {
    return day = Day.input(
        2, ['forward 5', 'down 5', 'forward 8', 'up 3', 'down 8', 'forward 2']);
  });
  group('Day02', () {
    test('.part1 1st example', () {
      expect(day.part1(), 150);
    });
    test('.part2 1st example', () {
      expect(day.part2(), 900);
    });
  });
}
