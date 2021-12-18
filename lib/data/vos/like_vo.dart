import 'package:json_annotation/json_annotation.dart';

part 'like_vo.g.dart';

@JsonSerializable(anyMap: true)
class LikeVO {
  @JsonKey(name: "id")
  String id;

  @JsonKey(name: "user_name")
  String? userName;

  LikeVO({
    required this.id,
    this.userName,
  });

  factory LikeVO.fromJson(Map<String, dynamic> json) => _$LikeVOFromJson(json);

  Map<String, dynamic> toJson() => _$LikeVOToJson(this);
}
