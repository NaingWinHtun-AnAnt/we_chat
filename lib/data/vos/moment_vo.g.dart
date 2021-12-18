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
      like: (json['like'] as List<dynamic>?)
              ?.map((e) => LikeVO.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
      comment: (json['comment'] as List<dynamic>?)
              ?.map((e) =>
                  CommentVO.fromJson(Map<String, dynamic>.from(e as Map)))
              .toList() ??
          const [],
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
      'like': instance.like?.map((e) => e.toJson()).toList(),
      'comment': instance.comment?.map((e) => e.toJson()).toList(),
      'is_video_file': instance.isVideoFile,
    };
