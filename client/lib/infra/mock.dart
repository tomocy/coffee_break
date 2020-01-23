import 'dart:math';

class Mock {
  const Mock({this.randomToFail});

  final Random randomToFail;

  bool get doFail => randomToFail?.nextBool() ?? false;
}
