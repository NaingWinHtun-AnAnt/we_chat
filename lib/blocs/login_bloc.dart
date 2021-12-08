import 'package:flutter/material.dart';
import 'package:we_chat/data/dummy_data.dart';
import 'package:we_chat/data/models/auth_model.dart';
import 'package:we_chat/data/models/auth_model_impl.dart';
import 'package:we_chat/data/vos/region_vo.dart';

class LoginBloc extends ChangeNotifier {
  /// controls
  bool isDispose = false;
  bool isLoading = false;

  /// states
  String email = "";
  RegionVO region = dummyRegionList.first;
  String password = "";

  /// models
  final AuthModel _authModel = AuthModelImpl();

  Future onTapLogin() {
    _showLoading();
    return _authModel.login(email, password).whenComplete(
          () => _hideLoading(),
        );
  }

  void onEmailChanged(String email) {
    this.email = email;
  }

  void onRegionChanged(RegionVO value) {
    region = value;
    _notifySafety();
  }

  void onPasswordChanged(String password) {
    this.password = password;
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
