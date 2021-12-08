import 'dart:io';

import 'package:we_chat/data/models/auth_model.dart';
import 'package:we_chat/data/vos/user_vo.dart';
import 'package:we_chat/network/agents/cloud_fire_store_data_agent_impl.dart';
import 'package:we_chat/network/agents/we_chat_cloud_firestore_data_agent.dart';
import 'package:we_chat/network/firebase_constants.dart';

class AuthModelImpl extends AuthModel {
  static final AuthModelImpl _singleton = AuthModelImpl._internal();

  factory AuthModelImpl() {
    return _singleton;
  }

  AuthModelImpl._internal();

  /// data agent
  final WeChatCloudFireStoreDataAgent _mDataAgent =
      CloudFireStoreDataAgentImpl();

  @override
  Future<void> registerNewUser(UserVO? user, File? chosenFile) {
    if (chosenFile != null) {
      return _mDataAgent
          .uploadFileToFirebaseStorage(chosenFile, folderProfileImageFile)
          .then((value) => _craftUserVO(user, imageUrl: value).then(
                (user) => _mDataAgent.registerNewUser(user),
              ));
    } else {
      return _craftUserVO(user).then(
        (user) => _mDataAgent.registerNewUser(user),
      );
    }
  }

  Future<UserVO> _craftUserVO(UserVO? user, {String? imageUrl}) {
    final newUser = user;
    if (imageUrl != null) {
      newUser?.imagePath = imageUrl;
    }
    return Future.value(newUser);
  }

  @override
  Future login(String email, String password) {
    return _mDataAgent.login(email, password);
  }

  @override
  bool isLogin() {
    return _mDataAgent.isLogin();
  }

  @override
  Future<void> logOut() {
    return _mDataAgent.logOut();
  }
}
