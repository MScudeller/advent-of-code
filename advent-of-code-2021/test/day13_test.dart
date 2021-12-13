import 'package:test/test.dart';
import 'package:advent_of_code_2021/day.dart';

void main() {
  late Day day;
  setUp(() {
    return day = Day.input(13, [
      '6,10',
      '0,14',
      '9,10',
      '0,3',
      '10,4',
      '4,11',
      '6,0',
      '6,12',
      '4,1',
      '0,13',
      '10,12',
      '3,4',
      '3,0',
      '8,4',
      '1,10',
      '2,14',
      '8,10',
      '9,0',
      '',
      'fold along y=7',
      'fold along x=5',
    ]);
  });
  group('Day13', () {
    test('.part1 1st example', () {
      expect(day.part1(), 17);
    });
    test('.part2 1st example', () {
      expect(day.part2(), isNotNull);
    });
  });
}
