import 'package:json_annotation/json_annotation.dart';
import 'package:we_chat/data/vos/comment_vo.dart';
import 'package:we_chat/data/vos/like_vo.dart';
import 'package:we_chat/utils/handle_date_time.dart';

part 'moment_vo.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class MomentVO {
  @JsonKey(name: "id")
  int id;

  @JsonKey(name: "user_id")
  String? userId;

  @JsonKey(name: "user_name")
  String? userName;

  @JsonKey(name: "user_image_url")
  String? userImageUrl;

  @JsonKey(name: "moment_file_url")
  String? momentFileUrl;

  @JsonKey(name: "content")
  String? content;

  @JsonKey(name: "uploaded_time")
  String? uploadedTime;

  @JsonKey(name: "like")
  List<LikeVO>? like;

  @JsonKey(name: "comment")
  List<CommentVO>? comment;

  @JsonKey(name: "is_video_file")
  bool isVideoFile;

  MomentVO({
    required this.id,
    this.userId,
    this.userName,
    this.userImageUrl,
    this.momentFileUrl,
    this.content,
    this.uploadedTime,
    this.like = const [],
    this.comment = const [],
    this.isVideoFile = false,
  });

  String uploadedTimeAgo() {
    return getFormattedUploadedTime(uploadedTime);
  }

  factory MomentVO.fromJson(Map<String, dynamic> json) =>
      _$MomentVOFromJson(json);

  Map<String, dynamic> toJson() => _$MomentVOToJson(this);
}
