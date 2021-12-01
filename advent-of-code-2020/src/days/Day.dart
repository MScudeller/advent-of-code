import 'dart:io';

import 'Day01/Day01.dart';
import 'Day02/Day02.dart';
import 'Day03/Day03.dart';
import 'Day04/Day04.dart';
import 'Day05/Day05.dart';
import 'Day06/Day06.dart';
import 'Day07/Day07.dart';
import 'Day08/Day08.dart';
import 'Day09/Day09.dart';
import 'Day10/Day10.dart';
import 'Day11/Day11.dart';
import 'Day12/Day12.dart';
import 'Day13/Day13.dart';
import 'Day14/Day14.dart';
import 'Day15/Day15.dart';
import 'Day16/Day16.dart';
import 'Day17/Day17.dart';
import 'Day18/Day18.dart';
import 'Day19/Day19.dart';
import 'Day20/Day20.dart';
import 'Day21/Day21.dart';
import 'Day22/Day22.dart';
import 'Day23/Day23.dart';
import 'Day24/Day24.dart';
import 'Day25/Day25.dart';

abstract class Day {

  factory Day(int dayNumber) {
    var input = File('input/day${dayNumber.toString().padLeft(2, '0')}.txt')
        .readAsLinesSync();
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
      default:
        return Day25(input);
    }
  }

  dynamic part1();

  dynamic part2();
}