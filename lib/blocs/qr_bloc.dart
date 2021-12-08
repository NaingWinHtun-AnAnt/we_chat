import 'package:flutter/cupertino.dart';
import 'package:we_chat/data/models/contact_model.dart';
import 'package:we_chat/data/models/contact_model_impl.dart';
import 'package:we_chat/data/models/user_model.dart';
import 'package:we_chat/data/models/user_model_impl.dart';
import 'package:we_chat/data/vos/contact_vo.dart';
import 'package:we_chat/data/vos/user_vo.dart';

class QrBloc extends ChangeNotifier {
  /// control
  bool isDispose = false;
  bool isScannerMode = false;

  /// states
  UserVO? user;

  /// model
  final UserModel _mUserModel = UserModelImpl();
  final ContactModel _mContactModel = ContactModelImpl();

  QrBloc() {
    _mUserModel.getUser().then((value) {
      user = value;
      _notifySafety();
    });
  }

  void onTapScanner(bool value) {
    isScannerMode = !value;
    _notifySafety();
  }

  /// add friend
  Future<void> onGetUserAndAddToContact(String userId) {
    return _mUserModel.getUserById(userId).listen((event) {
      _mContactModel.addContact(
          user?.id ?? "",
          ContactVO(
            id: event.id ?? "",
            userName: event.userName,
            email: event.email,
            imagePath: event.imagePath,
            organization: event.organization,
          ));
    }).asFuture();
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
