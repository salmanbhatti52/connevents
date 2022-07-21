// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my-earning-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyEarning _$MyEarningFromJson(Map<String, dynamic> json) => MyEarning(
      earning: json['earning'] as int?,
      pendingFlag: json['pending_flag'] as bool? ?? false,
      pendingWithdraw: json['pending_withdraw'] as int?,
    )..paypalEmail = json['paypal_email'] as String?;

Map<String, dynamic> _$MyEarningToJson(MyEarning instance) {
  final val = <String, dynamic>{
    'pending_flag': instance.pendingFlag,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('earning', instance.earning);
  writeNotNull('pending_withdraw', instance.pendingWithdraw);
  writeNotNull('paypal_email', instance.paypalEmail);
  return val;
}
