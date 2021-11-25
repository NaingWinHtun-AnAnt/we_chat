import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:we_chat/persistence/hive_constants.dart';

part 'user_vo.g.dart';

@JsonSerializable(anyMap: true)
@HiveType(typeId: hiveTypeIdUserVO, adapterName: "UserVOAdapter")
class UserVO {
  @JsonKey(name: "id")
  @HiveField(0)
  int id;

  @JsonKey(name: "userName")
  @HiveField(1)
  String? userName;

  @JsonKey(name: "imagePath")
  @HiveField(2)
  String? imagePath;

  @JsonKey(name: "organization")
  @HiveField(3)
  String? organization;

  UserVO({
    required this.id,
    this.userName,
    this.imagePath,
    this.organization,
  });

  factory UserVO.fromJson(Map<String, dynamic> json) => _$UserVOFromJson(json);

  Map<String, dynamic> toJson() => _$UserVOToJson(this);
}
