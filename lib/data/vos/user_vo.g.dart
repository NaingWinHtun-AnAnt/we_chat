// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserVO _$UserVOFromJson(Map json) => UserVO(
      id: json['id'] as String?,
      userName: json['userName'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      phoneNumber: json['phone'] as String?,
      region: json['region'] as String?,
      imagePath: json['imagePath'] as String?,
      organization: json['organization'] as String?,
    );

Map<String, dynamic> _$UserVOToJson(UserVO instance) => <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'email': instance.email,
      'password': instance.password,
      'phone': instance.phoneNumber,
      'region': instance.region,
      'imagePath': instance.imagePath,
      'organization': instance.organization,
    };
