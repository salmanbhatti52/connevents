

import 'package:connevents/models/model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'model.dart';
part 'forgot-password-model.g.dart';

@JsonSerializable(includeIfNull: false)
class ForgotPasswordModel extends BaseModelHive{
String? status;
String? message;
ForgotPasswordModel({this.status,this.message});

Map<String,dynamic> toJson()=> _$ForgotPasswordModelToJson(this);
factory ForgotPasswordModel.fromJson(json)=> _$ForgotPasswordModelFromJson(json);


}