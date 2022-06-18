// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event-ticket-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventTicket _$EventTicketFromJson(Map<String, dynamic> json) => EventTicket(
      status: json['status'] as String?,
      price: json['price'] as int?,
      event_post_id: json['event_post_id'] as int?,
      regularPurchasedTicket: json['regularPurchasedTicket'] == null
          ? null
          : RegularPurchasedTicket.fromJson(json['regularPurchasedTicket']),
      vipPurchasedTicket: json['vipPurchasedTicket'] == null
          ? null
          : VIPPurchasedTicket.fromJson(json['vipPurchasedTicket']),
      earlyBirdPurchasedTicket: json['earlyBirdPurchasedTicket'] == null
          ? null
          : EarlyBirdPurchasedTicket.fromJson(json['earlyBirdPurchasedTicket']),
      quantity: json['quantity'] as int?,
      ticket: json['ticket'] as String?,
      ticket_id: json['ticket_id'] as int?,
      closing_date: json['closing_date'] as String?,
    )..id = json['id'] as String?;

Map<String, dynamic> _$EventTicketToJson(EventTicket instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('ticket_id', instance.ticket_id);
  writeNotNull('event_post_id', instance.event_post_id);
  writeNotNull('ticket', instance.ticket);
  writeNotNull('quantity', instance.quantity);
  writeNotNull('price', instance.price);
  writeNotNull('status', instance.status);
  writeNotNull('closing_date', instance.closing_date);
  writeNotNull('earlyBirdPurchasedTicket', instance.earlyBirdPurchasedTicket);
  writeNotNull('regularPurchasedTicket', instance.regularPurchasedTicket);
  writeNotNull('vipPurchasedTicket', instance.vipPurchasedTicket);
  return val;
}
