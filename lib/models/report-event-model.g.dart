// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report-event-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportEventModel _$ReportEventModelFromJson(Map<String, dynamic> json) =>
    ReportEventModel(
      data: json['data'] as String?,
      success: json['success'] as String?,
      comment: json['comment'] as String?,
    );

Map<String, dynamic> _$ReportEventModelToJson(ReportEventModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('success', instance.success);
  writeNotNull('data', instance.data);
  writeNotNull('comment', instance.comment);
  return val;
}
