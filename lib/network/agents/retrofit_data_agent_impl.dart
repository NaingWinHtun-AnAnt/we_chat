import 'package:dio/dio.dart';
import 'package:we_chat/network/agents/data_agent.dart';
import 'package:we_chat/network/api_constants.dart';
import 'package:we_chat/network/request/send_notification_request.dart';
import 'package:we_chat/network/responses/send_notification_response.dart';
import 'package:we_chat/network/we_chat_api.dart';

class RetrofitDataAgentImpl extends DataAgent {
  /// api
  WeChatApi? mApi;

  static final RetrofitDataAgentImpl _singleton =
      RetrofitDataAgentImpl._internal();

  factory RetrofitDataAgentImpl() => _singleton;

  RetrofitDataAgentImpl._internal() {
    final dio = Dio();
    dio.options = BaseOptions(headers: {
      paramAuthorization: valueAuthorization,
      paramContentType: valueContentType,
      paramAcceptEncoding: valueAcceptEncoding,
      paramConnection: valueConnection,
    });
    mApi = WeChatApi(dio);
  }

  /// send notification
  @override
  Future<SendNotificationResponse?>? sendNotification(
      SendNotificationRequest notificationRequest) {
    return mApi
        ?.sendNotification(notificationRequest)
        .asStream()
        .map((event) => event)
        .first;
  }
}
