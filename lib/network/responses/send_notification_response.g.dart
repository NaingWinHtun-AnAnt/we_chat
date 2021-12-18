// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_notification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendNotificationResponse _$SendNotificationResponseFromJson(
        Map<String, dynamic> json) =>
    SendNotificationResponse(
      multicastId: json['multicast_id'] as int?,
      success: json['success'] as int?,
      failure: json['failure'] as int?,
      canonicalIds: json['canonical_ids'] as int?,
    );

Map<String, dynamic> _$SendNotificationResponseToJson(
        SendNotificationResponse instance) =>
    <String, dynamic>{
      'multicast_id': instance.multicastId,
      'success': instance.success,
      'failure': instance.failure,
      'canonical_ids': instance.canonicalIds,
    };
