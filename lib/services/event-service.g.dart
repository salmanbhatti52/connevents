// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event-service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _EventService implements EventService {
  _EventService(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://connevents.com/app/api/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<CreateEventModel> post(offset) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(offset);
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CreateEventModel>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'get_event_posts',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CreateEventModel.fromJson(_result.data!);
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
