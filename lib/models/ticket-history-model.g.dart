// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket-history-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketHistoryModel _$TicketHistoryModelFromJson(Map<String, dynamic> json) =>
    TicketHistoryModel(
      status: json['status'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => TicketHistoryModel.fromJson(e))
          .toList(),
    )..id = json['id'] as String?;

Map<String, dynamic> _$TicketHistoryModelToJson(TicketHistoryModel instance) {
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

TicketHistoryList _$TicketHistoryListFromJson(Map<String, dynamic> json) =>
    TicketHistoryList(
      locationLong: (json['location_long'] as num?)?.toDouble(),
      amount: (json['amount'] as num?)?.toDouble(),
      locationLat: (json['location_lat'] as num?)?.toDouble(),
      eventTitle: json['event_title'] as String?,
      purchaseDate: json['purchase_date'] as String?,
      purchaseTime: json['purchase_time'] as String?,
      ticketUniqueNumber: json['ticket_unique_number'] as String?,
    )..id = json['id'] as String?;

Map<String, dynamic> _$TicketHistoryListToJson(TicketHistoryList instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('ticket_unique_number', instance.ticketUniqueNumber);
  writeNotNull('event_title', instance.eventTitle);
  writeNotNull('purchase_date', instance.purchaseDate);
  writeNotNull('purchase_time', instance.purchaseTime);
  writeNotNull('location_long', instance.locationLong);
  writeNotNull('location_lat', instance.locationLat);
  writeNotNull('amount', instance.amount);
  return val;
}
