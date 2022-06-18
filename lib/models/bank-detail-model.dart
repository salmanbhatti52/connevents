import 'package:connevents/models/model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'bank-detail-model.g.dart';

@JsonSerializable(includeIfNull: false)
class BankDetail extends BaseModelHive{
  int? usersId;
  String? withdrawType;
  String? withdrawAmount;
  String? accountNo;
  String? accountHolderName;
  String? bankName;

  BankDetail({this.accountHolderName,this.accountNo,this.bankName,this.usersId,this.withdrawAmount,this.withdrawType});


  Map<String, dynamic> toJson() => _$BankDetailToJson(this);
  factory BankDetail.fromJson(json) => _$BankDetailFromJson(json);

}