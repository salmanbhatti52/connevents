// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification-setting-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationSettingModel _$NotificationSettingModelFromJson(
        Map<String, dynamic> json) =>
    NotificationSettingModel(
      status: json['status'] as String?,
      userNotificationSettingId: json['user_notification_setting_id'] as int?,
      notificationType: json['notification_type'] as String?,
      UsersId: json['users_id'] as int?,
    );

Map<String, dynamic> _$NotificationSettingModelToJson(
    NotificationSettingModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'user_notification_setting_id', instance.userNotificationSettingId);
  writeNotNull('notification_type', instance.notificationType);
  writeNotNull('users_id', instance.UsersId);
  writeNotNull('status', instance.status);
  return val;
}
