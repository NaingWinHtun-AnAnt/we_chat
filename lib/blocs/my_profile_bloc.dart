import 'package:flutter/cupertino.dart';
import 'package:we_chat/analytics/firebase_analytics_tracker.dart';
import 'package:we_chat/data/models/auth_model.dart';
import 'package:we_chat/data/models/auth_model_impl.dart';
import 'package:we_chat/data/models/user_model.dart';
import 'package:we_chat/data/models/user_model_impl.dart';
import 'package:we_chat/data/vos/user_vo.dart';
import 'package:we_chat/network/firebase_constants.dart';

class MyProfileBloc extends ChangeNotifier {
  /// control dispose
  bool isDispose = false;

  /// states
  UserVO? user;

  /// models
  final UserModel _mUserModel = UserModelImpl();
  final AuthModel _mAuthModel = AuthModelImpl();

  MyProfileBloc() {
    _mUserModel.getUser().then((value) {
      user = value;
      _notifySafety();
    });

    /// log my profile reach
    FirebaseAnalyticsTracker().logEvent(loginUserProfileScreenReached);
  }

  Future onTapLogout() {
    return _mAuthModel.logOut();
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
