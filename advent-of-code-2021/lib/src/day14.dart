import 'dart:isolate';

import '../day.dart';

class Day14 implements Day {
  final String template;
  final Map<String, String> pairs;

  factory Day14(List<String> input) {
    var param = { for (var e in input.sublist(2).map((e) => e.split(' -> ').toList())) e[0] : e[1] };
    return Day14.n(input[0], param);
  }

  Day14.n(this.template, this.pairs);

  @override
  part1() {
    var temp = template;
    for (int i = 0; i < 10; i++) {
      temp = step(temp, pairs);
    }
    var list = temp.split('');
    var foo = list.fold<Map<String, int>>(<String, int>{ }, (p, e) {
      
      if (p.containsKey(e)){
        p[e] = p[e]! + 1;
      } else {
        p.putIfAbsent(e, () => 1);
      }
      return p;
    });
    var entries = foo.entries.toList();
    entries.sort((a, b) => a.value.compareTo(b.value));
    return entries.last.value - entries.first.value;
  }

  String step(String temp, Map<String, String> map) {
    var ans = '';
    for (int i1 = 0; i1 < temp.length - 1; i1++) {
      ans += temp[i1];
      ans += map[temp.substring(i1, i1+2)]!;
    }
    ans += temp.substring(temp.length-1);
    return ans;
  }
  
  @override
  part2() {
    var temp = template;
    for (int i = 0; i < 40; i++) {
      temp = step(temp, pairs);
    }
    var list = temp.split('');
    var foo = list.fold<Map<String, int>>(<String, int>{ }, (p, e) {

      if (p.containsKey(e)){
        p[e] = p[e]! + 1;
      } else {
        p.putIfAbsent(e, () => 1);
      }
      return p;
    });
    var entries = foo.entries.toList();
    entries.sort((a, b) => a.value.compareTo(b.value));
    return entries.last.value - entries.first.value;
  }
}
