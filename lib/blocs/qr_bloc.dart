import 'package:flutter/cupertino.dart';
import 'package:we_chat/data/models/user_model.dart';
import 'package:we_chat/data/models/user_model_impl.dart';
import 'package:we_chat/data/vos/user_vo.dart';

class QrBloc extends ChangeNotifier {
  /// control
  bool isDispose = false;
  bool isScannerMode = false;

  /// states
  UserVO? user;

  /// model
  final UserModel _mUserModel = UserModelImpl();

  QrBloc() {
    _mUserModel.getUser()?.listen((event) {
      user = event;
      _notifySafety();
    });
  }

  void onTapScanner(bool value) {
    isScannerMode = !value;
    _notifySafety();
  }

  Future<void> onCreateNewContact(String? userId) {
    return _mUserModel.createContact(userId);
  }

  /// use notifyListener safely
  void _notifySafety() {
    if (!isDispose) notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    isDispose = true;
  }
}
