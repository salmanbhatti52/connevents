// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city-service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _CityService implements CityService {
  _CityService(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://connevents.com/app/api/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<CityData> get() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CityData>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'get_event_cities',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CityData.fromJson(_result.data!);
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
