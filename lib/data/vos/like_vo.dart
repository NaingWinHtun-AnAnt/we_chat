import 'package:json_annotation/json_annotation.dart';

part 'like_vo.g.dart';

@JsonSerializable(anyMap: true)
class LikeVO {
  @JsonKey(name: "id")
  int id;

  @JsonKey(name: "userName")
  String? userName;

  @JsonKey(name: "imagePath")
  String? imagePath;

  @JsonKey(name: "userId")
  int? userId;

  LikeVO({
    required this.id,
    this.userName,
    this.imagePath,
    this.userId,
  });

  factory LikeVO.fromJson(Map<String, dynamic> json) => _$LikeVOFromJson(json);

  Map<String, dynamic> toJson() => _$LikeVOToJson(this);
}
