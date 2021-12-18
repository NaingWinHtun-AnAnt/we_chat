// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataRequest _$DataRequestFromJson(Map<String, dynamic> json) => DataRequest(
      title: json['title'] as String,
      body: json['body'] as String,
      priority: json['priority'] as String? ?? "high",
      contentAvailable: json['content_available'] as bool? ?? true,
      momentId: json['moment_id'] as int,
    );

Map<String, dynamic> _$DataRequestToJson(DataRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'priority': instance.priority,
      'content_available': instance.contentAvailable,
      'moment_id': instance.momentId,
    };
