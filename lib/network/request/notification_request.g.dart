// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationRequest _$NotificationRequestFromJson(Map<String, dynamic> json) =>
    NotificationRequest(
      title: json['title'] as String,
      body: json['body'] as String,
      priority: json['priority'] as String? ?? "high",
      contentAvailable: json['content_available'] as bool? ?? true,
    );

Map<String, dynamic> _$NotificationRequestToJson(
        NotificationRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'priority': instance.priority,
      'content_available': instance.contentAvailable,
    };
