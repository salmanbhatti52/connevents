// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check-user-subscription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckUserSubscription _$CheckUserSubscriptionFromJson(
        Map<String, dynamic> json) =>
    CheckUserSubscription(
      status: json['status'] as String?,
    );

Map<String, dynamic> _$CheckUserSubscriptionToJson(
    CheckUserSubscription instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('status', instance.status);
  return val;
}

CheckUserSubscriptionData _$CheckUserSubscriptionDataFromJson(
        Map<String, dynamic> json) =>
    CheckUserSubscriptionData(
      subscription_package_id: json['subscription_package_id'] as int?,
    );

Map<String, dynamic> _$CheckUserSubscriptionDataToJson(
    CheckUserSubscriptionData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('subscription_package_id', instance.subscription_package_id);
  return val;
}
