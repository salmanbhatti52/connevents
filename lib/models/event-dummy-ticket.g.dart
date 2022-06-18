// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event-dummy-ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EarlyBird _$EarlyBirdFromJson(Map<String, dynamic> json) => EarlyBird(
      quantity: json['quantity'] as String? ?? "",
      ticketId: json['ticket_id'] as int?,
      eventPostId: json['event_post_id'] as int?,
      isVisible: json['isVisible'] as bool? ?? false,
      earlyBird: json['earlyBird'] as String? ?? '',
      ticket: json['ticket'] as String? ?? "",
      price: json['price'] as String? ?? "",
      closingDate: json['closing_date'] as String? ?? "",
      selectedDate: json['selectedDate'] == null
          ? null
          : DateTime.parse(json['selectedDate'] as String),
    );

Map<String, dynamic> _$EarlyBirdToJson(EarlyBird instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ticket_id', instance.ticketId);
  writeNotNull('event_post_id', instance.eventPostId);
  val['ticket'] = instance.ticket;
  writeNotNull('quantity', instance.quantity);
  writeNotNull('price', instance.price);
  val['closing_date'] = instance.closingDate;
  val['earlyBird'] = instance.earlyBird;
  val['isVisible'] = instance.isVisible;
  val['selectedDate'] = instance.selectedDate.toIso8601String();
  return val;
}

Regular _$RegularFromJson(Map<String, dynamic> json) => Regular(
      quantity: json['quantity'] as String? ?? "",
      isVisible: json['isVisible'] as bool? ?? false,
      ticket: json['ticket'] as String? ?? "",
      price: json['price'] as String? ?? "",
      eventPostId: json['event_post_id'] as int?,
      ticketId: json['ticket_id'] as int?,
    );

Map<String, dynamic> _$RegularToJson(Regular instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ticket_id', instance.ticketId);
  writeNotNull('event_post_id', instance.eventPostId);
  val['ticket'] = instance.ticket;
  writeNotNull('quantity', instance.quantity);
  writeNotNull('price', instance.price);
  val['isVisible'] = instance.isVisible;
  return val;
}

VIP _$VIPFromJson(Map<String, dynamic> json) => VIP(
      quantity: json['quantity'] as String? ?? "",
      isVisible: json['isVisible'] as bool? ?? false,
      ticket: json['ticket'] as String? ?? "",
      price: json['price'] as String? ?? "",
      ticketId: json['ticket_id'] as int?,
      eventPostId: json['event_post_id'] as int?,
    );

Map<String, dynamic> _$VIPToJson(VIP instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ticket_id', instance.ticketId);
  writeNotNull('event_post_id', instance.eventPostId);
  val['ticket'] = instance.ticket;
  writeNotNull('quantity', instance.quantity);
  writeNotNull('price', instance.price);
  val['isVisible'] = instance.isVisible;
  return val;
}

SkippingLine _$SkippingLineFromJson(Map<String, dynamic> json) => SkippingLine(
      quantity: json['quantity'] as String? ?? "",
      isVisible: json['isVisible'] as bool? ?? false,
      ticket: json['ticket'] as String? ?? "",
      price: json['price'] as String? ?? "",
      ticketId: json['ticket_id'] as int?,
      eventPostId: json['event_post_id'] as int?,
    );

Map<String, dynamic> _$SkippingLineToJson(SkippingLine instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ticket_id', instance.ticketId);
  writeNotNull('event_post_id', instance.eventPostId);
  val['ticket'] = instance.ticket;
  writeNotNull('quantity', instance.quantity);
  writeNotNull('price', instance.price);
  val['isVisible'] = instance.isVisible;
  return val;
}
