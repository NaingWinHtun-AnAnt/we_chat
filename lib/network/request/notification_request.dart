import 'package:json_annotation/json_annotation.dart';

part 'notification_request.g.dart';

@JsonSerializable()
class NotificationRequest {
  @JsonKey(name: "title")
  String title;

  @JsonKey(name: "body")
  String body;

  @JsonKey(name: "priority")
  String? priority;

  @JsonKey(name: "content_available")
  bool? contentAvailable;

  NotificationRequest({
    required this.title,
    required this.body,
    this.priority = "high",
    this.contentAvailable = true,
  });

  factory NotificationRequest.fromJson(Map<String, dynamic> json) =>
      _$NotificationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationRequestToJson(this);
}
