import '../day.dart';

class Day08 implements Day {
  final List<Entry> _input;

  Day08(List<String> input) : _input = input.map((e) => Entry(e)).toList();

  @override
  part1() {
    return _input.expand((e) => e.outputs).where((e) => e.isEasilyRecognizable()).length;
  }

  @override
  part2() {
    var map = _input.map((e) {
      return e.outputs.map((e) => e.value()).join('');
    }).toList();
    var map2 = map.map(int.parse).toList();
    return map2.reduce((value, element) => value + element);
  }
}

class Entry {
  List<Digit> patterns;
  List<Digit> outputs;

  Entry.n(this.patterns, this.outputs);

  factory Entry(String input) {
    var foo = input.split('|');
    var patterns = foo[0].trim().split(' ').map((e) => Digit(e)).toList();

    var one = patterns.firstWhere((e) => e.isOne());
    var four = patterns.firstWhere((e) => e.isFour());
    var seven = patterns.firstWhere((e) => e.isSeven());
    var fiveWires = patterns.where((e) => e.lines.length == 5).toList(); //5: 2,3,5
    var adg = (fiveWires[0].lines.intersection(fiveWires[1].lines)).intersection(fiveWires[2].lines);
    var sixWires = patterns.where((e) => e.lines.length == 6).toList(); //6: 0,6,9

    var a = seven.lines.singleWhere((e) => !one.lines.contains(e));
    var d = adg.intersection(four.lines).first;
    var g = adg.difference({a, d}).first;

    var zero = sixWires.singleWhere((e) => !e.lines.contains(d));
    var ce = sixWires.where((i) => i != zero).map((i) => i.lines).reduce((value, element) => {value.difference(element).single, element.difference(value).single}).toSet();
    var c = ce.intersection(one.lines).single;
    var e = ce.difference(one.lines).single;
    var f = one.lines.intersection(seven.lines).difference({c}).single;
    var b = four.lines.difference({c,d,f}).single;

    var wires = [a,b,c,d,e,f,g];
    var outputs = foo[1].trim().split(' ').map((e) => Digit.wired(e, wires)).toList();

    return Entry.n(patterns, outputs);
  }
//2: 1
//3: 7
//4: 4


//7: 8
}

class Digit {
  Set<String> lines;
  List<String>? wired;

  Digit(String input): lines = input.split('').toSet();
  Digit.wired(String input, this.wired): lines = input.split('').toSet();

  bool isZero() {
    var number = {wired![0],wired![1],wired![2],wired![4],wired![5],wired![6]};
    return lines.difference(number).isEmpty && lines.containsAll(number);
  }
  bool isOne() => lines.length == 2;
  bool isTwo() {
    var number = {wired![0],wired![2],wired![3],wired![4],wired![6]};
    return lines.difference(number).isEmpty && lines.containsAll(number);
  }
  bool isThree() {
    var number = {wired![0],wired![2],wired![3],wired![5],wired![6]};
    return lines.difference(number).isEmpty && lines.containsAll(number);
  }
  bool isFour() => lines.length == 4;
  bool isFive() {
    var number = {wired![0],wired![1],wired![3],wired![5],wired![6]};
    return lines.difference(number).isEmpty && lines.containsAll(number);
  }
  bool isSix() {
    var number = {wired![0],wired![1],wired![3],wired![4],wired![5],wired![6]};
    return lines.difference(number).isEmpty && lines.containsAll(number);
  }
  bool isSeven() => lines.length == 3;
  bool isEight() => lines.length == 7;
  bool isNine() {
    var number = {wired![0],wired![1],wired![2],wired![3],wired![5],wired![6]};
    return lines.difference(number).isEmpty && lines.containsAll(number);
  }

  bool isEasilyRecognizable() => isOne() || isFour() || isSeven() || isEight();

  String value() {
    if (isZero()) return '0';
    if (isOne()) return '1';
    if (isTwo()) return '2';
    if (isThree()) return '3';
    if (isFour()) return '4';
    if (isFive()) return '5';
    if (isSix()) return '6';
    if (isSeven()) return '7';
    if (isEight()) return '8';
    if (isNine()) return '9';
    throw Error();
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
      other is Digit &&
          runtimeType == other.runtimeType &&
          lines == other.lines;
  }

  @override
  int get hashCode => lines.hashCode;
}