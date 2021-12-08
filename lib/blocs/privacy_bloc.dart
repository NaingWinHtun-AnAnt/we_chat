import 'package:flutter/material.dart';

class PrivacyBloc extends ChangeNotifier {
  bool isDispose = false;
  bool isAgreeToPrivacy = false;

  void onTapAgreeToPrivacy(bool value) {
    isAgreeToPrivacy = value;
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
