import '../day.dart';

class Day06 implements Day {
  final List<int> _input; // ignore: unused_field

  Day06(List<String> input)
      : _input = input.first.split(',').map(int.parse).toList();

  @override
  part1() {
    var days = 80;
    var fishes = _input.map((e) => Fish(e)).toList(growable: true);
    for (int i = 0; i < days; i++) {
      var newFishes = List<Fish>.empty(growable: true);
      for (var fish in fishes) {
        fish.remaining--;
        if (fish.remaining == -1) {
          newFishes.add(Fish(8));
          fish.remaining = 6;
        }
      }
      fishes.addAll(newFishes);
    }
    return fishes.length;
  }

  @override
  part2() {
    var map = <int, int>{
      0: _input.where((e) => e == 0).length,
      1: _input.where((e) => e == 1).length,
      2: _input.where((e) => e == 2).length,
      3: _input.where((e) => e == 3).length,
      4: _input.where((e) => e == 4).length,
      5: _input.where((e) => e == 5).length,
      6: _input.where((e) => e == 6).length,
      7: _input.where((e) => e == 7).length,
      8: _input.where((e) => e == 8).length,
    };
    var days = 256;
    for (int i = 0; i < days; i++) {
      var newOnes = 0;
      var map2 = map.map((key, value) {
        if (key != 0) {
          return MapEntry(key - 1, value);
        }
        newOnes = value;
        return MapEntry(8, value);
      });
      map2[6] = map2[6]! + newOnes;
      map = map2;
    }
    return map.values
        .fold<int>(0, (previousValue, element) => previousValue += element);
  }
}

class Fish {
  int remaining;

  Fish(this.remaining);
}
