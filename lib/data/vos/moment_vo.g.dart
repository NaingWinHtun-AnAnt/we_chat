// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moment_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MomentVO _$MomentVOFromJson(Map json) => MomentVO(
      id: json['id'] as int,
      userName: json['userName'] as String?,
      userImageUrl: json['userImageUrl'] as String?,
      momentFileUrl: json['momentFileUrl'] as String?,
      content: json['content'] as String?,
      uploadedTime: json['uploadedTime'] as String?,
      isVideoFile: json['isVideoFile'] as bool? ?? false,
    );

Map<String, dynamic> _$MomentVOToJson(MomentVO instance) => <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'userImageUrl': instance.userImageUrl,
      'momentFileUrl': instance.momentFileUrl,
      'content': instance.content,
      'uploadedTime': instance.uploadedTime,
      'isVideoFile': instance.isVideoFile,
    };
