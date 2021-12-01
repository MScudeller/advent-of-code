import 'dart:math';

import '../Day.dart';

class Day10 extends Day {
  List<_Asteroid> _asteroids = List();
  _Asteroid _chosen;

  Day10(List<String> stringInput) {
    var asteroidRune = '#'.runes.first;
    var belt = stringInput.map((e) => e.runes.toList()).toList();
    for (var i = 0; i < belt.length; i++) {
      for (var j = 0; j < belt[i].length; j++) {
        if (belt[i][j] == asteroidRune) {
          _asteroids.add(_Asteroid(Point(j, i)));
        }
      }
    }
    _asteroids.forEach((a) => a.prepareRelations(_asteroids));
  }

  @override
  part1() {
    _asteroids.sort((a, b) => a.visible.compareTo(b.visible));
    _chosen = _asteroids.last;
    return _chosen.visible;
  }

  @override
  part2() {
    _chosen.destroyAsteroids();
    var position = _chosen._vaporized[199]._position;
    return position.x * 100 + position.y;
  }
}

class _Asteroid {
  Point _position;
  Map<double, List<_Asteroid>> _visibleAsteroids = Map();
  int _count = 0;
  List<_Asteroid> _vaporized = List();

  _Asteroid(this._position);

  prepareRelations(List<_Asteroid> asteroids) {
    _count = asteroids.length - 1;
    for (var asteroid in asteroids) {
      if (asteroid == this) continue;
      var relativePosition = asteroid._position - _position;
      var angle = atan2(relativePosition.x, relativePosition.y);
      var list = _visibleAsteroids.putIfAbsent(angle, () => List());
      list.add(asteroid);
    }
    _visibleAsteroids.forEach((k, l) {
      l.sort((a, b) {
        var aPosition = a._position - _position;
        var aHyp = _hyp(aPosition.x, aPosition.y);
        var bPosition = b._position - _position;
        var bHyp = _hyp(bPosition.x, bPosition.y);
        return aHyp.compareTo(bHyp);
      });
    });
  }

  num _hyp(num x, num y) => sqrt(x * x + y * y);

  int get visible => _visibleAsteroids.length;

  destroyAsteroids() {
    var keys = _visibleAsteroids.keys.toList()..sort((a,b) => -a.compareTo(b));
    for (var i = 0; i <= _count; i++) {
      var key = keys[i % keys.length];
      var list = _visibleAsteroids[key];
      if (list.isNotEmpty) {
        var asteroid = list.first;
        _vaporized.add(asteroid);
        list.remove(asteroid);
      }
    }
  }
}
