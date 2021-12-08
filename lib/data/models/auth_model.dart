import 'dart:io';

import 'package:we_chat/data/vos/user_vo.dart';

abstract class AuthModel {
  Future<void> registerNewUser(
    UserVO? user,
    File? chosenFile,
  );

  Future login(String email, String password);

  bool isLogin();

  Future<void> logOut();
}
