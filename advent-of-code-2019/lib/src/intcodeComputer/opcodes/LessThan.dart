import 'Operation.dart';

class LessThan extends Operation {
  @override
  int get code => 7;

  @override
  int func(int value1, int value2) => value1 < value2 ? 1 : 0;
}
