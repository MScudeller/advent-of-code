import '../day.dart';

class Day03 implements Day {
  final List<String> _input;
  final int binarySize;

  Day03(this._input) : binarySize = _input[0].length;

  @override
  part1() {
    var gammaString = '';
    var epsilonString = '';

    for (var i = 0; i < binarySize; i++) {
      var mc = mostCommon(getPositionList(_input, i));
      gammaString += mc;
      epsilonString += invertBinary(mc);
    }

    var gamma = int.parse(gammaString, radix: 2);
    var epsilon = int.parse(epsilonString, radix: 2);

    return gamma * epsilon;
  }

  List<String> getPositionList(List<String> list, int i) {
    return list.map((s) => s[i]).toList();
  }

  String mostCommon(List<String> list) {
    int foo = (list.length ~/ 2);
    var bar = list..sort();
    return bar[foo];
  }

  String invertBinary(String binary) {
    return binary == '0' ? '1' : '0';
  }

  @override
  part2() {
    var options = _input.toList();
    for (var i = 0; i < binarySize; i++) {
      var mc = mostCommon(getPositionList(options, i));
      options = options.where((e) => e[i] == mc).toList();
      if (options.length == 1) {
        break;
      }
    }
    var ogrString = options.first;

    options = _input.toList();
    for (var i = 0; i < binarySize; i++) {
      var mc = leastCommon(getPositionList(options, i));
      options = options.where((e) => e[i] == mc).toList();
      if (options.length == 1) {
        break;
      }
    }
    var csrString = options.first;
    var ogr = int.parse(ogrString, radix: 2);
    var csr = int.parse(csrString, radix: 2);

    return ogr * csr;
  }

  String leastCommon(List<String> list) {
    return invertBinary(mostCommon(list));
  }
}
