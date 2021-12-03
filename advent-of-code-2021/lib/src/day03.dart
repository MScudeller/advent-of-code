import '../day.dart';

class Day03 implements Day {
  final List<String> _input; // ignore: unused_field

  Day03(this._input);

  @override
  part1() {
    var gammaString = '';
    for(var i = 0; i < _input[0].length; i++) {
      int foo = (_input.length~/2);
      var bar = _input.map((e) => e[i]).toList()..sort();
      gammaString += bar[foo];
    }

    var epsilonString = '';
    for(var i = 0; i < gammaString.length; i++) {
      epsilonString += gammaString[i] == '0' ? '1' : '0';
    }
    var gamma = int.parse(gammaString, radix:2);
    var epsilon = int.parse(epsilonString, radix:2);

    return gamma*epsilon;
  }

  @override
  part2() {
    var options = _input.toList();
    for(var i = 0; i < _input[0].length; i++) {
      var mc = mostCommon(options.map((s) => s[i]).toList());
      options = options.where((e) => e[i] == mc).toList();
      if(options.length == 1){
        break;
      }
    }
    var ogrString = options.first;

    options = _input.toList();
    for(var i = 0; i < _input[0].length; i++) {
      var mc = leastCommon(options.map((s) => s[i]).toList());
      options = options.where((e) => e[i] == mc).toList();
      if(options.length == 1){
        break;
      }
    }
    var csrString = options.first;
    var ogr = int.parse(ogrString, radix:2);
    var csr = int.parse(csrString, radix:2);

    return ogr*csr;
  }

  String mostCommon(List<String> list){
    int foo = (list.length~/2);
    var bar = list..sort();
    return bar[foo];
  }

  String leastCommon(List<String> list){
    var mc = mostCommon(list);
    return mc == '0' ? '1' : '0';
  }
}
