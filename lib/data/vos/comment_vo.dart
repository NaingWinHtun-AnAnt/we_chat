import 'package:json_annotation/json_annotation.dart';

part 'comment_vo.g.dart';

@JsonSerializable()
class CommentVO {
  @JsonKey(name: "id")
  String id;

  @JsonKey(name: "userName")
  String? userName;

  @JsonKey(name: "comment")
  String? comment;

  CommentVO({
    required this.id,
    this.userName,
    this.comment,
  });

  factory CommentVO.fromJson(Map<String, dynamic> json) =>
      _$CommentVOFromJson(json);

  Map<String, dynamic> toJson() => _$CommentVOToJson(this);
}
