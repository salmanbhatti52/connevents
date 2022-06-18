// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user-concash-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserConCash _$UserConCashFromJson(Map<String, dynamic> json) => UserConCash(
      status: json['status'] as String?,
      data: json['data'] == null
          ? null
          : UserConCashDetail.fromJson(json['data']),
    )..id = json['id'] as String?;

Map<String, dynamic> _$UserConCashToJson(UserConCash instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('status', instance.status);
  writeNotNull('data', instance.data);
  return val;
}

UserConCashDetail _$UserConCashDetailFromJson(Map<String, dynamic> json) =>
    UserConCashDetail(
      usersId: json['users_id'] as int?,
      totalConncash: (json['total_conncash'] as num?)?.toDouble() ?? 0.0,
      email: json['email'] as String?,
      firstName: json['first_name'] as String?,
      concashDollars: (json['conncash_dollars'] as num?)?.toDouble(),
    )..id = json['id'] as String?;

Map<String, dynamic> _$UserConCashDetailToJson(UserConCashDetail instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('users_id', instance.usersId);
  writeNotNull('email', instance.email);
  writeNotNull('first_name', instance.firstName);
  writeNotNull('conncash_dollars', instance.concashDollars);
  val['total_conncash'] = instance.totalConncash;
  return val;
}
