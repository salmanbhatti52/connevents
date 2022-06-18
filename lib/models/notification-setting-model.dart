import 'package:json_annotation/json_annotation.dart';
part 'notification-setting-model.g.dart';

@JsonSerializable(includeIfNull: false)
class NotificationSettingModel{

  @JsonKey(name: 'user_notification_setting_id')
  int? userNotificationSettingId;
  @JsonKey(name: 'notification_type')
  String? notificationType;
  @JsonKey(name: 'users_id')
  int? UsersId;
  String? status;

NotificationSettingModel({this.status,this.userNotificationSettingId,this.notificationType,this.UsersId});


  Map<String,dynamic> toJson()=> _$NotificationSettingModelToJson(this);
  factory NotificationSettingModel.fromJson(json)=> _$NotificationSettingModelFromJson(json);


}


