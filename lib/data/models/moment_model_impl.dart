import 'dart:io';

import 'package:we_chat/data/models/moment_model.dart';
import 'package:we_chat/data/vos/comment_vo.dart';
import 'package:we_chat/data/vos/like_vo.dart';
import 'package:we_chat/data/vos/moment_vo.dart';
import 'package:we_chat/network/agents/cloud_fire_store_data_agent_impl.dart';
import 'package:we_chat/network/agents/we_chat_cloud_firestore_data_agent.dart';
import 'package:we_chat/network/firebase_constants.dart';
import 'package:we_chat/resources/strings.dart';

class MomentModelImpl extends MomentModel {
  /// data agent
  final WeChatCloudFireStoreDataAgent _dataAgent =
      CloudFireStoreDataAgentImpl();

  static final MomentModelImpl _singleton = MomentModelImpl._internal();

  factory MomentModelImpl() => _singleton;

  MomentModelImpl._internal();

  /// create your moment
  @override
  Future<void> createMoment(
    String userId,
    String userName,
    String? content,
    File? file,
    bool isVideoFile,
  ) {
    if (file != null) {
      return _dataAgent
          .uploadFileToFirebaseStorage(file, folderMomentFile)
          .then(
            (imageUrl) => craftMomentVO(userId, userName, content,
                    momentImageUrl: imageUrl, isVideoFile: isVideoFile)
                .then(
              (value) => _dataAgent.createMoment(value),
            ),
          );
    } else {
      return craftMomentVO(userId, userName, content, isVideoFile: isVideoFile)
          .then(
        (value) => _dataAgent.createMoment(value),
      );
    }
  }

  /// get all moments
  @override
  Stream<List<MomentVO>> getAllMoments() {
    return _dataAgent.getMoments();
  }

  /// get a single moment
  @override
  Stream<MomentVO> getMoment(int momentId) {
    return _dataAgent.getMoment(momentId);
  }

  @override
  Future<void> editMoment(MomentVO? moment, {File? file}) {
    if (file != null) {
      return _dataAgent
          .uploadFileToFirebaseStorage(file, folderMomentFile)
          .then((imageUrl) {
        moment?.momentFileUrl = imageUrl;
        if (moment != null) _dataAgent.createMoment(moment);
      });
    } else {
      if (moment != null) {
        return _dataAgent.createMoment(moment);
      } else {
        return Future.error("moment edit with null");
      }
    }
  }

  /// delete moment
  @override
  Future<void> deleteMoment(int momentId) {
    return _dataAgent.deleteMoment(momentId);
  }

  /// add your comment for moment
  @override
  Future<void> addNewComment(int momentId, CommentVO comment) {
    return _dataAgent.addNewComment(momentId, comment);
  }

  /// retrieve comment
  @override
  Stream<List<CommentVO>> getMomentComment(int momentId) {
    return _dataAgent.getMomentComment(momentId);
  }

  /// give a like to moment
  @override
  Future<void> addMomentLike(int momentId, LikeVO like) {
    return _dataAgent.addMomentLike(momentId, like);
  }

  @override
  Future<void> removeMomentLike(int momentId, String likeId) {
    return _dataAgent.removeMomentLike(momentId, likeId);
  }

  /// retrieve likes
  @override
  Stream<List<LikeVO>> getMomentLike(int momentId) {
    return _dataAgent.getMomentLike(momentId);
  }

  Future<MomentVO> craftMomentVO(
    String userId,
    String userName,
    String? content, {
    String? momentImageUrl,
    required bool isVideoFile,
  }) {
    if (content != null) {
      final moment = MomentVO(
        id: DateTime.now().millisecondsSinceEpoch,
        userId: userId,
        userName: userName,
        content: content,
        momentFileUrl: momentImageUrl,
        userImageUrl: dummyNetworkImage,
        uploadedTime: "${DateTime.now()}",
        isVideoFile: isVideoFile,
      );
      return Future.value(moment);
    } else {
      return Future.error("Create Moment Error in Moment Model.");
    }
  }
}
