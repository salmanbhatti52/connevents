// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business-type-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusinessType _$BusinessTypeFromJson(Map<String, dynamic> json) => BusinessType(
      id: json['id'] as int?,
      status: json['status'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$BusinessTypeToJson(BusinessType instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('type', instance.type);
  writeNotNull('status', instance.status);
  return val;
}
