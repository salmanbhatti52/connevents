// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event-tags-service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _EventTagsService implements EventTagsService {
  _EventTagsService(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://connevents.com/app/api/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<EventTagsModel> get() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<EventTagsModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'get_all_tags',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = EventTagsModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<EventTagsModel> getTags() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<EventTagsModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'get_all_tags_with_custom',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = EventTagsModel.fromJson(_result.data!);
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
