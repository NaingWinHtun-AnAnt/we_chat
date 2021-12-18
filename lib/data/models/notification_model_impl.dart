import 'package:we_chat/data/models/notification_model.dart';
import 'package:we_chat/network/agents/data_agent.dart';
import 'package:we_chat/network/agents/retrofit_data_agent_impl.dart';
import 'package:we_chat/network/request/send_notification_request.dart';
import 'package:we_chat/network/responses/send_notification_response.dart';

class NotificationModelImpl extends NotificationModel {
  static final NotificationModelImpl _singleton =
      NotificationModelImpl._internal();

  factory NotificationModelImpl() => _singleton;

  NotificationModelImpl._internal();

  /// data agent
  final DataAgent _dataAgent = RetrofitDataAgentImpl();

  @override
  Future<SendNotificationResponse?>? sendNotification(
      SendNotificationRequest notificationRequest) {
    return _dataAgent.sendNotification(notificationRequest);
  }
}
