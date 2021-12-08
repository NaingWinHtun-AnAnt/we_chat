import 'package:flutter/material.dart';
import 'package:we_chat/data/models/conversation_model.dart';
import 'package:we_chat/data/models/conversation_model_impl.dart';
import 'package:we_chat/data/models/user_model.dart';
import 'package:we_chat/data/models/user_model_impl.dart';
import 'package:we_chat/data/vos/conversation_vo.dart';
import 'package:we_chat/data/vos/user_vo.dart';

class WeChatBloc extends ChangeNotifier {
  /// dispose control
  bool isDispose = false;

  /// states
  UserVO? user;
  List<ConversationVO>? conversationList;

  /// model
  final ConversationModel _mConversationModel = ConversationModelImpl();
  final UserModel _mUserModel = UserModelImpl();

  WeChatBloc() {
    _mUserModel.getUser().then((value) {
      _mConversationModel.getConversations(value.id ?? "").listen((event) {
        conversationList = event;
        _notifySafety();
      });
    });
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
