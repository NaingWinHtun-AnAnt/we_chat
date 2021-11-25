import 'dart:io';

import 'package:we_chat/data/vos/comment_vo.dart';
import 'package:we_chat/data/vos/like_vo.dart';
import 'package:we_chat/data/vos/moment_vo.dart';

abstract class WeChatCloudFireStoreDataAgent {
  /// create moment
  Future<void> createMoment(MomentVO moment);

  /// add new comment
  Future<void> addNewComment(int momentId, CommentVO comment);

  /// add like
  Future<void> addMomentLike(int momentId, LikeVO like);

  /// get all moments
  Stream<List<MomentVO>> getMoments();

  /// retrieve all comments for moment
  Stream<List<CommentVO>> getMomentComment(int momentId);

  /// retrieve likes for moment
  Stream<List<LikeVO>> getMomentLike(int momentId);

  /// get moment by id
  Stream<MomentVO> getMoment(int momentId);

  /// delete moment
  Future<void> deleteMoment(int momentId);

  /// upload moment image
  Future<String> uploadFileToFirebaseStorage(File file, String folderName);
}
