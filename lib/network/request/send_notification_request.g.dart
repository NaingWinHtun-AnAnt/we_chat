// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_notification_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendNotificationRequest _$SendNotificationRequestFromJson(
        Map<String, dynamic> json) =>
    SendNotificationRequest(
      registrationIds: (json['registration_ids'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      notification: NotificationRequest.fromJson(
          json['notification'] as Map<String, dynamic>),
      dataRequest: DataRequest.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SendNotificationRequestToJson(
        SendNotificationRequest instance) =>
    <String, dynamic>{
      'registration_ids': instance.registrationIds,
      'notification': instance.notification,
      'data': instance.dataRequest,
    };
