import '../day.dart';

class Day09 implements Day {
  final List<List<int>> _input;

  Day09.m(this._input);

  factory Day09(List<String> input) {
    var foo = input.map((i) => i.split('').map(int.parse).toList()).toList();

    return Day09.m(foo);
  }

  @override
  part1() {
    var lowPoints = findLowPoints();
    return lowPoints
        .map((e) => e.height + 1)
        .reduce((value, element) => value + element);
  }

  List<Point> findLowPoints() {
    var width = _input.length;
    var length = _input[0].length;
    var lowPoints = List<Point>.empty(growable: true);
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < length; y++) {
        var shouldAdd = true;
        if (x - 1 >= 0) {
          shouldAdd = shouldAdd && _input[x][y] < _input[x - 1][y];
        }
        if ((x + 1) <= (width - 1)) {
          shouldAdd = shouldAdd && _input[x][y] < _input[x + 1][y];
        }
        if (y - 1 >= 0) {
          shouldAdd = shouldAdd && _input[x][y] < _input[x][y - 1];
        }
        if ((y + 1) <= (length - 1)) {
          shouldAdd = shouldAdd && _input[x][y] < _input[x][y + 1];
        }
        if (shouldAdd) {
          lowPoints.add(Point(x, y, _input[x][y]));
        }
      }
    }
    var lowPoints2 = lowPoints;
    return lowPoints2;
  }

  @override
  part2() {
    var lowPoints = findLowPoints();
    var basins = List<Set<Point>>.empty(growable: true);
    for (var lowPoint in lowPoints) {
      basins.add(getBasin(<Point>{}, lowPoint));
    }

    var list = basins.map((e) => e.length).toList()..sort();
    return list.reversed.take(3).reduce((v, e) => v * e);
  }

  Set<Point> getBasin(Set<Point> done, Point point) {
    if (!done.add(point)) {
      return done;
    }

    var set = getAdjacent(point).where((p) => p.height != 9).toSet();
    for (var adjacent in set) {
      done.addAll(getBasin(done, adjacent));
    }
    return done;
  }

  List<Point> getAdjacent(Point point) {
    var width = _input.length;
    var length = _input[0].length;
    var adjacent = List<Point>.empty(growable: true);
    if (point.x - 1 >= 0) {
      adjacent.add(Point(point.x - 1, point.y, _input[point.x - 1][point.y]));
    }
    if (point.x + 1 <= width - 1) {
      adjacent.add(Point(point.x + 1, point.y, _input[point.x + 1][point.y]));
    }
    if (point.y - 1 >= 0) {
      adjacent.add(Point(point.x, point.y - 1, _input[point.x][point.y - 1]));
    }
    if (point.y + 1 <= length - 1) {
      adjacent.add(Point(point.x, point.y + 1, _input[point.x][point.y + 1]));
    }
    return adjacent;
  }
}

class Point {
  int x, y, height;

  Point(this.x, this.y, this.height);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Point &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y &&
          height == other.height;

  @override
  int get hashCode => x.hashCode ^ y.hashCode ^ height.hashCode;

  @override
  String toString() {
    return 'Point{x: $x, y: $y, height: $height}';
  }
}
