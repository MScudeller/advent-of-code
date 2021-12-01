import 'package:advent_of_code_2019/src/days/Day12/Day12.dart';
import 'package:test/test.dart';

void main() {
  group('Day 12', () {
    group('Part 1', () {
      test('Example 1', () {
        var day = Day12([
        '<x=-1, y=0, z=2>',
        '<x=2, y=-10, z=-7>',
        '<x=4, y=-8, z=8>',
        '<x=3, y=5, z=-1>'
        ]);
        day.steps = 10;
        expect(day.part1(), 179);
      });
      test('Example 2', () {
        var day = Day12([
        '<x=-8, y=-10, z=0>',
        '<x=5, y=5, z=10>',
        '<x=2, y=-7, z=3>',
        '<x=9, y=-8, z=-3>'
        ]);
        day.steps = 100;
        expect(day.part1(), 1940);
      });
    });
    group('Part 2', () {
    });
  });
}
