import 'package:test/test.dart';
import 'package:advent_of_code_2021/days/day01.dart';


void main() {
  group('Day01', () {
    group('.part1', (){
      test('.part1 1st example', () {
        var day = Day01([
          '199',
          '200',
          '208',
          '210',
          '200',
          '207',
          '240',
          '269',
          '260',
          '263'
        ]);
        expect(day.part1(), 7);
      });
      test('.part2 1st example', () {
        var day = Day01([
          '199',
          '200',
          '208',
          '210',
          '200',
          '207',
          '240',
          '269',
          '260',
          '263'
        ]);
        expect(day.part2(), 5);
      });
    });
  });
}
