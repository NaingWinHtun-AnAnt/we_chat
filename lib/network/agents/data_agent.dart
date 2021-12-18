import 'package:we_chat/network/request/send_notification_request.dart';
import 'package:we_chat/network/responses/send_notification_response.dart';

abstract class DataAgent {
  /// send notification
  Future<SendNotificationResponse?>? sendNotification(
    SendNotificationRequest notificationRequest,
  );
}
