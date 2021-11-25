// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserVOAdapter extends TypeAdapter<UserVO> {
  @override
  final int typeId = 0;

  @override
  UserVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserVO(
      id: fields[0] as int,
      userName: fields[1] as String?,
      imagePath: fields[2] as String?,
      organization: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserVO obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userName)
      ..writeByte(2)
      ..write(obj.imagePath)
      ..writeByte(3)
      ..write(obj.organization);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserVO _$UserVOFromJson(Map json) => UserVO(
      id: json['id'] as int,
      userName: json['userName'] as String?,
      imagePath: json['imagePath'] as String?,
      organization: json['organization'] as String?,
    );

Map<String, dynamic> _$UserVOToJson(UserVO instance) => <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'imagePath': instance.imagePath,
      'organization': instance.organization,
    };
