import 'Jump.dart';

class TrueJump extends Jump {
  @override
  int get code => 5;

  @override
  bool shouldJump(int value) => value != 0;
}