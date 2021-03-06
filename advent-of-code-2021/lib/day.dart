import 'dart:io';

import 'src/day01.dart';
import 'src/day02.dart';
import 'src/day03.dart';
import 'src/day04.dart';
import 'src/day05.dart';
import 'src/day06.dart';
import 'src/day07.dart';
import 'src/day08.dart';
import 'src/day09.dart';
import 'src/day10.dart';
import 'src/day11.dart';
import 'src/day12.dart';
import 'src/day13.dart';
import 'src/day14.dart';
import 'src/day15.dart';
import 'src/day16.dart';
import 'src/day17.dart';
import 'src/day18.dart';
import 'src/day19.dart';
import 'src/day20.dart';
import 'src/day21.dart';
import 'src/day22.dart';
import 'src/day23.dart';
import 'src/day24.dart';
import 'src/day25.dart';

abstract class Day {
  factory Day(int dayNumber) {
    if (dayNumber < 0 || dayNumber > 25) {
      throw ArgumentError("Day must be between 1 and 25.", "dayNumber");
    }

    var input = File('input/day${dayNumber.toString().padLeft(2, '0')}.txt')
        .readAsLinesSync();
    return Day.input(dayNumber, input);
  }

  factory Day.input(int dayNumber, List<String> input) {
    switch (dayNumber) {
      case 1:
        return Day01(input);
      case 2:
        return Day02(input);
      case 3:
        return Day03(input);
      case 4:
        return Day04(input);
      case 5:
        return Day05(input);
      case 6:
        return Day06(input);
      case 7:
        return Day07(input);
      case 8:
        return Day08(input);
      case 9:
        return Day09(input);
      case 10:
        return Day10(input);
      case 11:
        return Day11(input);
      case 12:
        return Day12(input);
      case 13:
        return Day13(input);
      case 14:
        return Day14(input);
      case 15:
        return Day15(input);
      case 16:
        return Day16(input);
      case 17:
        return Day17(input);
      case 18:
        return Day18(input);
      case 19:
        return Day19(input);
      case 20:
        return Day20(input);
      case 21:
        return Day21(input);
      case 22:
        return Day22(input);
      case 23:
        return Day23(input);
      case 24:
        return Day24(input);
      case 25:
        return Day25(input);
    }
    throw Error();
  }

  dynamic part1();

  dynamic part2();
}
