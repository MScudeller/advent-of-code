import '../Opcode.dart';

class Error extends Opcode {
  int _code;

  @override
  int get code => _code;

  @override
  int get parameterQuantity => 0;

  Error(this._code);

  @override
  void run(Program program) {
    throw UnexpectedCodeException(code);
  }
}

class UnexpectedCodeException implements Exception {
  int code;

  UnexpectedCodeException(this.code);

  @override
  String toString() {
    return 'UnexpectedCodeException{code: $code}';
  }
}
