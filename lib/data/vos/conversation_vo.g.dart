// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversationVO _$ConversationVOFromJson(Map json) => ConversationVO(
      id: json['id'] as int,
      userName: json['userName'] as String?,
      messages: (json['messages'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : MessageVO.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      profilePath: json['profilePath'] as String?,
    );

Map<String, dynamic> _$ConversationVOToJson(ConversationVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'messages': instance.messages?.map((e) => e?.toJson()).toList(),
      'profilePath': instance.profilePath,
    };
