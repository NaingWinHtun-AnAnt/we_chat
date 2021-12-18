import 'package:json_annotation/json_annotation.dart';

part 'user_vo.g.dart';

@JsonSerializable(anyMap: true)
class UserVO {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "userName")
  String? userName;

  @JsonKey(name: "email")
  String? email;

  @JsonKey(name: "password")
  String? password;

  @JsonKey(name: "phone")
  String? phoneNumber;

  @JsonKey(name: "region")
  String? region;

  @JsonKey(name: "imagePath")
  String? imagePath;

  @JsonKey(name: "organization")
  String? organization;

  @JsonKey(name: "fcm_token")
  String? fcmToken;

  UserVO({
    this.id,
    this.userName,
    this.email,
    this.password,
    this.phoneNumber,
    this.region,
    this.imagePath,
    this.organization,
    this.fcmToken,
  });

  factory UserVO.fromJson(Map<String, dynamic> json) => _$UserVOFromJson(json);

  Map<String, dynamic> toJson() => _$UserVOToJson(this);
}
