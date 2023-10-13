import 'package:flutter/material.dart';

class LayoutProvider extends ChangeNotifier {

  bool _isMillisecondsOn = false;
  bool get isMillisecondsOn => _isMillisecondsOn;

  void toggleMilliseconds() {
    _isMillisecondsOn = !_isMillisecondsOn;
    print(_isMillisecondsOn);
    notifyListeners();
  }
}