import 'dart:io';

import 'package:we_chat/data/vos/comment_vo.dart';
import 'package:we_chat/data/vos/contact_vo.dart';
import 'package:we_chat/data/vos/like_vo.dart';
import 'package:we_chat/data/vos/moment_vo.dart';
import 'package:we_chat/data/vos/user_vo.dart';

abstract class WeChatCloudFireStoreDataAgent {
  /// create moment
  Future<void> createMoment(MomentVO moment);

  /// add new comment
  Future<void> addNewComment(int momentId, CommentVO comment);

  /// add like
  Future<void> addMomentLike(int momentId, LikeVO like);

  /// remove like
  Future<void> removeMomentLike(int momentId, String likeId);

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

  /// register with user info
  Future registerNewUser(UserVO registerUser);

  /// login with email and password
  Future login(String email, String password);

  /// check if user is currently login
  bool isLogin();

  /// get current login user info
  Future<UserVO> getLoginUser();

  /// update login user fcm token after login
  void updateUserFcmToken(UserVO loginUser);

  /// get user by scan user id
  Stream<UserVO> getUserById(String userId);

  /// add contact
  Future<void> addContact(String userId, ContactVO contact);

  /// get contact list
  Stream<List<ContactVO>> getContact(String userId);

  /// logout
  Future<void> logOut();
}
