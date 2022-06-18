import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'model.dart';
part 'user-model.g.dart';

@HiveType(typeId: 129)
@JsonSerializable(includeIfNull: false)
class Profile extends BaseModelHive{
String? userName;
String? userEmail;
String? firstName;
String? lastName;
String? userPassword;
String? confirmPassword;
String? oneSignalId;
@HiveField(1)
String? status;
@HiveField(2)
String hint_flag;
@HiveField(3)
Data? data;

Profile({this.oneSignalId,this.confirmPassword,this.hint_flag="",this.firstName,this.data,this.status,this.lastName,this.userName,this.userPassword,this.userEmail});
Map<String,dynamic> toJson()=> _$ProfileToJson(this);
factory Profile.fromJson(json)=> _$ProfileFromJson(json);
}
@JsonSerializable(includeIfNull: false)
@HiveType(typeId: 130)
class Data extends BaseModelHive{
  @HiveField(1)
  List<UserDetail?>? user;
  Data({this.user});
  Map<String,dynamic> toJson()=> _$DataToJson(this);
  factory Data.fromJson(json)=> _$DataFromJson(json);

}
@JsonSerializable(includeIfNull: false)
@HiveType(typeId: 131)
class UserDetail extends BaseModelHive{
  @HiveField(1)
  int? users_id;
  @HiveField(2)
  String? user_name;
  @HiveField(3)
  String? first_name;
  @HiveField(4)
  String? last_name;
  @HiveField(5)
  String? email;
  @HiveField(6)
  int? roles_id;
  @HiveField(7)
  String? password;
  @HiveField(8)
  String? confirm_password;
  @HiveField(9)
  String? date_added;
  @HiveField(10)
  String? status;
  @HiveField(11)
  String? verify_code;
  @HiveField(12)
  String? sub_categories_id;
  @HiveField(13)
  String? account_type;
   @HiveField(14)
  String? profile_picture;
   @HiveField(15)
  String? social_acc_type;
   @HiveField(16)
  String? google_access_token;
   @HiveField(17)
  String? facebook_id;
  @HiveField(18)
  int? subscription_package_id;
  @HiveField(19)
  String? package_updated_at;
  @HiveField(20)
  int one_time_post_count;
  UserDetail({ this.first_name,this.one_time_post_count=0,this.package_updated_at,this.subscription_package_id,this.profile_picture,this.facebook_id,this.google_access_token,this.social_acc_type,this.account_type,this.status,this.confirm_password,this.date_added,this.last_name,this.password,this.sub_categories_id,this.verify_code,this.email,this.roles_id, this.user_name,this.users_id});
  Map<String,dynamic> toJson()=> _$UserDetailToJson(this);
  factory UserDetail.fromJson(json)=> _$UserDetailFromJson(json);
}
