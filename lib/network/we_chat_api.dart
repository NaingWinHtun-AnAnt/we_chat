import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:we_chat/network/api_constants.dart';
import 'package:we_chat/network/request/send_notification_request.dart';
import 'package:we_chat/network/responses/send_notification_response.dart';

part 'we_chat_api.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class WeChatApi {
  factory WeChatApi(Dio dio) = _WeChatApi;

  @POST(endPointNotificationSend)
  Future<SendNotificationResponse> sendNotification(
    @Body() SendNotificationRequest notificationRequest,
  );
}
