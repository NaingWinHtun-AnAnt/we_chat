import 'dart:io';

import 'package:flutter/material.dart';
import 'package:we_chat/analytics/firebase_analytics_tracker.dart';
import 'package:we_chat/data/models/moment_model.dart';
import 'package:we_chat/data/models/moment_model_impl.dart';
import 'package:we_chat/data/models/user_model.dart';
import 'package:we_chat/data/models/user_model_impl.dart';
import 'package:we_chat/data/vos/moment_vo.dart';
import 'package:we_chat/network/firebase_constants.dart';

class AddNewMomentBloc extends ChangeNotifier {
  /// controls
  bool isDispose = false;
  bool isAddNewPostError = false;
  bool isLoading = false;
  bool isEditMode = false;

  /// states
  String content = "";
  File? chosenFile;
  bool isVideoFile = false;
  String? momentFileUrl;
  MomentVO? moment;

  /// models
  final MomentModel _mMomentModel = MomentModelImpl();
  final UserModel _mUserModel = UserModelImpl();

  /// analytics tracker
  final FirebaseAnalyticsTracker _analyticsTracker = FirebaseAnalyticsTracker();

  AddNewMomentBloc({int? momentId}) {
    if (momentId != null) {
      isEditMode = true;
      _mMomentModel.getMoment(momentId).listen((event) {
        moment = event;
        isVideoFile = event.isVideoFile;
        content = event.content ?? "";
        momentFileUrl = event.momentFileUrl;
        _notifySafety();
      });
    }

    /// log qrScreen reach
    FirebaseAnalyticsTracker().logEvent(createMomentScreenReached);
  }

  void onNewMomentTextChanged(String postDescription) {
    content = postDescription;
  }

  void onFileSelected(File imageFile, bool isVideo) {
    chosenFile = imageFile;
    isVideoFile = isVideo;
    _notifySafety();
  }

  void onTapDeleteImage() {
    chosenFile = null;
    isVideoFile = false;
    momentFileUrl = null;
    _notifySafety();
  }

  Future onCreateNewMoment() {
    if (content.isEmpty) {
      isAddNewPostError = true;
      _notifySafety();
      return Future.error("Error");
    } else {
      isLoading = true;
      _notifySafety();
      isAddNewPostError = false;
      if (isEditMode) {
        return _editMoment().then((value) {
          isLoading = false;
          _notifySafety();
        });
      } else {
        return _createNewMoment().then((value) {
          isLoading = false;
          _notifySafety();
        });
      }
    }
  }

  Future<void> _editMoment() {
    moment?.content = content;
    moment?.momentFileUrl = momentFileUrl;
    if (moment != null) {
      return _mMomentModel.editMoment(moment!, file: chosenFile).then(
            (value) => _analyticsTracker.logEvent(
              editMomentAction,
              parameters: {logMomentId: "${moment?.id}"},
            ),
          );
    } else {
      return Future.error("Edit Moment Null Error!!");
    }
  }

  Future<void> _createNewMoment() => _mUserModel.getUser().then(
        (user) => _mMomentModel
            .createMoment(
              user.id ?? "",
              user.userName ?? "",
              content,
              chosenFile,
              isVideoFile,
            )
            .then(
              (value) => _analyticsTracker.logEvent(
                addNewMomentAction,
                parameters: {logMomentCreatorId: user.id ?? ""},
              ),
            ),
      );

  void _notifySafety() {
    if (!isDispose) notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    isDispose = true;
  }
}
