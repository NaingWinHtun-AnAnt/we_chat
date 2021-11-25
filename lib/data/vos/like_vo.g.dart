// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LikeVO _$LikeVOFromJson(Map json) => LikeVO(
      id: json['id'] as int,
      userName: json['userName'] as String?,
      imagePath: json['imagePath'] as String?,
      userId: json['userId'] as int?,
    );

Map<String, dynamic> _$LikeVOToJson(LikeVO instance) => <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'imagePath': instance.imagePath,
      'userId': instance.userId,
    };
