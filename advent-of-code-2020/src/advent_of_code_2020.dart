import 'days/Day.dart';

main(List<String> arguments) {
  run();
}

void run() {
  Day day = Day(6);
  print(day.part1());
  print(day.part2());
}
