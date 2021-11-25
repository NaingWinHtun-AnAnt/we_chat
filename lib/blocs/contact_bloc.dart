import 'package:flutter/material.dart';
import 'package:we_chat/data/dummy_data.dart';
import 'package:we_chat/data/models/user_model.dart';
import 'package:we_chat/data/models/user_model_impl.dart';
import 'package:we_chat/data/vos/user_vo.dart';

class ContactBloc extends ChangeNotifier {
  /// control dispose
  bool isDispose = false;

  /// states
  List<UserVO>? contacts;

  /// models
  final UserModel _mUserModel = UserModelImpl();

  ContactBloc() {
    _mUserModel.getContactList().listen((event) {
      contacts = dummyContactList;
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
