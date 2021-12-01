import 'Operation.dart';

class Multiply extends Operation {
  @override
  int get code => 2;

  @override
  int func(int value1, int value2) => value1 * value2;
}