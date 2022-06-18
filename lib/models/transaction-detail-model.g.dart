// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction-detail-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionDetailModel _$TransactionDetailModelFromJson(
        Map<String, dynamic> json) =>
    TransactionDetailModel(
      tableCount: json['tableCount'] as int? ?? 0,
      skippingLinePurchasedTicket: json['skippingLinePurchasedTicket'] == null
          ? null
          : SkippingLinePurchasedTicket.fromJson(
              json['skippingLinePurchasedTicket']),
      paymentType: json['paymentType'] as String?,
      totalPeopleTableServices: json['totalPeopleTableServices'] as int? ?? 0,
      stripeToken: json['stripeToken'] as String?,
      cardId: json['cardId'] as String?,
      totalAmount: json['totalAmount'] as String?,
      amount: json['amount'] as num? ?? 0,
      discount: json['discount'] as String?,
      vipPurchasedTicket: json['vipPurchasedTicket'] == null
          ? null
          : VIPPurchasedTicket.fromJson(json['vipPurchasedTicket']),
      earlyBirdPurchasedTicket: json['earlyBirdPurchasedTicket'] == null
          ? null
          : EarlyBirdPurchasedTicket.fromJson(json['earlyBirdPurchasedTicket']),
      regularPurchasedTicket: json['regularPurchasedTicket'] == null
          ? null
          : RegularPurchasedTicket.fromJson(json['regularPurchasedTicket']),
      eventPostId: json['eventPostId'],
      usersId: json['usersId'] as String?,
    )
      ..id = json['id'] as String?
      ..purchasedTickets = json['purchasedTickets'] as List<dynamic>;

Map<String, dynamic> _$TransactionDetailModelToJson(
    TransactionDetailModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('eventPostId', instance.eventPostId);
  writeNotNull('usersId', instance.usersId);
  writeNotNull('totalAmount', instance.totalAmount);
  writeNotNull('discount', instance.discount);
  writeNotNull('cardId', instance.cardId);
  writeNotNull('stripeToken', instance.stripeToken);
  val['amount'] = instance.amount;
  val['tableCount'] = instance.tableCount;
  writeNotNull('paymentType', instance.paymentType);
  val['totalPeopleTableServices'] = instance.totalPeopleTableServices;
  writeNotNull('earlyBirdPurchasedTicket', instance.earlyBirdPurchasedTicket);
  writeNotNull('regularPurchasedTicket', instance.regularPurchasedTicket);
  writeNotNull('vipPurchasedTicket', instance.vipPurchasedTicket);
  writeNotNull(
      'skippingLinePurchasedTicket', instance.skippingLinePurchasedTicket);
  val['purchasedTickets'] = instance.purchasedTickets;
  return val;
}
