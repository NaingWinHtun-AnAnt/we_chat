// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentVO _$CommentVOFromJson(Map<String, dynamic> json) => CommentVO(
      id: json['id'] as String,
      userName: json['userName'] as String?,
      comment: json['comment'] as String?,
    );

Map<String, dynamic> _$CommentVOToJson(CommentVO instance) => <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'comment': instance.comment,
    };
