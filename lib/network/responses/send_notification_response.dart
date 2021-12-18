import 'package:json_annotation/json_annotation.dart';

part 'send_notification_response.g.dart';

@JsonSerializable()
class SendNotificationResponse {
  @JsonKey(name: "multicast_id")
  int? multicastId;

  @JsonKey(name: "success")
  int? success;

  @JsonKey(name: "failure")
  int? failure;

  @JsonKey(name: "canonical_ids")
  int? canonicalIds;

  SendNotificationResponse({
    this.multicastId,
    this.success,
    this.failure,
    this.canonicalIds,
  });

  factory SendNotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$SendNotificationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SendNotificationResponseToJson(this);
}
