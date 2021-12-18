// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moment_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MomentVO _$MomentVOFromJson(Map json) => MomentVO(
      id: json['id'] as int,
      userId: json['user_id'] as String?,
      userName: json['user_name'] as String?,
      userImageUrl: json['user_image_url'] as String?,
      momentFileUrl: json['moment_file_url'] as String?,
      content: json['content'] as String?,
      uploadedTime: json['uploaded_time'] as String?,
      like: json['like'] == null
          ? null
          : LikeVO.fromJson(Map<String, dynamic>.from(json['like'] as Map)),
      comment: json['comment'] == null
          ? null
          : CommentVO.fromJson(
              Map<String, dynamic>.from(json['comment'] as Map)),
      isVideoFile: json['is_video_file'] as bool? ?? false,
    );

Map<String, dynamic> _$MomentVOToJson(MomentVO instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'user_name': instance.userName,
      'user_image_url': instance.userImageUrl,
      'moment_file_url': instance.momentFileUrl,
      'content': instance.content,
      'uploaded_time': instance.uploadedTime,
      'like': instance.like?.toJson(),
      'comment': instance.comment?.toJson(),
      'is_video_file': instance.isVideoFile,
    };
