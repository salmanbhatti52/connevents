// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchased-ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PurchasedTicket _$PurchasedTicketFromJson(Map<String, dynamic> json) =>
    PurchasedTicket(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => PurchasedData.fromJson(e))
          .toList(),
      status: json['status'] as String?,
    )..id = json['id'] as String?;

Map<String, dynamic> _$PurchasedTicketToJson(PurchasedTicket instance) {
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

PurchasedData _$PurchasedDataFromJson(Map<String, dynamic> json) =>
    PurchasedData(
      ticketName: json['ticket_name'] as String?,
      status: json['status'] as String?,
      ticketUniqueNumber: json['ticket_unique_number'] as String?,
      transactionId: json['transaction_id'] as int?,
      eventPostId: json['event_post_id'] as int?,
      usersId: json['users_id'] as int?,
      paymentType: json['payment_type'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      quantity: json['quantity'] as int?,
      discount: json['discount'] as int?,
      ticketId: json['ticket_id'] as int?,
      transactionDate: json['transaction_date'] as String?,
      userTicketId: json['user_ticket_id'] as int?,
    )..id = json['id'] as String?;

Map<String, dynamic> _$PurchasedDataToJson(PurchasedData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('user_ticket_id', instance.userTicketId);
  writeNotNull('event_post_id', instance.eventPostId);
  writeNotNull('users_id', instance.usersId);
  writeNotNull('ticket_id', instance.ticketId);
  writeNotNull('quantity', instance.quantity);
  writeNotNull('amount', instance.amount);
  writeNotNull('discount', instance.discount);
  writeNotNull('transaction_date', instance.transactionDate);
  writeNotNull('payment_type', instance.paymentType);
  writeNotNull('status', instance.status);
  writeNotNull('ticket_unique_number', instance.ticketUniqueNumber);
  writeNotNull('transaction_id', instance.transactionId);
  writeNotNull('ticket_name', instance.ticketName);
  return val;
}

EarlyBirdPurchasedTicket _$EarlyBirdPurchasedTicketFromJson(
        Map<String, dynamic> json) =>
    EarlyBirdPurchasedTicket(
      status: json['status'] as String?,
      eventPostId: json['eventPostId'] as int?,
      usersId: json['usersId'] as int?,
      amount: json['amount'] as num? ?? 0,
      quantity: json['quantity'] as int? ?? 0,
      discount: json['discount'] as int?,
      ticketId: json['ticketId'] as int?,
      transactionDate: json['transactionDate'] as String?,
      userTicketId: json['userTicketId'] as int?,
    )..id = json['id'] as String?;

Map<String, dynamic> _$EarlyBirdPurchasedTicketToJson(
    EarlyBirdPurchasedTicket instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('userTicketId', instance.userTicketId);
  writeNotNull('eventPostId', instance.eventPostId);
  writeNotNull('usersId', instance.usersId);
  writeNotNull('ticketId', instance.ticketId);
  val['quantity'] = instance.quantity;
  val['amount'] = instance.amount;
  writeNotNull('discount', instance.discount);
  writeNotNull('transactionDate', instance.transactionDate);
  writeNotNull('status', instance.status);
  return val;
}

RegularPurchasedTicket _$RegularPurchasedTicketFromJson(
        Map<String, dynamic> json) =>
    RegularPurchasedTicket(
      status: json['status'] as String?,
      eventPostId: json['eventPostId'] as int?,
      usersId: json['usersId'] as int?,
      amount: json['amount'] as num? ?? 0,
      quantity: json['quantity'] as int? ?? 0,
      discount: json['discount'] as int?,
      ticketId: json['ticketId'] as int?,
      transactionDate: json['transactionDate'] as String?,
      userTicketId: json['userTicketId'] as int?,
    )..id = json['id'] as String?;

Map<String, dynamic> _$RegularPurchasedTicketToJson(
    RegularPurchasedTicket instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('userTicketId', instance.userTicketId);
  writeNotNull('eventPostId', instance.eventPostId);
  writeNotNull('usersId', instance.usersId);
  writeNotNull('ticketId', instance.ticketId);
  val['quantity'] = instance.quantity;
  val['amount'] = instance.amount;
  writeNotNull('discount', instance.discount);
  writeNotNull('transactionDate', instance.transactionDate);
  writeNotNull('status', instance.status);
  return val;
}

VIPPurchasedTicket _$VIPPurchasedTicketFromJson(Map<String, dynamic> json) =>
    VIPPurchasedTicket(
      status: json['status'] as String?,
      vipQuantity: json['vipQuantity'] as int? ?? 0,
      eventPostId: json['eventPostId'] as int?,
      usersId: json['usersId'] as int?,
      amount: json['amount'] as num? ?? 0,
      quantity: json['quantity'] as int? ?? 0,
      discount: json['discount'] as int?,
      ticketId: json['ticketId'] as int?,
      transactionDate: json['transactionDate'] as String?,
      userTicketId: json['userTicketId'] as int?,
    )..id = json['id'] as String?;

Map<String, dynamic> _$VIPPurchasedTicketToJson(VIPPurchasedTicket instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('userTicketId', instance.userTicketId);
  writeNotNull('eventPostId', instance.eventPostId);
  writeNotNull('usersId', instance.usersId);
  writeNotNull('ticketId', instance.ticketId);
  val['quantity'] = instance.quantity;
  val['vipQuantity'] = instance.vipQuantity;
  val['amount'] = instance.amount;
  writeNotNull('discount', instance.discount);
  writeNotNull('transactionDate', instance.transactionDate);
  writeNotNull('status', instance.status);
  return val;
}

SkippingLinePurchasedTicket _$SkippingLinePurchasedTicketFromJson(
        Map<String, dynamic> json) =>
    SkippingLinePurchasedTicket(
      status: json['status'] as String?,
      skippingQuantity: json['skippingQuantity'] as int? ?? 0,
      eventPostId: json['eventPostId'] as int?,
      usersId: json['usersId'] as int?,
      amount: json['amount'] as num? ?? 0,
      quantity: json['quantity'] as int? ?? 0,
      discount: json['discount'] as int?,
      ticketId: json['ticketId'] as int?,
      transactionDate: json['transactionDate'] as String?,
      userTicketId: json['userTicketId'] as int?,
    )..id = json['id'] as String?;

Map<String, dynamic> _$SkippingLinePurchasedTicketToJson(
    SkippingLinePurchasedTicket instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('userTicketId', instance.userTicketId);
  writeNotNull('eventPostId', instance.eventPostId);
  writeNotNull('usersId', instance.usersId);
  writeNotNull('ticketId', instance.ticketId);
  val['quantity'] = instance.quantity;
  val['skippingQuantity'] = instance.skippingQuantity;
  val['amount'] = instance.amount;
  writeNotNull('discount', instance.discount);
  writeNotNull('transactionDate', instance.transactionDate);
  writeNotNull('status', instance.status);
  return val;
}
