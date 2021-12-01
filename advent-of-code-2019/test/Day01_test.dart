import 'package:advent_of_code_2019/src/days/Day01/Day01.dart';
import 'package:test/test.dart';

void main() {
  Day01 day;
  setUp(() {
    day = Day01([]);
  });
  group('getRequiredFuel', () {
    test('test 1', () {
      expect(day.getRequiredFuel(12), 2);
    });
    test('test 2', () {
      expect(day.getRequiredFuel(14), 2);
    });
    test('test 3', () {
      expect(day.getRequiredFuel(1969), 654);
    });
    test('test 4', () {
      expect(day.getRequiredFuel(100756), 33583);
    });
  });
  group('getRequiredFuel2', () {
    test('test 1', () {
      expect(day.getRequiredFuel2(14), 2);
    });
    test('test 2', () {
      expect(day.getRequiredFuel2(1969), 966);
    });
    test('test 3', () {
      expect(day.getRequiredFuel2(100756), 50346);
    });
  });
}
