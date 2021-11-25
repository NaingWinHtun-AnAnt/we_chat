import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:we_chat/data/models/chat_model.dart';
import 'package:we_chat/data/models/chat_model_impl.dart';
import 'package:we_chat/data/models/user_model.dart';
import 'package:we_chat/data/models/user_model_impl.dart';
import 'package:we_chat/data/vos/message_vo.dart';
import 'package:we_chat/data/vos/user_vo.dart';
import 'package:we_chat/network/firebase_constants.dart';

class ChatBloc extends ChangeNotifier {
  /// control dispose
  bool isDispose = false;

  /// states
  List<MessageVO>? messageList;
  String? text;
  UserVO? mMyUser;
  File? selectedFile;
  bool isVideoFile = false;

  /// models
  final ChatModel _chatModel = ChatModelImpl();
  final UserModel _userModel = UserModelImpl();

  ChatBloc(int conversationId) {
    _chatModel.getMessages(conversationId, myId).listen((event) {
      messageList = event.reversed.toList();
      _notifySafety();
    });

    _userModel.getUser()?.listen((event) {
      mMyUser = event;
      _notifySafety();
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

  Future onTapSendMessage(int conversationId) {
    final messageId = (messageList == null && (messageList?.isEmpty ?? true))
        ? 12345
        : (messageList?.length ?? 0) + 12345;
    if (text != null) {
      return _chatModel
          .sendMessage(
        messageId,
        conversationId,
        text,
        selectedFile,
        isVideoFile,
        myId,
      )
          .then((value) {
        text = null;
        selectedFile = null;
        _notifySafety();
      });
    } else {
      return Future.error("Empty Message Error!");
    }
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
