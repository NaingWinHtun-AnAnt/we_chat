import 'package:flutter/material.dart';
import 'package:we_chat/analytics/firebase_analytics_tracker.dart';
import 'package:we_chat/data/models/contact_model.dart';
import 'package:we_chat/data/models/contact_model_impl.dart';
import 'package:we_chat/data/models/conversation_model.dart';
import 'package:we_chat/data/models/conversation_model_impl.dart';
import 'package:we_chat/data/models/user_model.dart';
import 'package:we_chat/data/models/user_model_impl.dart';
import 'package:we_chat/data/vos/message_vo.dart';
import 'package:we_chat/data/vos/user_vo.dart';
import 'package:we_chat/network/firebase_constants.dart';

class WeChatBloc extends ChangeNotifier {
  /// dispose control
  bool isDispose = false;

  /// states
  UserVO? user;
  String? contactProfilePath;
  List<MessageVO>? recentMessageList = [];

  /// model
  final UserModel _mUserModel = UserModelImpl();
  final ContactModel _mContactModel = ContactModelImpl();
  final ConversationModel _mConversationModel = ConversationModelImpl();

  WeChatBloc() {
    _mUserModel.getUser().then((loginUser) {
      _mContactModel.getContact(loginUser.id ?? "").listen((contactUser) {
        contactProfilePath = contactUser.first.imagePath;
        _notifySafety();
        _mConversationModel
            .getConversations(loginUser.id ?? "", contactUser.first.id)
            .listen((event) {
          recentMessageList?.clear();
          recentMessageList?.add(event);
          _notifySafety();
        });
      });
    });

    /// log we chat page reach event
    FirebaseAnalyticsTracker().logEvent(weChatScreenReached);
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
