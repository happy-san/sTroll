import 'package:flutter/material.dart';

abstract class WorkingNotifier extends ChangeNotifier{
  bool _isWorking = false;

  bool get isWorking => _isWorking;

  set isWorking(bool val) {
    _isWorking = val;
    notifyListeners();
  }
}