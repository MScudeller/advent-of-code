import '../Day.dart';

class Day06 implements Day {
  final List<String> _input; // ignore: unused_field

  Day06(this._input);

  @override
  part1() {
    return _Batch(_input).GetCountSum();
  }

  @override
  part2() {
    return _Batch(_input).GetSameSum();
  }
}

class _Batch {
  final List<_Group> groups = List<_Group>();

  _Batch(List<String> input) {
    var group = _Group();
    groups.add(group);
    for (var personLine in input) {
      if (personLine.isEmpty) {
        group = _Group();
        groups.add(group);
      } else {
        group.AddPerson(personLine);
      }
    }
  }

  int GetCountSum() {
    return groups.map((g) => g.GetDifferentAnswers().length)
        .reduce((e1,e2) => e1 + e2);
  }

  int GetSameSum() {
    return groups.map((g) => g.GetSameAnswers().length)
        .reduce((e1,e2) => e1 + e2);
  }
}

class _Group {
  final Set<_Person> persons = Set<_Person>();

  void AddPerson(String answers) {
    persons.add(_Person(answers));
  }

  Set<String> GetDifferentAnswers() {
    return persons.expand((p) => p.answers).toSet();
  }

  Set<String> GetSameAnswers() {
    var numberOfPersons = persons.length;
    var allAnswers = persons.expand((p) => p.answers).toList()..sort();
    var foo = allAnswers.groupBy((p) => p).map((key, value) => MapEntry(key, value.length))
        ..removeWhere((key, value) => value < numberOfPersons);
    return foo.keys.toSet();
  }
}

class _Person {
  final Set<String> answers;

  _Person(String answers) : this.answers = answers.split("").toSet();
}

extension Iterables<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(
      <K, List<E>>{},
          (Map<K, List<E>> map, E element) =>
      map..putIfAbsent(keyFunction(element), () => <E>[]).add(element));
}