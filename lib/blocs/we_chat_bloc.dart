import 'package:flutter/material.dart';
import 'package:we_chat/data/models/conversation_model.dart';
import 'package:we_chat/data/models/conversation_model_impl.dart';
import 'package:we_chat/data/vos/conversation_vo.dart';
import 'package:we_chat/network/firebase_constants.dart';

class WeChatBloc extends ChangeNotifier {
  /// dispose control
  bool isDispose = false;

  /// states
  List<ConversationVO>? conversationList;

  /// model
  final ConversationModel _mConversationModel = ConversationModelImpl();

  WeChatBloc() {
    _mConversationModel.getConversations(myId).listen((event) {
      conversationList = event;
      _notifySafety();
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
