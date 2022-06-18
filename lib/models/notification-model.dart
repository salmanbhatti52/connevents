import 'package:connevents/models/business-comment-model.dart';
import 'package:connevents/models/model.dart';
import 'package:connevents/models/peek-model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'comments-model.dart';
import 'business-create-model.dart';

import 'create-event-model.dart';
part 'notification-model.g.dart';

@JsonSerializable(includeIfNull: false)
class NotificationModel extends BaseModelHive{
  String? status;
  List<Notifications>? data;
  NotificationModel({this.status,this.data});

  Map<String,dynamic> toJson()=> _$NotificationModelToJson(this);
  factory NotificationModel.fromJson(json)=> _$NotificationModelFromJson(json);


}

@JsonSerializable(includeIfNull: false)

class Notifications extends BaseModelHive{
  @JsonKey(name: 'notification_id')
  int? notificationId;
  @JsonKey(name: 'sender_users_id')
  int? senderUsersId;
  @JsonKey(name: 'receiver_users_id')
  int? receiverUsersId;
  @JsonKey(name: 'notification_type')
  String? notificationType;
  String? message;
  String? status;
  @JsonKey(name: 'sender_name')
  String? senderName;
  @JsonKey(name: 'refund_amount')
  String? refundAmount;
  String? date;
  String? time;
  @JsonKey(name: 'event_details')
  EventDetail? eventDetail;
  @JsonKey(name: 'peek_details')
  PeekDetail? peekDetails;

  @JsonKey(name: 'comment_details')
  Comments? commentDetails;
  @JsonKey(name: 'business_details')
  Business? businessDetail;
  @JsonKey(name: 'business_comment_details')
  BusinessComments? businessCommentDetails;
  Notifications({this.businessDetail,this.peekDetails,this.businessCommentDetails, this.eventDetail,this.commentDetails,this.status,this.refundAmount,this.time,this.message,this.date,this.notificationId,this.notificationType,this.receiverUsersId,this.senderName,this.senderUsersId});

  Map<String,dynamic> toJson()=> _$NotificationsToJson(this);
  factory Notifications.fromJson(json)=> _$NotificationsFromJson(json);




}