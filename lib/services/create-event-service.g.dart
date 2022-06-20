// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create-event-service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _CreateEventService implements CreateEventService {
  _CreateEventService(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://connevents.com/app/api/';
  }

  final Dio _dio;

  String? baseUrl;

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
