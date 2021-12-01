import 'Operation.dart';

class Equals extends Operation {
  @override
  int get code => 8;

  @override
  int func(int value1, int value2) => value1 == value2 ? 1 : 0;
}
