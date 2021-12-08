import 'package:json_annotation/json_annotation.dart';

part 'region_vo.g.dart';

@JsonSerializable()
class RegionVO {
  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "code")
  String? code;

  RegionVO({
    this.name,
    this.code,
  });

  factory RegionVO.fromJson(Map<String, dynamic> json) =>
      _$RegionVOFromJson(json);

  Map<String, dynamic> toJson() => _$RegionVOToJson(this);
}
