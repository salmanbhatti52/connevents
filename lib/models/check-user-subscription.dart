import 'package:json_annotation/json_annotation.dart';
import 'model.dart';

part 'check-user-subscription.g.dart';

@JsonSerializable(includeIfNull: false)
class CheckUserSubscription{
  String? status;
CheckUserSubscription({this.status});


  Map<String, dynamic> toJson() => _$CheckUserSubscriptionToJson(this);
  factory CheckUserSubscription.fromJson(json) => _$CheckUserSubscriptionFromJson(json);
}

@JsonSerializable(includeIfNull: false)
class CheckUserSubscriptionData{
  int? subscription_package_id;
  CheckUserSubscriptionData({this.subscription_package_id});

  Map<String, dynamic> toJson() => _$CheckUserSubscriptionDataToJson(this);
  factory CheckUserSubscriptionData.fromJson(json) => _$CheckUserSubscriptionDataFromJson(json);
}