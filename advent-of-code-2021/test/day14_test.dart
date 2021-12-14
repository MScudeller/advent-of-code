import 'package:test/test.dart';
import 'package:advent_of_code_2021/day.dart';

void main() {
  late Day day;
  setUp(() {
    return day = Day.input(14, [
        'NNCB',
        '',
        'CH -> B',
        'HH -> N',
        'CB -> H',
        'NH -> C',
        'HB -> C',
        'HC -> B',
        'HN -> C',
        'NN -> C',
        'BH -> H',
        'NC -> B',
        'NB -> B',
        'BN -> B',
        'BB -> N',
        'BC -> B',
        'CC -> N',
        'CN -> C',
    ]);
  });
  group('Day14', () {
    test('.part1 1st example', () {
      expect(day.part1(), 1588);
    });
    test('.part2 1st example', () {
      expect(day.part2(), 2188189693529);
    });
  });
}
