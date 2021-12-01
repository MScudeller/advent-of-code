import 'dart:math';

import '../Day.dart';

class Day12 implements Day {
  int steps = 1000;
  Jupiter _jupiter;

  Day12(List<String> input) : _jupiter = Jupiter.fromString(input);

  @override
  part1() {
    print(_jupiter.totalEnergy);
    for (var i = 0; i < steps; ++i) {
      _jupiter.calculateVelocities();
      _jupiter.step();
    }
    return _jupiter.totalEnergy;
  }

  @override
  part2() {
    return null;
  }
}

class Jupiter {
  final List<Moon> moons;

  Jupiter(this.moons);

  static Jupiter fromString(List<String> values) {
    return Jupiter(values.map((s) => Moon.fromString(s)).toList());
  }

  void calculateVelocities() {
    for (var i = 0; i < moons.length; ++i) {
      var a = moons[i];
      for (var j = i; j < moons.length; ++j) {
        var b = moons[j];
        var sign = (a.position - b.position).toSign();
        a.velocity -= sign;
        b.velocity += sign;
      }
    }
  }

  void step() {
    for (var moon in moons) {
      moon.position += moon.velocity;
    }
  }

  int get totalEnergy =>
      moons.map((m) => m.totalEnergy).reduce((a, b) => a + b);
}

class Moon {
  Point3 position;
  Point3 velocity;

  Moon(this.position) : velocity = Point3(0, 0, 0);

  static Moon fromString(String value) {
    var exp = RegExp(r"<x=(.*?), y=(.*?), z=(.*?)>");
    var matches = exp
        .firstMatch(value)
        .groups([1, 2, 3])
        .map((s) => int.parse(s))
        .toList();

    return Moon(Point3(matches[0], matches[1], matches[2]));
  }

  int get potentialEnergy =>
      position.x.abs() + position.y.abs() + position.z.abs();

  int get kineticEnergy =>
      velocity.x.abs() + velocity.y.abs() + velocity.z.abs();

  int get totalEnergy => potentialEnergy * kineticEnergy;
}

class Point3<T extends num> {
  final T x;
  final T y;
  final T z;

  const Point3(T x, T y, T z)
      : this.x = x,
        this.y = y,
        this.z = z;

  String toString() => 'Point($x, $y, $z)';

  bool operator ==(dynamic other) =>
      other is Point3 && x == other.x && y == other.y && z == other.z;

  //int get hashCode => _JenkinsSmiHash.hash2(x.hashCode, y.hashCode);

  Point3<T> operator +(Point3<T> other) {
    return Point3<T>(x + other.x, y + other.y, z + other.z);
  }

  Point3<T> operator -(Point3<T> other) {
    return Point3<T>(x - other.x, y - other.y, z - other.z);
  }

  Point3<T> operator *(num factor) {
    return Point3<T>((x * factor), (y * factor), (z * factor));
  }

  Point3<T> toSign() {
    return Point3<T>((x.sign), (y.sign), (z.sign));
  }

  double get magnitude => pow(x * x + y * y + z * z, 1 / 3);

  double distanceTo(Point3<T> other) {
    return pow(cubeDistanceTo(other), 1 / 3);
  }

  T cubeDistanceTo(Point3<T> other) {
    var dx = x - other.x;
    var dy = y - other.y;
    var dz = z - other.z;
    return dx * dx + dy * dy + dz * dz;
  }
}
