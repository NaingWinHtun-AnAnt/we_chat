import 'package:json_annotation/json_annotation.dart';

part 'message_vo.g.dart';

@JsonSerializable(includeIfNull: true, anyMap: true)
class MessageVO {
  @JsonKey(name: "id")
  int id;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "userId")
  String? userId;

  @JsonKey(name: "fileUrl")
  String? fileUrl;

  @JsonKey(name: "isVideoFile")
  bool isVideoFile;

  MessageVO({
    required this.id,
    this.message,
    this.userId,
    this.fileUrl,
    this.isVideoFile = false,
  });

  bool isMyMessage(String? myId) => userId == myId;

  factory MessageVO.fromJson(Map<String, dynamic> json) =>
      _$MessageVOFromJson(json);

  Map<String, dynamic> toJson() => _$MessageVOToJson(this);
}
