import 'package:json_annotation/json_annotation.dart';

part 'data_request.g.dart';

@JsonSerializable()
class DataRequest {
  @JsonKey(name: "title")
  String title;

  @JsonKey(name: "body")
  String body;

  @JsonKey(name: "priority")
  String? priority;

  @JsonKey(name: "content_available")
  bool? contentAvailable;

  @JsonKey(name: "moment_id")
  int momentId;

  DataRequest({
    required this.title,
    required this.body,
    this.priority = "high",
    this.contentAvailable = true,
    required this.momentId,
  });

  factory DataRequest.fromJson(Map<String, dynamic> json) =>
      _$DataRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DataRequestToJson(this);
}
