// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refund-request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefundRequest _$RefundRequestFromJson(Map<String, dynamic> json) =>
    RefundRequest(
      status: json['status'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => RefundRequestList.fromJson(e))
          .toList(),
    )..id = json['id'] as String?;

Map<String, dynamic> _$RefundRequestToJson(RefundRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('status', instance.status);
  writeNotNull('data', instance.data?.map((e) => e.toJson()).toList());
  return val;
}

RefundRequestList _$RefundRequestListFromJson(Map<String, dynamic> json) =>
    RefundRequestList(
      ticketUniqueNumber: json['ticket_unique_number'] as int?,
      transactionId: json['transaction_id'] as int?,
      userTicket: (json['user_tickets'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      totalAmount: (json['total_amount'] as num?)?.toDouble(),
      eventPostId: json['event_post_id'] as int?,
      status: json['status'] as String?,
      buyerUsername: json['buyer_username'] as String?,
      datetime: json['datetime'] as String?,
      eventName: json['event_name'] as String?,
      eventOrganizerId: json['event_organizer_id'] as int?,
      refundRequestId: json['refund_request_id'] as int?,
      startingDate: json['starting_date'] as String?,
      startingTime: json['starting_time'] as String?,
      ticketBuyerId: json['ticket_buyer_id'] as int?,
    )..id = json['id'] as String?;

Map<String, dynamic> _$RefundRequestListToJson(RefundRequestList instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('refund_request_id', instance.refundRequestId);
  writeNotNull('ticket_unique_number', instance.ticketUniqueNumber);
  writeNotNull('transaction_id', instance.transactionId);
  writeNotNull('event_post_id', instance.eventPostId);
  writeNotNull('total_amount', instance.totalAmount);
  writeNotNull('event_organizer_id', instance.eventOrganizerId);
  writeNotNull('ticket_buyer_id', instance.ticketBuyerId);
  writeNotNull('datetime', instance.datetime);
  writeNotNull('status', instance.status);
  writeNotNull('buyer_username', instance.buyerUsername);
  writeNotNull('event_name', instance.eventName);
  writeNotNull('starting_date', instance.startingDate);
  writeNotNull('starting_time', instance.startingTime);
  writeNotNull('user_tickets', instance.userTicket);
  return val;
}
