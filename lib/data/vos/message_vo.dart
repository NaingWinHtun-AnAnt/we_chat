import 'package:json_annotation/json_annotation.dart';

part 'message_vo.g.dart';

@JsonSerializable(includeIfNull: true, anyMap: true)
class MessageVO {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "send_user_id")
  String? userId;

  @JsonKey(name: "receive_user_id")
  String? receiveUserId;

  @JsonKey(name: "file_url")
  String? fileUrl;

  @JsonKey(name: "receiver_profile_path")
  String? receiverProfilePath;

  @JsonKey(name: "receiver_user_name")
  String? receiverUserName;

  @JsonKey(name: "is_video_file")
  bool isVideoFile;

  MessageVO({
    required this.id,
    this.message,
    this.userId,
    this.receiveUserId,
    this.fileUrl,
    this.receiverProfilePath,
    this.receiverUserName,
    this.isVideoFile = false,
  });

  bool isMyMessage(String? myId) => userId == myId;

  factory MessageVO.fromJson(Map<String, dynamic> json) =>
      _$MessageVOFromJson(json);

  Map<String, dynamic> toJson() => _$MessageVOToJson(this);
}
