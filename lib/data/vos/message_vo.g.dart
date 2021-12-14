// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageVO _$MessageVOFromJson(Map json) => MessageVO(
      id: json['id'] as String?,
      message: json['message'] as String?,
      userId: json['send_user_id'] as String?,
      receiveUserId: json['receive_user_id'] as String?,
      fileUrl: json['file_url'] as String?,
      receiverProfilePath: json['receiver_profile_path'] as String?,
      receiverUserName: json['receiver_user_name'] as String?,
      isVideoFile: json['is_video_file'] as bool? ?? false,
    );

Map<String, dynamic> _$MessageVOToJson(MessageVO instance) => <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'send_user_id': instance.userId,
      'receive_user_id': instance.receiveUserId,
      'file_url': instance.fileUrl,
      'receiver_profile_path': instance.receiverProfilePath,
      'receiver_user_name': instance.receiverUserName,
      'is_video_file': instance.isVideoFile,
    };
