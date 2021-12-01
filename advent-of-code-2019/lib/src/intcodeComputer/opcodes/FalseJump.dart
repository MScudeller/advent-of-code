import 'Jump.dart';

class FalseJump extends Jump {
  @override
  int get code => 6;

  @override
  bool shouldJump(int value) => value == 0;
}