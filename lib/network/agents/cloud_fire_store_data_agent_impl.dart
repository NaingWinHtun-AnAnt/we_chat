import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:we_chat/data/vos/comment_vo.dart';
import 'package:we_chat/data/vos/like_vo.dart';
import 'package:we_chat/data/vos/moment_vo.dart';
import 'package:we_chat/network/agents/we_chat_cloud_firestore_data_agent.dart';
import 'package:we_chat/network/firebase_constants.dart';

class CloudFireStoreDataAgentImpl extends WeChatCloudFireStoreDataAgent {
  /// Firebase Firestore instance
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  /// firebase storage
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  static final CloudFireStoreDataAgentImpl _singleton =
      CloudFireStoreDataAgentImpl._internal();

  factory CloudFireStoreDataAgentImpl() => _singleton;

  CloudFireStoreDataAgentImpl._internal();

  /// create moment
  @override
  Future<void> createMoment(MomentVO moment) {
    return _fireStore.collection(collectionMoments).doc("${moment.id}").set(
          moment.toJson(),
        );
  }

  /// add new comment
  @override
  Future<void> addNewComment(int momentId, CommentVO comment) {
    return _fireStore
        .collection(collectionMoments)
        .doc("$momentId")
        .collection(collectionComments)
        .doc("${comment.id}")
        .set(
          comment.toJson(),
        );
  }

  /// give a like
  @override
  Future<void> addMomentLike(int momentId, LikeVO like) {
    return _fireStore
        .collection(collectionMoments)
        .doc("$momentId")
        .collection(collectionLikes)
        .doc("${like.id}")
        .set(
          like.toJson(),
        );
  }

  /// get moment list
  @override
  Stream<List<MomentVO>> getMoments() {
    return _fireStore.collection(collectionMoments).snapshots().map(
          (querySnapShot) => querySnapShot.docs
              .map(
                (queryDocumentSnapShot) => MomentVO.fromJson(
                  queryDocumentSnapShot.data(),
                ),
              )
              .toList(),
        );
  }

  @override
  Stream<List<CommentVO>> getMomentComment(int momentId) {
    return _fireStore
        .collection(collectionMoments)
        .doc("$momentId")
        .collection(collectionComments)
        .snapshots()
        .map(
          (querySnapShot) => querySnapShot.docs
              .map(
                (queryDocumentSnapShot) => CommentVO.fromJson(
                  queryDocumentSnapShot.data(),
                ),
              )
              .toList(),
        );
  }

  @override
  Stream<List<LikeVO>> getMomentLike(int momentId) {
    return _fireStore
        .collection(collectionMoments)
        .doc("$momentId")
        .collection(collectionLikes)
        .snapshots()
        .map(
          (querySnapShot) => querySnapShot.docs
              .map(
                (queryDocumentSnapShot) => LikeVO.fromJson(
                  queryDocumentSnapShot.data(),
                ),
              )
              .toList(),
        );
  }

  /// get single moment
  @override
  Stream<MomentVO> getMoment(int momentId) {
    return _fireStore
        .collection(collectionMoments)
        .doc("$momentId")
        .get()
        .asStream()
        .where((event) => event.data() != null)
        .map(
          (event) => MomentVO.fromJson(
            event.data()!,
          ),
        );
  }

  /// delete moment
  @override
  Future<void> deleteMoment(int momentId) {
    return _fireStore.collection(collectionMoments).doc("$momentId").delete();
  }

  /// upload moment image
  @override
  Future<String> uploadFileToFirebaseStorage(File file, String folderName) {
    return _firebaseStorage
        .ref(folderName)
        .child("${DateTime.now().millisecondsSinceEpoch}")
        .putFile(file)
        .then(
          (snapShot) => snapShot.ref.getDownloadURL(),
        );
  }
}
