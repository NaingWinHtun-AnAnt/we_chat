// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageVO _$MessageVOFromJson(Map json) => MessageVO(
      id: json['id'] as int,
      message: json['message'] as String?,
      userId: json['userId'] as String?,
      fileUrl: json['fileUrl'] as String?,
      isVideoFile: json['isVideoFile'] as bool? ?? false,
    );

Map<String, dynamic> _$MessageVOToJson(MessageVO instance) => <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'userId': instance.userId,
      'fileUrl': instance.fileUrl,
      'isVideoFile': instance.isVideoFile,
    };
