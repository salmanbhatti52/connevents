
import 'package:json_annotation/json_annotation.dart';
part 'my-earning-model.g.dart';

@JsonSerializable(includeIfNull: false)
class MyEarning{
  @JsonKey(name: 'pending_flag')
  bool pendingFlag;
  int? earning;
  @JsonKey(name: 'pending_withdraw')
  int? pendingWithdraw;


  MyEarning({this.earning,this.pendingFlag=false,this.pendingWithdraw});

  Map<String,dynamic> toJson()=> _$MyEarningToJson(this);
  factory MyEarning.fromJson(json)=> _$MyEarningFromJson(json);



}