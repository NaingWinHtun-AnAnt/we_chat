import 'package:flutter/material.dart';
import 'package:we_chat/analytics/firebase_analytics_tracker.dart';
import 'package:we_chat/data/models/moment_model.dart';
import 'package:we_chat/data/models/moment_model_impl.dart';
import 'package:we_chat/data/models/notification_model.dart';
import 'package:we_chat/data/models/notification_model_impl.dart';
import 'package:we_chat/data/models/user_model.dart';
import 'package:we_chat/data/models/user_model_impl.dart';
import 'package:we_chat/data/vos/comment_vo.dart';
import 'package:we_chat/data/vos/like_vo.dart';
import 'package:we_chat/data/vos/moment_vo.dart';
import 'package:we_chat/data/vos/user_vo.dart';
import 'package:we_chat/network/firebase_constants.dart';
import 'package:we_chat/network/request/data_request.dart';
import 'package:we_chat/network/request/notification_request.dart';
import 'package:we_chat/network/request/send_notification_request.dart';
import 'package:we_chat/resources/strings.dart';

class MomentDetailBloc extends ChangeNotifier {
  /// controls
  bool isDispose = false;
  bool isLoading = false;

  /// states
  UserVO? _loginUser;
  bool isCommentMode = false;
  bool alreadyLike = false;
  MomentVO? moment;
  String? newComment;
  List<CommentVO>? commentUserList;
  List<LikeVO>? likeUserList;

  /// models
  final MomentModel _mMomentModel = MomentModelImpl();
  final UserModel _mUserModel = UserModelImpl();
  final NotificationModel _mNotificationModel = NotificationModelImpl();
  final FirebaseAnalyticsTracker _analyticsTracker = FirebaseAnalyticsTracker();

  MomentDetailBloc(int momentId, bool commentMode) {
    isCommentMode = commentMode;
    _notifySafety();

    /// get moment
    _mMomentModel.getMoment(momentId).listen((event) {
      moment = event;
      _notifySafety();
    });

    /// comment list for moment
    _mMomentModel.getMomentComment(momentId).listen((event) {
      commentUserList = event;
      _notifySafety();
    });

    /// like list for moment
    _mMomentModel.getMomentLike(momentId).listen((event) {
      likeUserList = event;
      _notifySafety();

      /// get login user in order to do later process for giving like or comment
      _mUserModel.getUser().then((value) {
        _loginUser = value;
        alreadyLike =
            likeUserList?.map((e) => e.id).contains(_loginUser?.id) ?? false;
        _notifySafety();
      });
    });

    /// log moment detail reach
    FirebaseAnalyticsTracker().logEvent(momentDetailScreenReached);
  }

  /// give a like
  /// id must be login user's cause like should be toggle on user's action
  void onTapLike(int momentId) {
    /// remove like in both sub-collection(like) first
    /// and remove like from moment
    if (alreadyLike) {
      _mMomentModel
          .removeMomentLike(momentId, _loginUser?.id ?? "")
          .then((value) {
        /// sure that at least one like exist as "alreadyLike" is true
        moment?.like?.removeLast();
        _mMomentModel.editMoment(moment);
      }).then(
        (value) =>

            /// log remove moment like from detail screen
            _analyticsTracker.logEvent(
          removeMomentLikeFromMomentDetailScreenAction,
          parameters: {logMomentId: "$momentId"},
        ),
      );
      alreadyLike = false;
      _notifySafety();
    } else {
      final _like = LikeVO(
        id: _loginUser?.id ?? "",
        userName: _loginUser?.userName,
      );

      /// add new like to moment sub-collection('like') first
      /// and add like to moment object
      _mMomentModel.addMomentLike(momentId, _like).then((value) {
        alreadyLike = true;
        _notifySafety();
      }).then((value) {
        /// limit at most 3 likes in moment
        if ((moment?.like?.length ?? 0) < 3) {
          /// prepopulate moment object depend on like attribute state if null
          if (moment?.like == null || (moment?.like?.isEmpty ?? false)) {
            moment?.like = [_like];
          } else {
            moment?.like?.insert(moment?.like?.length ?? 0, _like);
          }

          /// add like to moment
          _mMomentModel.editMoment(moment);
        }

        /// send notification
        _sendNotification(
          momentId,
          messageTitle: likeNotificationTitle,
          messageBody: likeNotificationBody,
        );

        /// log send like notification event from moment detail
        _analyticsTracker.logEvent(
          sendLikeNotificationFromMomentDetailScreenAction,
          parameters: {
            logMomentCreatorId: moment?.userId ?? "",
            logMomentId: "${moment?.id}",
            logUserId: _loginUser?.id ?? "",
          },
        );
      }).then(
        (value) =>

            /// log moment like from detail screen
            _analyticsTracker.logEvent(
          addMomentLikeFromMomentDetailScreenAction,
          parameters: {logMomentId: "$momentId"},
        ),
      );
    }
  }

  /// change mode for hide or show comment text field
  void onTapComment(bool commentMode) {
    isCommentMode = !commentMode;
    _notifySafety();
  }

  /// comment text change
  void onNewCommentTextChanged(String value) {
    newComment = value;
  }

  /// give a comment
  void onTapCommentToAddNewComment(int momentId) {
    final _comment = CommentVO(
      id: "${DateTime.now().millisecondsSinceEpoch}",
      comment: newComment,
      userName: _loginUser?.userName,
    );

    /// add new comment for moment sub-collection('comments') first
    _mMomentModel.addNewComment(momentId, _comment).then((value) {
      isCommentMode = false;
      _notifySafety();
    }).then((value) {
      /// add comment to moment object
      /// max comment is 3
      if ((moment?.comment?.length ?? 0) < 3) {
        moment?.comment?.insert(moment?.comment?.length ?? 0, _comment);
        _mMomentModel.editMoment(moment);
      }
    }).then((value) {
      /// send notification
      _sendNotification(
        momentId,
        messageTitle: commentNotificationTitle,
        messageBody: commentNotificationBody,
      );

      /// log send comment notification event from moment detail
      _analyticsTracker.logEvent(
        sendCommentNotificationAction,
        parameters: {
          logMomentCreatorId: moment?.userId ?? "",
          logMomentId: "${moment?.id}",
          logUserId: _loginUser?.id ?? "",
        },
      );
    }).then(
      (value) =>

          /// log add moment comment
          _analyticsTracker.logEvent(
        addNewMomentCommentAction,
        parameters: {logMomentId: "$momentId"},
      ),
    );
  }

  void _sendNotification(
    int momentId, {
    required String messageTitle,
    required String messageBody,
  }) {
    /// check if user interact with own moment
    if (_loginUser?.id != moment?.userId) {
      /// get moment owner fcm token and
      /// craft notification and send to moment owner
      /// if login userId and moment userId are different
      _mUserModel.getUserById(moment?.userId ?? "").listen((momentUser) {
        _craftNotification(
          momentId: momentId,
          fcmToken: momentUser.fcmToken ?? "",
          messageTitle: messageTitle,
          messageBody: "${_loginUser?.userName} $messageBody",
        ).then((notification) {
          if (notification != null) {
            _mNotificationModel.sendNotification(notification);
          }
        });
      });
    }
  }

  /// craft notification
  Future<SendNotificationRequest?> _craftNotification({
    required int momentId,
    required String fcmToken,
    required String messageTitle,
    required String messageBody,
  }) {
    final SendNotificationRequest _notification = SendNotificationRequest(
      registrationIds: [fcmToken],
      notification: NotificationRequest(
        title: messageTitle,
        body: messageBody,
      ),
      dataRequest: DataRequest(
        title: messageTitle,
        body: messageBody,
        momentId: momentId,
      ),
    );

    return Future.value(_notification);
  }

  void _notifySafety() {
    if (!isDispose) notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    isDispose = true;
  }
}
