import 'package:json_annotation/json_annotation.dart';
import 'package:we_chat/utils/handle_date_time.dart';

part 'moment_vo.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class MomentVO {
  @JsonKey(name: "id")
  int id;

  @JsonKey(name: "userName")
  String? userName;

  @JsonKey(name: "userImageUrl")
  String? userImageUrl;

  @JsonKey(name: "momentFileUrl")
  String? momentFileUrl;

  @JsonKey(name: "content")
  String? content;

  @JsonKey(name: "uploadedTime")
  String? uploadedTime;

  @JsonKey(name: "isVideoFile")
  bool isVideoFile;

  MomentVO({
    required this.id,
    this.userName,
    this.userImageUrl,
    this.momentFileUrl,
    this.content,
    this.uploadedTime,
    this.isVideoFile = false,
  });

  String uploadedTimeAgo() {
    return getFormattedUploadedTime(uploadedTime);
  }

  factory MomentVO.fromJson(Map<String, dynamic> json) =>
      _$MomentVOFromJson(json);

  Map<String, dynamic> toJson() => _$MomentVOToJson(this);
}
