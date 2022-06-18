// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank-detail-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankDetail _$BankDetailFromJson(Map<String, dynamic> json) => BankDetail(
      accountHolderName: json['accountHolderName'] as String?,
      accountNo: json['accountNo'] as String?,
      bankName: json['bankName'] as String?,
      usersId: json['usersId'] as int?,
      withdrawAmount: json['withdrawAmount'] as String?,
      withdrawType: json['withdrawType'] as String?,
    )..id = json['id'] as String?;

Map<String, dynamic> _$BankDetailToJson(BankDetail instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('usersId', instance.usersId);
  writeNotNull('withdrawType', instance.withdrawType);
  writeNotNull('withdrawAmount', instance.withdrawAmount);
  writeNotNull('accountNo', instance.accountNo);
  writeNotNull('accountHolderName', instance.accountHolderName);
  writeNotNull('bankName', instance.bankName);
  return val;
}
