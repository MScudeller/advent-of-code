import '../day.dart';

class Day12 implements Day {
  final Set<Cave> map;
  final Cave start, end;

  factory Day12(List<String> input) {
    var map = <Cave>{};
    for (var connection in input) {
      var caves = connection.split('-').map((e) => Cave(e)).toList();
      map.addAll(caves);
      var mapped0 = map.lookup(caves[0])!;
      var mapped1 = map.lookup(caves[1])!;
      mapped0.linked.add(mapped1);
      mapped1.linked.add(mapped0);
    }

    return Day12.n(map, map.singleWhere((e) => e.name == 'start'),
        map.singleWhere((e) => e.name == 'end'));
  }

  Day12.n(this.map, this.start, this.end);

  @override
  part1() {
    var paths = Path(start, true).nextPaths();
    while (paths.any((e) => e.hasNext())) {
      paths = paths.expand((e) => e.nextPaths()).toList();
    }

    return paths.where((e) => e.isFinished()).length;
  }

  @override
  part2() {
    var paths = Path(start, false).nextPaths();
    while (paths.any((e) => e.hasNext())) {
      paths = paths.expand((e) => e.nextPaths()).toList();
    }

    return paths.where((e) => e.isFinished()).length;
  }
}

class Cave {
  final String name;
  final Set<Cave> linked;

  Cave(this.name) : linked = <Cave>{};

  bool isBig() => name == name.toUpperCase();

  bool isSmall() => name == name.toLowerCase();

  bool isVisitAllowed(Path path) =>
      isBig() ||
      isSmall() && !wasVisited(path) ||
      isSmall() && wasVisited(path) && name != 'start' && path.visitSpecificCave();

  bool wasVisited(Path path) => path.list.contains(this);

  bool hasRemainingLinked(Path path) =>
      linked.any((e) => e.isVisitAllowed(path));

  @override
  String toString() {
    return name;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Cave && runtimeType == other.runtimeType && name == other.name;

  @override
  int get hashCode => name.hashCode;
}

class Path {
  final List<Cave> list;
  bool visitedSpecificCave = false;

  Path(Cave cave, bool visited)
      : list = List.filled(1, cave, growable: true),
        visitedSpecificCave = visited;

  Path.from(Path path, Cave cave)
      : list = path.list.toList(growable: true)..add(cave),
        visitedSpecificCave = path.visitedSpecificCave || path.list.where((e) => e.isSmall() && e.name == cave.name).length >= 1;

  bool hasNext() => !isFinished() && last().hasRemainingLinked(this);

  List<Path> nextPaths() {
    if (!hasNext()) {
      return [this];
    }

    return last()
        .linked
        .where((e) => e.isVisitAllowed(this))
        .map((e) => Path.from(this, e))
        .toList();
  }

  Cave last() => list.last;

  bool isFinished() => last().name == 'end';

  bool visitSpecificCave() {
    if (visitedSpecificCave) {
      return false;
    }
    return true;
  }

  @override
  String toString() {
    return 'Path{list: ${list.join(',')}, visitedSpecificCave: $visitedSpecificCave}';
  }
}
