// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactVO _$ContactVOFromJson(Map json) => ContactVO(
      id: json['id'] as String,
      userName: json['userName'] as String?,
      email: json['email'] as String?,
      imagePath: json['imagePath'] as String?,
      organization: json['organization'] as String?,
    );

Map<String, dynamic> _$ContactVOToJson(ContactVO instance) => <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'email': instance.email,
      'imagePath': instance.imagePath,
      'organization': instance.organization,
    };
