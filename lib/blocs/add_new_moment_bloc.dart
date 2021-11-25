import 'dart:io';

import 'package:flutter/material.dart';
import 'package:we_chat/data/models/moment_model.dart';
import 'package:we_chat/data/models/moment_model_impl.dart';
import 'package:we_chat/data/vos/moment_vo.dart';

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
      return _mMomentModel.editMoment(moment!, chosenFile);
    } else {
      return Future.error("Edit Moment Null Error!!");
    }
  }

  Future<void> _createNewMoment() => _mMomentModel.createMoment(
        content,
        chosenFile,
        isVideoFile,
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
