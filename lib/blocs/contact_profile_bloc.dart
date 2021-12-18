import 'package:flutter/material.dart';
import 'package:we_chat/analytics/firebase_analytics_tracker.dart';
import 'package:we_chat/data/models/user_model.dart';
import 'package:we_chat/data/models/user_model_impl.dart';
import 'package:we_chat/data/vos/user_vo.dart';
import 'package:we_chat/network/firebase_constants.dart';

class ContactProfileBloc extends ChangeNotifier {
  /// control dispose
  bool isDispose = false;

  /// states
  UserVO? contactUser;

  /// models
  final UserModel _userModel = UserModelImpl();

  ContactProfileBloc(String contactUserId) {
    _userModel.getUserById(contactUserId).listen((event) {
      contactUser = event;
      _notifySafety();
    });

    /// log contact user profile page reach
    FirebaseAnalyticsTracker().logEvent(contactUserProfileScreenReached);
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
