import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:we_chat/data/vos/comment_vo.dart';
import 'package:we_chat/data/vos/contact_vo.dart';
import 'package:we_chat/data/vos/like_vo.dart';
import 'package:we_chat/data/vos/moment_vo.dart';
import 'package:we_chat/data/vos/user_vo.dart';
import 'package:we_chat/network/agents/we_chat_cloud_firestore_data_agent.dart';
import 'package:we_chat/network/firebase_constants.dart';

class CloudFireStoreDataAgentImpl extends WeChatCloudFireStoreDataAgent {
  static final CloudFireStoreDataAgentImpl _singleton =
      CloudFireStoreDataAgentImpl._internal();

  factory CloudFireStoreDataAgentImpl() => _singleton;

  CloudFireStoreDataAgentImpl._internal();

  /// Firebase Firestore instance
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  /// firebase storage
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  /// authentication
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

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
        .doc(comment.id)
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
        .doc(like.id)
        .set(
          like.toJson(),
        );
  }

  /// remove like
  @override
  Future<void> removeMomentLike(int momentId, String likeId) {
    return _fireStore
        .collection(collectionMoments)
        .doc("$momentId")
        .collection(collectionLikes)
        .doc(likeId)
        .delete();
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

  @override
  Future registerNewUser(UserVO registerUser) {
    return _firebaseAuth
        .createUserWithEmailAndPassword(
          email: registerUser.email ?? "",
          password: registerUser.password ?? "",
        )
        .then((userCredential) =>
            userCredential.user?..updateDisplayName(registerUser.userName))
        .then((user) {
      registerUser.id = user?.uid;
      registerUser.organization = "Comp/Org";
      _addNewUser(registerUser);
    });
  }

  Future<void> _addNewUser(UserVO registerUser) {
    return _fireStore.collection(collectionUsers).doc(registerUser.id).set(
          registerUser.toJson(),
        );
  }

  @override
  Future login(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<UserVO> getLoginUser() {
    return _fireStore
        .collection(collectionUsers)
        .doc(_firebaseAuth.currentUser?.uid)
        .get()
        .asStream()
        .where((event) => event.data() != null)
        .map(
          (event) => UserVO.fromJson(
            event.data()!,
          ),
        )
        .first;
  }

  /// update login user fcm token after login
  @override
  void updateUserFcmToken(UserVO loginUser) {
    _addNewUser(loginUser);
  }

  @override
  Stream<UserVO> getUserById(String userId) {
    return _fireStore
        .collection(collectionUsers)
        .doc(userId)
        .get()
        .asStream()
        .where((event) => event.data() != null)
        .map(
          (event) => UserVO.fromJson(
            event.data()!,
          ),
        );
  }

  @override
  Future<void> addContact(String userId, ContactVO contact) {
    return _fireStore
        .collection(collectionUsers)
        .doc(userId)
        .collection(collectionContacts)
        .doc(contact.id)
        .set(
          contact.toJson(),
        );
  }

  @override
  Stream<List<ContactVO>> getContact(String userId) {
    return _fireStore
        .collection(collectionUsers)
        .doc(userId)
        .collection(collectionContacts)
        .snapshots()
        .map(
          (querySnapShot) => querySnapShot.docs
              .map(
                (queryDocumentSnapShot) => ContactVO.fromJson(
                  queryDocumentSnapShot.data(),
                ),
              )
              .toList(),
        );
  }

  @override
  bool isLogin() {
    return _firebaseAuth.currentUser != null;
  }

  @override
  Future<void> logOut() {
    return _firebaseAuth.signOut();
  }
}
