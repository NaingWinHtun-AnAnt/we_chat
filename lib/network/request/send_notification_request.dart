import 'package:json_annotation/json_annotation.dart';
import 'package:we_chat/network/request/data_request.dart';
import 'package:we_chat/network/request/notification_request.dart';

part 'send_notification_request.g.dart';

@JsonSerializable()
class SendNotificationRequest {
  @JsonKey(name: "registration_ids")
  List<String> registrationIds;

  @JsonKey(name: "notification")
  NotificationRequest notification;

  @JsonKey(name: "data")
  DataRequest dataRequest;

  SendNotificationRequest({
    required this.registrationIds,
    required this.notification,
    required this.dataRequest,
  });

  factory SendNotificationRequest.fromJson(Map<String, dynamic> json) =>
      _$SendNotificationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SendNotificationRequestToJson(this);
}
