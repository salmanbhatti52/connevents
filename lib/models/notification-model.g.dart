// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      status: json['status'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Notifications.fromJson(e))
          .toList(),
    )..id = json['id'] as String?;

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('status', instance.status);
  writeNotNull('data', instance.data);
  return val;
}

Notifications _$NotificationsFromJson(Map<String, dynamic> json) =>
    Notifications(
      businessDetail: json['business_details'] == null
          ? null
          : Business.fromJson(json['business_details']),
      peekDetails: json['peek_details'] == null
          ? null
          : PeekDetail.fromJson(json['peek_details']),
      businessCommentDetails: json['business_comment_details'] == null
          ? null
          : BusinessComments.fromJson(json['business_comment_details']),
      eventDetail: json['event_details'] == null
          ? null
          : EventDetail.fromJson(json['event_details']),
      commentDetails: json['comment_details'] == null
          ? null
          : Comments.fromJson(json['comment_details']),
      status: json['status'] as String?,
      refundAmount: json['refund_amount'] as String?,
      time: json['time'] as String?,
      message: json['message'] as String?,
      date: json['date'] as String?,
      notificationId: json['notification_id'] as int?,
      notificationType: json['notification_type'] as String?,
      receiverUsersId: json['receiver_users_id'] as int?,
      senderName: json['sender_name'] as String?,
      senderUsersId: json['sender_users_id'] as int?,
    )..id = json['id'] as String?;

Map<String, dynamic> _$NotificationsToJson(Notifications instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('notification_id', instance.notificationId);
  writeNotNull('sender_users_id', instance.senderUsersId);
  writeNotNull('receiver_users_id', instance.receiverUsersId);
  writeNotNull('notification_type', instance.notificationType);
  writeNotNull('message', instance.message);
  writeNotNull('status', instance.status);
  writeNotNull('sender_name', instance.senderName);
  writeNotNull('refund_amount', instance.refundAmount);
  writeNotNull('date', instance.date);
  writeNotNull('time', instance.time);
  writeNotNull('event_details', instance.eventDetail);
  writeNotNull('peek_details', instance.peekDetails);
  writeNotNull('comment_details', instance.commentDetails);
  writeNotNull('business_details', instance.businessDetail);
  writeNotNull('business_comment_details', instance.businessCommentDetails);
  return val;
}
