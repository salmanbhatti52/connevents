// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event-guest-list-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventGuestList _$EventGuestListFromJson(Map<String, dynamic> json) =>
    EventGuestList(
      isCheckedIn: json['is_checked_in'] as bool?,
      quantity: json['quantity'] as int?,
      locationLat: (json['location_lat'] as num?)?.toDouble(),
      locationLong: (json['location_long'] as num?)?.toDouble(),
      listOfId: json['list_of_ids'] as List<dynamic>?,
      totalAmount: (json['total_amount'] as num?)?.toDouble(),
      eventPostId: json['event_post_id'] as int?,
      ticket: json['ticket'] as String?,
      transactionId: json['transaction_id'] as int?,
      title: json['title'] as String?,
      ticketUniqueNumber: json['ticket_unique_number'] as String?,
      purchaseTime: json['purchase_time'] as String?,
      purchaseDate: json['purchase_date'] as String?,
      eventStartDate: json['event_start_date'] as String?,
      userName: json['user_name'] as String?,
      eventStartTime: json['event_start_time'] as String?,
    )..id = json['id'] as String?;

Map<String, dynamic> _$EventGuestListToJson(EventGuestList instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('ticket_unique_number', instance.ticketUniqueNumber);
  writeNotNull('transaction_id', instance.transactionId);
  writeNotNull('event_post_id', instance.eventPostId);
  writeNotNull('total_amount', instance.totalAmount);
  writeNotNull('list_of_ids', instance.listOfId);
  writeNotNull('location_long', instance.locationLong);
  writeNotNull('location_lat', instance.locationLat);
  writeNotNull('ticket', instance.ticket);
  writeNotNull('user_name', instance.userName);
  writeNotNull('title', instance.title);
  writeNotNull('purchase_date', instance.purchaseDate);
  writeNotNull('purchase_time', instance.purchaseTime);
  writeNotNull('event_start_date', instance.eventStartDate);
  writeNotNull('event_start_time', instance.eventStartTime);
  writeNotNull('is_checked_in', instance.isCheckedIn);
  writeNotNull('quantity', instance.quantity);
  return val;
}
