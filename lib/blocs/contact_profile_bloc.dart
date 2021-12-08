import 'package:flutter/material.dart';
import 'package:we_chat/data/models/conversation_model.dart';
import 'package:we_chat/data/models/conversation_model_impl.dart';
import 'package:we_chat/data/models/user_model.dart';
import 'package:we_chat/data/models/user_model_impl.dart';
import 'package:we_chat/data/vos/conversation_vo.dart';
import 'package:we_chat/data/vos/user_vo.dart';
import 'package:we_chat/resources/strings.dart';

class ContactProfileBloc extends ChangeNotifier {
  /// control dispose
  bool isDispose = false;

  /// states
  UserVO? user;

  /// models
  final UserModel _userModel = UserModelImpl();
  final ConversationModel _conversationModel = ConversationModelImpl();

  ContactProfileBloc(String userId) {
    _userModel.getUserById(userId).listen((event) {
      user = event;
      _notifySafety();
    });
  }

  Future<ConversationVO> onCreateNewConversation(String userId) {
    final newConversation = ConversationVO(
      id: DateTime.now().millisecondsSinceEpoch,
      userName: user?.userName ?? "Naing Win Htun",
      profilePath: user?.imagePath ?? dummyNetworkImage,
    );
    return _conversationModel
        .createConversation(userId, newConversation)
        .then((value) => newConversation);
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
