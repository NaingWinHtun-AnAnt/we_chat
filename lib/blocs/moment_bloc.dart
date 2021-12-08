import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:we_chat/data/models/moment_model.dart';
import 'package:we_chat/data/models/moment_model_impl.dart';
import 'package:we_chat/data/vos/comment_vo.dart';
import 'package:we_chat/data/vos/like_vo.dart';
import 'package:we_chat/data/vos/moment_vo.dart';
import 'package:we_chat/resources/strings.dart';

class MomentBloc extends ChangeNotifier {
  /// control dispose
  bool isDispose = false;

  /// states
  List<MomentVO>? momentList;
  Map<int, List<CommentVO>?>? commentVOMap = {};
  Map<int, List<LikeVO>?>? likeVOMap = {};

  /// models
  final MomentModel _momentModel = MomentModelImpl();

  MomentBloc() {
    /// get all moments
    _momentModel.getAllMoments().listen((event) {
      momentList = event;

      /// get comment and like for each moment
      // TODO("map loop not ok")
      momentList?.forEach((element) {
        /// retrieve comments
        _momentModel.getMomentComment(element.id).listen((event) {
          commentVOMap?[element.id] = event;
          _notifySafety();
        });

        /// retrieve like
        _momentModel.getMomentLike(element.id).listen((event) {
          likeVOMap = {element.id: event};
          _notifySafety();
        });
      });
      _notifySafety();
    });
  }

  /// add comment to moment
  void onTapMomentLike(int momentId) {
    final dummyLike = LikeVO(
      id: DateTime.now().millisecondsSinceEpoch,
      userId: DateTime.now().millisecondsSinceEpoch,
      userName: "Naing Win Htun",
      imagePath: dummyNetworkImage,
    );
    _momentModel.addMomentLike(momentId, dummyLike);
  }

  /// add like to moment
  void onTapMomentComment(int momentId) {
    /// dummy comment
    final dummyComment = CommentVO(
      id: DateTime.now().millisecondsSinceEpoch,
      userName: "Naing Win Htun",
      comment: "${Random().nextInt(100)} Ok!!",
    );
    _momentModel.addNewComment(momentId, dummyComment);
  }

  /// more option
  void onTapMomentDelete(int momentId) {
    _momentModel.deleteMoment(momentId);
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
