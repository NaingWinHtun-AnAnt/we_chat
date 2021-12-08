import 'dart:io';

import 'package:flutter/material.dart';
import 'package:we_chat/data/models/auth_model.dart';
import 'package:we_chat/data/models/auth_model_impl.dart';
import 'package:we_chat/data/vos/user_vo.dart';

class EmailVerifyBloc extends ChangeNotifier {
  bool isDispose = false;
  bool isLoading = false;

  /// states
  File? chosenFile;
  UserVO? user;
  String? email;

  /// models
  final AuthModel _authModel = AuthModelImpl();

  EmailVerifyBloc(UserVO? newUser, File? selectedFile) {
    user = newUser;
    chosenFile = selectedFile;
  }

  Future onTapOkToRegisterNewUser() {
    _showLoading();
    user?.email = email;
    return user != null
        ? _authModel.registerNewUser(user, chosenFile).whenComplete(
              () => _hideLoading(),
            )
        : Future.error("New User is null! Email Verify Bloc.");
  }

  void onEmailChange(String value) {
    email = value;
    _notifySafety();
  }

  void _showLoading() {
    isLoading = true;
    _notifySafety();
  }

  void _hideLoading() {
    isLoading = false;
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
