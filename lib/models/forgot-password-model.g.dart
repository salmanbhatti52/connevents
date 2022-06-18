// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot-password-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgotPasswordModel _$ForgotPasswordModelFromJson(Map<String, dynamic> json) =>
    ForgotPasswordModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
    )..id = json['id'] as String?;

Map<String, dynamic> _$ForgotPasswordModelToJson(ForgotPasswordModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('status', instance.status);
  writeNotNull('message', instance.message);
  return val;
}
