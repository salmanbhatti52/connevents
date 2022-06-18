import 'package:connevents/models/model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user-concash-model.g.dart';


@JsonSerializable(includeIfNull: false)
class UserConCash extends BaseModelHive{

  String? status;
UserConCashDetail? data;

UserConCash({this.status,this.data});
  Map<String, dynamic> toJson() => _$UserConCashToJson(this);

  factory UserConCash.fromJson(json) => _$UserConCashFromJson(json);
}



@JsonSerializable(includeIfNull: false)
class UserConCashDetail extends  BaseModelHive{
  @JsonKey(name: 'users_id')
  int? usersId;
 String? email;
 @JsonKey(name: 'first_name')
 String?  firstName;
 @JsonKey(name: 'conncash_dollars')
  double? concashDollars;
  @JsonKey(name: 'total_conncash')
  double totalConncash;

UserConCashDetail({this.usersId,this.totalConncash=0.0,this.email,this.firstName,this.concashDollars});
  Map<String, dynamic> toJson() => _$UserConCashDetailToJson(this);

  factory UserConCashDetail.fromJson(json) => _$UserConCashDetailFromJson(json);

}