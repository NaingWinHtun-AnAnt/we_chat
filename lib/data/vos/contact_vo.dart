import 'package:json_annotation/json_annotation.dart';

part 'contact_vo.g.dart';

@JsonSerializable(anyMap: true)
class ContactVO {
  @JsonKey(name: "id")
  String id;

  @JsonKey(name: "userName")
  String? userName;

  @JsonKey(name: "email")
  String? email;

  @JsonKey(name: "imagePath")
  String? imagePath;

  @JsonKey(name: "organization")
  String? organization;

  ContactVO({
    required this.id,
    this.userName,
    this.email,
    this.imagePath,
    this.organization,
  });

  factory ContactVO.fromJson(Map<String, dynamic> json) =>
      _$ContactVOFromJson(json);

  Map<String, dynamic> toJson() => _$ContactVOToJson(this);
}
