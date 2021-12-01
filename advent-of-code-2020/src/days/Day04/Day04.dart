import '../Day.dart';

class Day04 implements Day {
  final List<String> _input;

  Day04(this._input);

  @override
  part1() {
    var batch = _Batch(_input);
    return batch.passports.where((p) => p.IsFull()).length;
  }

  @override
  part2() {
    var batch = _Batch(_input);
    return batch.passports.where((p) => p.IsValid()).length;
  }
}

class _Batch {
  final List<_Passport> passports = List<_Passport>();

  _Batch(List<String> input) {
    var foo = input.expand((l) => l.split(" ")).toList();
    var passport = _Passport();
    passports.add(passport);
    for (var info in foo) {
      if (info.isEmpty) {
        passport = _Passport();
        passports.add(passport);
      } else {
        passport.SetInfo(info);
      }
    }
  }
}

class _Passport {
  _Year birthYear = _Year(1920, 2002);
  _Year issueYear = _Year(2010, 2020);
  _Year expirationYear = _Year(2020, 2030);
  _Height height = _Height(150, 193, 59, 76);
  _ExpressionField hairColor = _ExpressionField(r"^#[0-9a-fA-F]{6}$");
  _ExpressionField eyeColor = _ExpressionField(r"^(amb|blu|brn|gry|grn|hzl|oth)$");
  _ExpressionField passportId = _ExpressionField(r"^[\d]{9}$");
  String countryId;

  void SetInfo(String info) {
    var exp = RegExp(r"(.+):(.+)");
    var matches = exp
        .firstMatch(info)
        .groups([1, 2]);
    switch (matches[0]) {
      case "byr":
        birthYear.SetInfo(matches[1]);
        break;
      case "iyr":
        issueYear.SetInfo(matches[1]);
        break;
      case "eyr":
        expirationYear.SetInfo(matches[1]);
        break;
      case "hgt":
        height.SetInfo(matches[1]);
        break;
      case "hcl":
        hairColor.SetInfo(matches[1]);
        break;
      case "ecl":
        eyeColor.SetInfo(matches[1]);
        break;
      case "pid":
        passportId.SetInfo(matches[1]);
        break;
      case "cid":
        countryId = matches[1];
      break;
    }
  }

  bool IsValid() {
    return birthYear.IsValid()
      && issueYear.IsValid()
      && expirationYear.IsValid()
      && height.IsValid()
      && hairColor.IsValid()
      && eyeColor.IsValid()
      && passportId.IsValid();
  }

  bool IsFull() {
    return birthYear.HasValue()
      && issueYear.HasValue()
      && expirationYear.HasValue()
      && height.HasValue()
      && hairColor.HasValue()
      && eyeColor.HasValue()
      && passportId.HasValue();
  }
}

abstract class _Field {
  String _info;
  void SetInfo(String info) {
    _info = info;
  }
  bool IsValid();
  bool HasValue() {
    return _info != null;
  }
}

class _Year extends _Field {
  final int min;
  final int max;
  int value;

  _Year(this.min, this.max) : value = null;

  @override
  bool IsValid() {
    return value != null && min <= value && value <= max;
  }

  @override
  void SetInfo(String info) {
    super.SetInfo(info);
    value = int.tryParse(info);
  }
}

class _Height extends _Field {
  final int minCm;
  final int maxCm;
  final int minIn;
  final int maxIn;
  _Measure __measure;
  int value;

  _Height(this.minCm, this.maxCm, this.minIn, this.maxIn) : value = null;

  @override
  bool IsValid() {
    if (value == null || __measure == null) {
      return false;
    }


    switch (__measure) {
      case _Measure.centimeters:
        return minCm <= value && value <= maxCm;
      case _Measure.inches:
        return minIn <= value && value <= maxIn;
    }

    return false;
  }

  @override
  void SetInfo(String info) {
    super.SetInfo(info);
    var exp = RegExp(r"([\d]+)(in|cm)");
    var matches = exp.firstMatch(info);
    if (matches != null) {
      var groups = matches.groups([1, 2]);
      value = int.tryParse(groups[0]);
      switch (groups[1]) {
        case "cm":
          __measure = _Measure.centimeters;
          break;
        case "in":
          __measure = _Measure.inches;
          break;
      }
    }
  }
}

enum _Measure {
  centimeters, inches
}

class _ExpressionField extends _Field {
  final String exp;
  String value;

  _ExpressionField(this.exp) : value = null;

  @override
  bool IsValid() {
    var exp = RegExp(this.exp);
    return value != null && exp.hasMatch(value);
  }

  @override
  void SetInfo(String info) {
    super.SetInfo(info);
    value = info;
  }
}