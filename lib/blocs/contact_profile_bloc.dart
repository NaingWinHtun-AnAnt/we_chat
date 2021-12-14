import 'package:flutter/material.dart';
import 'package:we_chat/data/models/user_model.dart';
import 'package:we_chat/data/models/user_model_impl.dart';
import 'package:we_chat/data/vos/user_vo.dart';

class ContactProfileBloc extends ChangeNotifier {
  /// control dispose
  bool isDispose = false;

  /// states
  UserVO? contactUser;

  /// models
  final UserModel _userModel = UserModelImpl();

  ContactProfileBloc(String contactUserId) {
    _userModel.getUserById(contactUserId).listen((event) {
      contactUser = event;
      _notifySafety();
    });
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
