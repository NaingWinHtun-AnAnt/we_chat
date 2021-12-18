import 'package:flutter/material.dart';
import 'package:we_chat/analytics/firebase_analytics_tracker.dart';
import 'package:we_chat/data/models/contact_model.dart';
import 'package:we_chat/data/models/contact_model_impl.dart';
import 'package:we_chat/data/models/user_model.dart';
import 'package:we_chat/data/models/user_model_impl.dart';
import 'package:we_chat/data/vos/contact_vo.dart';
import 'package:we_chat/network/firebase_constants.dart';

class ContactBloc extends ChangeNotifier {
  /// control dispose
  bool isDispose = false;

  /// states
  List<ContactVO>? contacts;

  /// models
  final ContactModel _contactModel = ContactModelImpl();
  final UserModel _userModel = UserModelImpl();

  ContactBloc() {
    _userModel.getUser().then(
          (value) => _contactModel.getContact(value.id ?? "").listen(
            (event) {
              contacts = event;
              _notifySafety();
            },
          ),
        );

    /// log contact list page reach
    FirebaseAnalyticsTracker().logEvent(contactScreenReached);
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
