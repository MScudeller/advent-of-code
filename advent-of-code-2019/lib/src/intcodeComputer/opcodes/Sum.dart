import 'Operation.dart';

class Sum extends Operation {
  @override
  int get code => 1;

  @override
  int func(int value1, int value2) => value1 + value2;
}