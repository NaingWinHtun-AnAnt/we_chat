// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'we_chat_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _WeChatApi implements WeChatApi {
  _WeChatApi(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://fcm.googleapis.com/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<SendNotificationResponse> sendNotification(notificationRequest) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(notificationRequest.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SendNotificationResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'fcm/send',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SendNotificationResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
