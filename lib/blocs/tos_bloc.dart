import 'package:flutter/material.dart';

class TOSBloc extends ChangeNotifier {
  bool isDispose = false;
  bool isAgreeToTOS = false;

  void onTapAgreeToTOS(bool value) {
    isAgreeToTOS = value;
    _notifySafety();
  }

  void _notifySafety() {
    if (!isDispose) notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    isDispose = true;
  }
}
