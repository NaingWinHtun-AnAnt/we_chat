import 'dart:io';

import 'package:flutter/material.dart';
import 'package:we_chat/data/dummy_data.dart';
import 'package:we_chat/data/vos/region_vo.dart';
import 'package:we_chat/data/vos/user_vo.dart';

class SignUpBloc extends ChangeNotifier {
  bool isDispose = false;
  bool isAgreeToTOS = false;
  String email = "";

  /// states
  File? chosenFile;
  UserVO? user = UserVO(region: dummyRegionList.first.name);
  RegionVO region = dummyRegionList.first;

  void onImageSelect(File selectedImage) {
    chosenFile = selectedImage;
    _notifySafety();
  }

  void onEmailChanged(String email) {
    this.email = email;
  }

  void onUserNameChanged(String userName) {
    user?.userName = userName;
  }

  void onUserRegionChanged(RegionVO region) {
    this.region = region;
    user?.region = region.name;
    _notifySafety();
  }

  void onPhoneNumberChanged(String phoneNumber) {
    user?.phoneNumber = phoneNumber;
  }

  void onPasswordChanged(String password) {
    user?.password = password;
  }

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
