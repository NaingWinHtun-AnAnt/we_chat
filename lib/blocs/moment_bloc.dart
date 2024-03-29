import 'package:flutter/cupertino.dart';
import 'package:we_chat/analytics/firebase_analytics_tracker.dart';
import 'package:we_chat/data/models/moment_model.dart';
import 'package:we_chat/data/models/moment_model_impl.dart';
import 'package:we_chat/data/models/notification_model.dart';
import 'package:we_chat/data/models/notification_model_impl.dart';
import 'package:we_chat/data/models/user_model.dart';
import 'package:we_chat/data/models/user_model_impl.dart';
import 'package:we_chat/data/vos/like_vo.dart';
import 'package:we_chat/data/vos/moment_vo.dart';
import 'package:we_chat/data/vos/user_vo.dart';
import 'package:we_chat/network/firebase_constants.dart';
import 'package:we_chat/network/request/data_request.dart';
import 'package:we_chat/network/request/notification_request.dart';
import 'package:we_chat/network/request/send_notification_request.dart';
import 'package:we_chat/resources/strings.dart';

class MomentBloc extends ChangeNotifier {
  /// control dispose
  bool isDispose = false;

  /// states
  UserVO? loginUser;
  List<MomentVO>? momentList;

  /// models
  final MomentModel _momentModel = MomentModelImpl();
  final UserModel _mUserModel = UserModelImpl();
  final NotificationModel _mNotificationModel = NotificationModelImpl();
  final FirebaseAnalyticsTracker _analyticsTracker = FirebaseAnalyticsTracker();

  MomentBloc() {
    /// get all moments
    _momentModel.getAllMoments().listen((event) {
      momentList = event;
      _notifySafety();
    });

    /// get login user for further process
    _mUserModel.getUser().then((value) {
      loginUser = value;
      _notifySafety();
    });

    /// log moment list page reach
    FirebaseAnalyticsTracker().logEvent(momentListScreenReached);
  }

  /// add like to sub-collection('like') and moment
  void onTapMomentLike(MomentVO moment) {
    if (!moment.like!.map((e) => e.id).contains(loginUser?.id)) {
      final _like = LikeVO(
        id: loginUser?.id ?? "",
        userName: loginUser?.userName,
      );
      _momentModel.addMomentLike(moment.id, _like).then((value) {
        /// limit at most 3 like to moment object
        if ((moment.like?.length ?? 0) < 3) {
          /// prepopulate moment object depend on like attribute state if null
          if (moment.like == null || (moment.like?.isEmpty ?? true)) {
            moment.like = [_like];
          } else {
            moment.like?.insert(moment.like?.length ?? 0, _like);
          }
        }

        /// add comment to moment
        _momentModel.editMoment(moment).then((value) {
          /// send notification to moment creator not by itself
          if (loginUser?.id != moment.userId) {
            _sendNotification(
              moment,
              messageTitle: likeNotificationTitle,
              messageBody: likeNotificationBody,
            );
          }
        });
      }).then(
        (value) =>

            /// log give a like to moment from moment screen
            _analyticsTracker.logEvent(
          addMomentLikeFromMomentListScreenAction,
          parameters: {logMomentId: "${moment.id}"},
        ),
      );
    } else {
      _momentModel
          .removeMomentLike(moment.id, loginUser?.id ?? "")
          .then((value) {
        /// at least one like is exist is sure
        moment.like?.removeLast();
        _momentModel.editMoment(moment);
      }).then(
        (value) => _analyticsTracker.logEvent(
          removeMomentLikeFromMomentListScreenAction,
          parameters: {logMomentId: "${moment.id}"},
        ),
      );
    }
  }

  /// more option
  void onTapMomentDelete(int deleteMomentId) {
    _momentModel.deleteMoment(deleteMomentId).then(
          (value) =>

              /// log moment delete event
              _analyticsTracker.logEvent(
            deleteMomentAction,
            parameters: {logMomentId: "$deleteMomentId"},
          ),
        );
  }

  void _sendNotification(
    MomentVO? moment, {
    required String messageTitle,
    required String messageBody,
  }) {
    if (moment != null) {
      /// check if user interact with own moment
      if (loginUser?.id != moment.userId) {
        /// get moment owner fcm token and
        /// craft notification and send to moment owner
        /// if login userId and moment userId are different
        _mUserModel.getUserById(moment.userId ?? "").listen((momentUser) {
          _craftNotification(
            momentId: moment.id,
            fcmToken: momentUser.fcmToken ?? "",
            messageTitle: messageTitle,
            messageBody: "${loginUser?.userName} $messageBody",
          ).then((notification) {
            if (notification != null) {
              _mNotificationModel.sendNotification(notification)?.then(
                    (value) =>

                        /// log send like notification event from moment list
                        _analyticsTracker.logEvent(
                      sendLikeNotificationFromMomentListScreenAction,
                      parameters: {
                        logMomentCreatorId: moment.userId ?? "",
                        logMomentId: "${moment.id}",
                        logUserId: loginUser?.id ?? "",
                      },
                    ),
                  );
            }
          });
        });
      }
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
