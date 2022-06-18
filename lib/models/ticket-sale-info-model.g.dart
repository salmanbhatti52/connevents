// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket-sale-info-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketSalesModel _$TicketSalesModelFromJson(Map<String, dynamic> json) =>
    TicketSalesModel(
      data: json['data'] == null ? null : TicketSaleInfo.fromJson(json['data']),
      status: json['status'] as String?,
    )..id = json['id'] as String?;

Map<String, dynamic> _$TicketSalesModelToJson(TicketSalesModel instance) {
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

TicketSaleInfo _$TicketSaleInfoFromJson(Map<String, dynamic> json) =>
    TicketSaleInfo(
      totalCheckins: json['total_checkins'] as int?,
      totalTableService: json['total_table_service'] as int?,
      totalReservedTables: json['total_reserved_tables'] as int?,
      checkins: json['checkins'] as int? ?? 0,
      status: json['status'] as String?,
      quantity: json['quantity'] as int?,
      soldTickets: json['sold_tickets'] as int? ?? 0,
      eventPostId: json['event_post_id'] as int?,
      totalQuantity: json['total_quantity'] as int?,
      closingDate: json['closing_date'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      ticket: json['ticket'] as String?,
      ticketId: json['ticket_id'] as int?,
      totalSales: json['total_sales'] as int?,
    )..id = json['id'] as String?;

Map<String, dynamic> _$TicketSaleInfoToJson(TicketSaleInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('ticket_id', instance.ticketId);
  writeNotNull('event_post_id', instance.eventPostId);
  writeNotNull('ticket', instance.ticket);
  writeNotNull('quantity', instance.quantity);
  writeNotNull('total_quantity', instance.totalQuantity);
  writeNotNull('price', instance.price);
  writeNotNull('closing_date', instance.closingDate);
  writeNotNull('status', instance.status);
  writeNotNull('total_sales', instance.totalSales);
  val['sold_tickets'] = instance.soldTickets;
  writeNotNull('total_checkins', instance.totalCheckins);
  val['checkins'] = instance.checkins;
  writeNotNull('total_reserved_tables', instance.totalReservedTables);
  writeNotNull('total_table_service', instance.totalTableService);
  return val;
}
