import 'dart:io';

import 'package:we_chat/data/vos/comment_vo.dart';
import 'package:we_chat/data/vos/like_vo.dart';
import 'package:we_chat/data/vos/moment_vo.dart';

abstract class MomentModel {
  /// create moment with file(optional)
  Future<void> createMoment(String userId, String userName, String content,
      File? file, bool isVideoFile);

  /// edit moment with file(optional)
  Future<void> editMoment(MomentVO? moment, {File? file});

  /// get all moments
  Stream<List<MomentVO>> getAllMoments();

  /// get moment by id
  Stream<MomentVO> getMoment(int momentId);

  /// get all comments for moment
  Future<void> deleteMoment(int momentId);

  /// add comment for moment
  Future<void> addNewComment(int momentId, CommentVO comment);

  /// give a like for moment
  Future<void> addMomentLike(int momentId, LikeVO like);

  /// give a like for moment
  Future<void> removeMomentLike(int momentId, String likeId);

  /// get all comments for moment
  Stream<List<CommentVO>> getMomentComment(int momentId);

  /// get all comments for moment
  Stream<List<LikeVO>> getMomentLike(int momentId);
}
