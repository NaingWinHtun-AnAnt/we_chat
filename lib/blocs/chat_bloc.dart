import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:we_chat/data/models/chat_model.dart';
import 'package:we_chat/data/models/chat_model_impl.dart';
import 'package:we_chat/data/models/user_model.dart';
import 'package:we_chat/data/models/user_model_impl.dart';
import 'package:we_chat/data/vos/message_vo.dart';
import 'package:we_chat/data/vos/user_vo.dart';

class ChatBloc extends ChangeNotifier {
  /// control dispose
  bool isDispose = false;

  /// states
  List<MessageVO>? messageList;
  String? text;
  UserVO? loginUser;
  File? selectedFile;
  bool isVideoFile = false;

  /// models
  final ChatModel _chatModel = ChatModelImpl();
  final UserModel _userModel = UserModelImpl();

  ChatBloc(String contactUserId) {
    _userModel.getUser().then((value) {
      loginUser = value;
      _notifySafety();

      /// user my user out of getUser block
      /// user is null
      _chatModel
          .getMessages(
        loginUser?.id ?? "",
        contactUserId,
      )
          .listen(
        (event) {
          messageList = event.reversed.toList();
          _notifySafety();
        },
      );
    });
  }

  void onMessageTextChange(String message) {
    text = message;
  }

  void onFileSelected(File filePath, bool isVideo) {
    selectedFile = filePath;
    isVideoFile = isVideo;
    _notifySafety();
  }

  void onSelectedFileDelete() {
    selectedFile = null;
    isVideoFile = false;
    _notifySafety();
  }

  Future onTapSendMessage(
      String contactUserId, String contactUserName, String contactProfilePath) {
    /// send message
    return _chatModel
        .sendMessage(
      loginUser?.id ?? "",
      contactUserId,
      contactUserName,
      contactProfilePath,
      text,
      selectedFile,
      isVideoFile,
    )
        .then((value) {
      text = null;
      selectedFile = null;
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
